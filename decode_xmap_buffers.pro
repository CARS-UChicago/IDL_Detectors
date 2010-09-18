function decode_xmap_buffers, bufferData

    bh = {xMAPBufferHeader, $
        tag0:            0,  $ ; Tag word 0
        tag1:            0,  $ ; Tag word 1
        headerSize:      0,  $ ; Buffer header size
        mappingMode:     0,  $ ; Mapping mode (1=Full spectrum, 2=Multiple ROI, 3=List mode)
        runNumber:       0,  $ ; Run number
        bufferNumber:    0L, $ ; Sequential buffer number, low word first
        bufferID:        0,  $ ; 0=A, 1=B
        numPixels:       0,  $ ; Number of pixels in buffer
        startingPixel:   0L, $ ; Starting pixel number, low word first
        moduleNumber:    0,  $
        channelID:       intarr(2,4),$
        channelSize:     intarr(4),  $
        bufferErrors:    0,  $
        userDefined:     intarr(32) $
    }

    mph = {xMAPMCAPixelHeader, $
        tag0:            0,  $ ; Tag word 0
        tag1:            0,  $ ; Tag word 1
        headerSize:      0,  $ ; Buffer header size
        mappingMode:     0,  $ ; Mapping mode (1=Full spectrum, 2=Multiple ROI, 3=List mode)
        pixelNumber:     0L, $ ; Pixel number
        blockSize:       0L, $ ; Total pixel block size, low word first
        channelSize:     intarr(4)  $
    }

    xMAPData = {xMAPData, $
        firstPixel:    0L,        $
        numPixels:     0L,        $
        pData:         ptr_new(), $
        pRealTime:     ptr_new(), $
        pLiveTime:     ptr_new(), $
        pInputCounts:  ptr_new(), $
        pOutputCounts: ptr_new() $
    }

    ; The number of buffers is the second dimension of d if there is one

    ; Data is normally 3D, [bufferSize, nModules, nArrays], but nModules and nArrays can be 1
    ; so it could be as little as 1D
    s = size(bufferData, /dimensions)
    nDimensions = n_elements(s)
    bufferSize = s[0]
    nModules = 1
    if (nDimensions gt 1) then nModules = s[1]
    nDetectors = nModules * 4
    nArrays = 1
    if (nDimensions gt 2) then nArrays = s[2]
    maxPixels = 0L
    nPixels = 0L
    clockPeriod = 320e-9
    firstTime = 1
    maxPixelsPerBuffer = 0L

    for array=0, nArrays-1 do begin
        for module=0, nModules-1 do begin
            ; Copy the buffer header information
            d = bufferData[*, module, array]
            bh.tag0           = d[0]
            bh.tag1           = d[1]
            bh.headerSize     = d[2]
            bh.mappingMode    = d[3]
            bh.runNumber      = d[4]
            bh.bufferNumber   = long(d, 5*2)
            bh.bufferID       = d[7]
            bh.numPixels      = d[8]
            bh.startingPixel  = long(d,9*2)
            if (array eq 0) then firstPixel = bh.startingPixel
            bh.moduleNumber   = d[11]
            bh.channelID      = reform(d[12:19], 2, 4)
            bh.channelSize    = d[20:23]
            bh.bufferErrors   = d[24]
            bh.userDefined    = d[32:63]
            offset = 256
            ; It is possible that each buffer has a different number
            ; of pixels.  Use the value in the first buffer as the
            ; maximum for all buffers
            if (maxPixelsPerBuffer eq 0) then maxPixelsPerBuffer = long(bh.numPixels)
            nPix = bh.numPixels < maxPixelsPerBuffer
            if (module eq 0) then nPixels += nPix
            for pixel=0, nPix-1 do begin
                pn = array * maxPixelsPerBuffer + pixel
                mph.tag0        = d[offset + 0]
                mph.tag1        = d[offset + 1]
                mph.headerSize  = d[offset + 2]
                mph.mappingMode = d[offset + 3]
                mph.pixelNumber = long(d, (offset+4)*2)
                ; The following assumes that the netCDF file is one single xMAP run
                ; But that may not be true, so ignore the pixelNumber value
                ;pn = mph.pixelNumber - firstPixel
                ; Instead set it as above, which also handles case of different number of pixels in
                ; each buffer
                mph.blockSize   = long(d, (offset+6)*2)
                if (mph.mappingMode eq 1) then begin
                    if (firstTime) then begin
                        firstTime = 0
                        nChannels = bh.channelSize[0]
                        maxPixels = maxPixelsPerBuffer * nArrays
                        data      = intarr(nChannels, nDetectors, maxPixels)
                        realTime     = fltarr(nDetectors, maxPixels)
                        liveTime     = fltarr(nDetectors, maxPixels)
                        inputCounts  = lonarr(nDetectors, maxPixels)
                        outputCounts = lonarr(nDetectors, maxPixels)
                    endif
                    mph.channelSize = d[offset+8:offset+11]
                    ; We assume all spectra have the same number of channels.  Currently correct.
                    nChans = mph.channelSize[0]
                    for det=0, 3 do begin
                        p = offset + 32
                        detector = module*4 + det
                        realTime[detector, pn]     = long(d, (p + det*8 + 0)*2)*clockPeriod
                        liveTime[detector, pn]     = long(d, (p + det*8 + 2)*2)*clockPeriod
                        inputCounts[detector, pn]  = long(d, (p + det*8 + 4)*2)
                        outputCounts[detector, pn] = long(d, (p + det*8 + 6)*2)
                        p = offset + 256
                        data[0, detector, pn] = d[p + det*nChans : p + ((det+1)*nChans)-1]
                    endfor
                    offset += mph.blockSize
                endif else if (mph.mappingMode eq 2) then begin
                    if (firstTime) then begin
                        firstTime = 0
                        nROIs = 0
                        for det=0, 3 do begin
                           temp = d[offset + 8 + det]
                           if (temp gt nROIs) then nROIs = temp
                        endfor
                        maxPixels = long(bh.numPixels) * nArrays
                        data      = lonarr(nROIs, nDetectors, maxPixels)
                        realTime     = fltarr(nDetectors, maxPixels)
                        liveTime     = fltarr(nDetectors, maxPixels)
                        inputCounts  = lonarr(nDetectors, maxPixels)
                        outputCounts = lonarr(nDetectors, maxPixels)
                    endif
                    p2 = offset + 64
                    for det=0, 3 do begin
                        p = offset + 32
                        numROI = d[offset + 8 + det]
                        detector = module*4 + det
                        realTime[detector, pn]     = long(d, (p + det*8 + 0)*2)*clockPeriod
                        liveTime[detector, pn]     = long(d, (p + det*8 + 2)*2)*clockPeriod
                        inputCounts[detector, pn]  = long(d, (p + det*8 + 4)*2)
                        outputCounts[detector, pn] = long(d, (p + det*8 + 6)*2)
                        data[0, detector, pn] = long(d, p2*2, numROI)
                        p2 += numROI*2
                    endfor
                    offset += mph.blockSize
                endif
            endfor
        endfor
    endfor
    xMAPData.firstPixel    = firstPixel
    xMAPData.numPixels     = nPixels
    xMAPData.pData         = ptr_new(data, /no_copy)
    xMAPData.pRealTime     = ptr_new(realTime, /no_copy)
    xMAPData.pLiveTime     = ptr_new(liveTime, /no_copy)
    xMAPData.pInputCounts  = ptr_new(inputCounts, /no_copy)
    xMAPData.pOutputCounts = ptr_new(outputCounts, /no_copy)

    return, xMAPData
end


