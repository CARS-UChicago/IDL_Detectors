function decode_falcon_buffers, bufferData

;+
; NAME:
;   DECODE_FALCON_BUFFERS
;
; PURPOSE:
;   This function parses the buffers collected with the XIA Falcon modules in MCA mapping mode.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   Data = DECODE_FALCON_BUFFERS(BufferData)
;
; INPUTS:
;   BufferData:
;       An array containing the buffer data.  This array will typically have been read with the READ_ND_NETCDF
;       function, but it could also have been created in other ways.  This array is of type INT, i.e. 16-bit
;       data.  Its dimensions are [BufferSize, NumChannels, NumArrays].  
;       NumArrays is the number of arrays that were collected.  
;       NumChannels is the number of detectors in the system (i.e. 1, 2, 4, etc.)
;       BufferSize is the size of each buffer that was read from the Falcon.
;
; OUTPUTS:
;       This function returns a structure with the decoded data from the buffer array.  The structure
;       definition depends on the mapping mode that was used to collect the data.  
;
;       In MCA mapping mode the structure is the following:
;           FalconData = {FalconData, $
;               firstPixel:    0L,        $
;               numPixels:     0L,        $
;               pData:         ptr_new(), $
;               pRealTime:     ptr_new(), $
;               pLiveTime:     ptr_new(), $
;               pInputCounts:  ptr_new(), $
;               pOutputCounts: ptr_new() $
;           }
;           firstPixel is the number of the first pixel in the first array
;           numPixels is the total number of pixels in the output arrays
;           pData is a pointer to the MCA spectra array.
;           The dimensions of this array in MCA mapping mode is [numChannels, numDetectors, numPixels] 
;           pRealTime is a pointer to an array of real time at each pixel, [numDetectors, numPixels] 
;           pLiveTime is a pointer to an array of live time at each pixel, [numDetectors, numPixels] 
;           pInputCounts is a pointer to an array of trigger counts at each pixel, [numDetectors, numPixels] 
;           pOutputCounts is a pointer to an array of event counts at each pixel, [numDetectors, numPixels] 
;
;
; EXAMPLES:
;   This is an example of decoding the buffers for MCA mapping mode data:
;   IDL> buff = read_nd_netcdf('mca_mapping_001.nc')
;   IDL> help, buff
;   BUFF            INT       = Array[1047808, 4, 9]
;   IDL> d = decode_xmap_buffers(buff)
;   IDL> help, /structure, d
;   ** Structure XMAPDATA, 7 tags, length=28, data length=28:
;      FIRSTPIXEL      LONG                 0
;      NUMPIXELS       LONG              1000
;      PDATA           POINTER   <PtrHeapVar3>
;      PREALTIME       POINTER   <PtrHeapVar4>
;      PLIVETIME       POINTER   <PtrHeapVar5>
;      PINPUTCOUNTS    POINTER   <PtrHeapVar6>
;      POUTPUTCOUNTS   POINTER   <PtrHeapVar7>
;   IDL> help, *d.pData     
;   <PtrHeapVar3>   INT       = Array[2048, 16, 1116]
;   IDL> help, *d.pRealTime
;   <PtrHeapVar4>   FLOAT     = Array[16, 1116]
;
;
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, May 10, 2017
;-

    bh = {FalconBufferHeader, $
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
        channelID:       0,  $
        channelElement:  0,  $
        reserved1:       intarr(6), $
        channelSize:     0,  $
        reserved2:       intarr(3), $
        bufferErrors:    0  $
    }

    mph = {FalconMCAPixelHeader, $
        tag0:            0,  $ ; Tag word 0
        tag1:            0,  $ ; Tag word 1
        headerSize:      0,  $ ; Buffer header size
        mappingMode:     0,  $ ; Mapping mode (1=Full spectrum, 2=Multiple ROI, 3=List mode)
        pixelNumber:     0L, $ ; Pixel number
        blockSize:       0L, $ ; Total pixel block size, low word first
        spectrumSize:    0   $
    }

    FalconData = {FalconData, $
        firstPixel:    0L,        $
        numPixels:     0L,        $
        pData:         ptr_new(), $
        pRealTime:     ptr_new(), $
        pLiveTime:     ptr_new(), $
        pInputCounts:  ptr_new(), $
        pOutputCounts: ptr_new() $
    }

    ; The number of buffers is the second dimension of d if there is one

    ; Data is normally 2D, [bufferSize, nArrays], but nArrays can be 1
    ; so it could be as little as 1D
    s = size(bufferData, /dimensions)
    nDimensions = n_elements(s)
    bufferSize = s[0]
    nDetectors = 1
    if (nDimensions gt 1) then nDetectors = s[1]
    nArrays = 1
    if (nDimensions gt 2) then nArrays = s[2]
    maxPixels = 0L
    nPixels = 0L
    clockPeriod = 320e-9
    firstTime = 1
    maxPixelsPerBuffer = 0L

    for array=0, nArrays-1 do begin
        for detector=0, nDetectors-1 do begin
            ; Copy the buffer header information
            d = bufferData[*, detector, array]
            bh.tag0           = d[0]
            bh.tag1           = d[1]
            bh.headerSize     = d[2]
            bh.mappingMode    = d[3]
            bh.runNumber      = d[4]
            bh.bufferNumber   = long(d, 5*2)
            bh.bufferID       = d[7]
            bh.numPixels      = d[8]
            bh.startingPixel  = long(d, 9*2)
            if (array eq 0) then firstPixel = bh.startingPixel
            bh.moduleNumber   = d[11]
            bh.channelID      = d[12]
            bh.channelElement = d[13]
            bh.channelSize    = d[20]
            bh.bufferErrors   = d[24]

            case bh.mappingMode of
            1: begin  ; MCA mapping
                offset = 256L
                ; It is possible that each buffer has a different number
                ; of pixels.  Use the value in the first buffer as the
                ; maximum for all buffers
                if (maxPixelsPerBuffer eq 0) then maxPixelsPerBuffer = long(bh.numPixels)
                nPix = bh.numPixels < maxPixelsPerBuffer
                if (detector eq 0) then nPixels += nPix
                for pixel=0, nPix-1 do begin
                    pn = array * maxPixelsPerBuffer + pixel
                    mph.tag0        = d[offset + 0]
                    mph.tag1        = d[offset + 1]
                    mph.headerSize  = d[offset + 2]
                    mph.mappingMode = d[offset + 3]
                    mph.pixelNumber = long(d, (offset + 4)*2)
                    ; The following assumes that the netCDF file is one single xMAP run
                    ; But that may not be true, so ignore the pixelNumber value
                    ;pn = mph.pixelNumber - firstPixel
                    ; Instead set it as above, which also handles case of different number of pixels in
                    ; each buffer
                    mph.blockSize   = long(d, (offset + 6)*2)
                    ; The spectrum size appears to be in units of 16-bit words
                    mph.spectrumSize = d[offset + 8] / 2
                    if (firstTime) then begin
                        firstTime = 0
                        nChannels = mph.spectrumSize
                        maxPixels = maxPixelsPerBuffer * nArrays
                        data      = lonarr(nChannels, nDetectors, maxPixels)
                        realTime     = fltarr(nDetectors, maxPixels)
                        liveTime     = fltarr(nDetectors, maxPixels)
                        inputCounts  = lonarr(nDetectors, maxPixels)
                        outputCounts = lonarr(nDetectors, maxPixels)
                    endif
                    p = offset + 32
                    realTime[detector, pn]     = long(d, (p +  0)*2)*clockPeriod
                    liveTime[detector, pn]     = long(d, (p +  2)*2)*clockPeriod
                    inputCounts[detector, pn]  = long(d, (p +  4)*2)
                    outputCounts[detector, pn] = long(d, (p +  6)*2)
                    p = offset + 256
                    data[0, detector, pn] = long(d, p*2, nChannels)
                    offset += mph.blockSize
                endfor
            end
            endcase
        endfor  ; Detector loop
    endfor  ; Array loop

    if (bh.mappingMode ne 3) then begin
        FalconData.firstPixel    = firstPixel
        FalconData.numPixels     = nPixels
        FalconData.pData         = ptr_new(data, /no_copy)
        FalconData.pRealTime     = ptr_new(realTime, /no_copy)
        FalconData.pLiveTime     = ptr_new(liveTime, /no_copy)
        FalconData.pInputCounts  = ptr_new(inputCounts, /no_copy)
        FalconData.pOutputCounts = ptr_new(outputCounts, /no_copy)
        return, FalconData
   endif

end


