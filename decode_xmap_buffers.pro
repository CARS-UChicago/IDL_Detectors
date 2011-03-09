function decode_xmap_buffers, bufferData

;+
; NAME:
;   DECODE_XMAP_BUFFERS
;
; PURPOSE:
;   This function parses the buffers collected with the XIA xMAP or Mercury modules in one of the mapping modes.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   Data = DECODE_XMAP_BUFFERS(BufferData)
;
; INPUTS:
;   BufferData:
;       An array containing the buffer data.  This array will typically have been read with the READ_ND_NETCDF
;       function, but it could also have been created in other ways.  This array is of type INT, i.e. 16-bit
;       data.  Its dimensions are [NumArrays, NumModules, BufferSize].  NumArrays is the number of arrays
;       that were collected.  NumModules is the number of xMAP modules in the system.  BufferSize is the size
;       of each buffer that was read from the xMAP.
;
; OUTPUTS:
;       This function returns a structure with the decoded data from the buffer array.  The structure
;       definition depends on the mapping mode that was used to collect the data.  
;
;       In MCA mapping and SCA mapping modes the structure is the following:
;           xMAPData = {xMAPData, $
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
;           pData is a pointer to the MCA spectra (MCA mapping mode) or SCA counts (SCA mapping mode) array.
;           The dimensions of this array in MCA mapping mode is [numChannels, numDetectors, numPixels] 
;           The dimensions of this array in SCA mapping mode is [numSCAs, numDetectors, numPixels] 
;           pRealTime is a pointer to an array of real time at each pixel, [numDetectors, numPixels] 
;           pLiveTime is a pointer to an array of live time at each pixel, [numDetectors, numPixels] 
;           pInputCounts is a pointer to an array of trigger counts at each pixel, [numDetectors, numPixels] 
;           pOutputCounts is a pointer to an array of event counts at each pixel, [numDetectors, numPixels] 
;
;       In List mapping mode the structure is the following:
;           xMAPListData = {xMAPListData, $
;               listMode:      0L,        $
;               pData:         ptr_new(), $
;               pPixelClock:   ptr_new(), $
;               pNumEvents:    ptr_new(), $
;               pRealTime:     ptr_new(), $
;               pLiveTime:     ptr_new(), $
;               pInputCounts:  ptr_new(), $
;               pOutputCounts: ptr_new() $
;           }
;           listMode is the list mode variant (Gate, Sync, or Clock) of this data
;           pData is a pointer to the event mode data array.
;           The dimensions of this array is [maxEvents*numArrays, numModules].  This array
;           contains the energy of each event in bits 0-12, and the detector number (0-3) in bits 13-14.
;           pPixelClock is a point to an array of pixel clock information.  In Gate or Sync variants this
;           is the pixel number of each event.  In Clock variant this is the clock time in ticks of the 50MHz
;           system clock since acquisition was started.  Dimensions = [maxEvents*numArrays, numModules]
;           pNumEvents is a pointer to an array containing the number of actual events in each the first
;           dimension of the pData array for each module. Dimensions = [numDetectors, numArrays]
;           pRealTime is a pointer to an array of real time at each pixel, [numDetectors, numArrays] 
;           pLiveTime is a pointer to an array of live time at each pixel, [numDetectors, numArrays] 
;           pInputCounts is a pointer to an array of trigger counts at each pixel, [numDetectors, numArrays] 
;           pOutputCounts is a pointer to an array of event counts at each pixel, [numDetectors, numArrays] 
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
;   This is an example of decoding the buffers for SCA mapping mode data:
;   IDL> buff = read_nd_netcdf('sca_mapping_001.nc')
;   IDL> help, buff                                 
;   BUFF            INT       = Array[1048320, 4]
;   IDL> d = decode_xmap_buffers(buff)              
;   IDL> help, /structure, d                        
;   ** Structure XMAPDATA, 7 tags, length=28, data length=28:
;      FIRSTPIXEL      LONG                 0
;      NUMPIXELS       LONG              1000
;      PDATA           POINTER   <PtrHeapVar10>
;      PREALTIME       POINTER   <PtrHeapVar11>
;      PLIVETIME       POINTER   <PtrHeapVar12>
;      PINPUTCOUNTS    POINTER   <PtrHeapVar13>
;      POUTPUTCOUNTS   POINTER   <PtrHeapVar14>
;   IDL> help, *d.pData                             
;   <PtrHeapVar10>  LONG      = Array[8, 16, 1000]
;   IDL> help, *d.pRealTime                         
;   <PtrHeapVar11>  FLOAT     = Array[16, 1000]
;
;   This is an example of decoding the buffers for List Sync mode data:
;   IDL> buff = read_nd_netcdf('list_mapping_sync_001.nc')
;   IDL> help, buff                                       
;   BUFF            INT       = Array[1048576, 4]
;   IDL> d = decode_xmap_buffers(buff)                    
;   IDL> help, /structure, d                              
;   ** Structure XMAPLISTDATA, 8 tags, length=32, data length=32:
;      LISTMODE        LONG                 1
;      PDATA           POINTER   <PtrHeapVar17>
;      PPIXELCLOCK     POINTER   <PtrHeapVar18>
;      PNUMEVENTS      POINTER   <PtrHeapVar19>
;      PREALTIME       POINTER   <PtrHeapVar20>
;      PLIVETIME       POINTER   <PtrHeapVar21>
;      PINPUTCOUNTS    POINTER   <PtrHeapVar22>
;      POUTPUTCOUNTS   POINTER   <PtrHeapVar23>
;   IDL> help, *d.pData                                   
;   <PtrHeapVar17>  INT       = Array[349525, 4]
;   IDL> help, *d.pPixelClock
;   <PtrHeapVar18>  LONG      = Array[349525, 4]
;   IDL> help, *d.pRealTime
;   <PtrHeapVar20>  FLOAT     = Array[16]
;   IDL> h = histogram((*d.pData) and 8191)
;   IDL> iplot, h, yrange=[1,1e3], /ylog
;
;   This is an example of decoding the buffers for List Sync mode data:
;   IDL> buff = read_nd_netcdf('list_mapping_clock_001.nc')
;   IDL> help, buff                                        
;   BUFF            INT       = Array[1048576, 4]
;   IDL> d = decode_xmap_buffers(buff)                     
;   IDL> help, /structure, d                               
;   ** Structure XMAPLISTDATA, 8 tags, length=32, data length=32:
;      LISTMODE        LONG                 2
;      PDATA           POINTER   <PtrHeapVar23647>
;      PPIXELCLOCK     POINTER   <PtrHeapVar23648>
;      PNUMEVENTS      POINTER   <PtrHeapVar23649>
;      PREALTIME       POINTER   <PtrHeapVar23650>
;      PLIVETIME       POINTER   <PtrHeapVar23651>
;      PINPUTCOUNTS    POINTER   <PtrHeapVar23652>
;      POUTPUTCOUNTS   POINTER   <PtrHeapVar23653>
;   IDL> print, (*d.pPixelClock)[0:49]
;          16597       16597       16597       21414       21414       21414
;          58937       58937       58937       63590       63590       63590
;          86560       86560       86560      106343      106343      106343
;         114362      114362      114362      120760      120760      120760
;         135015      135015      135015      157845      174007      174007
;         174007      174845      174845      193928      193928      193928
;         198542      225748      225748      225748      238293      238293
;         238293      281407      344284      349105      349105      349105
;         355190      355190
; The above are the pixel clock values in units of 20 ns ticks
; IDL> print, (*d.pData)[0:49]      
;       9735   17934   26123    9746   17946   26134    9748   17948   26138 26322
;       9934   18135    9735   17935   26118   17947   26135    9745    8477 16671
;      24861    9939   18141   26328   26105    9716   17918    1476   17920 26105
;       9719    9745   17946    9745   17946   26133    1308    9745   17946 26134
;      26108    9720   17921    1470    1474    9718   17919   26106    9753 17958
; The above are the energy values of the first 50 events.  Bits 13-14 contain the detector number
; IDL> print, (*d.pData)[0:49] and 8191
;       1543    1550    1547    1554    1562    1558    1556    1564    1562    1746
;       1742    1751    1543    1551    1542    1563    1559    1553     285      87
;        285    1747    1757    1752    1529    1524    1534    1476    1536    1529
;       1527    1553    1562    1553    1562    1557    1308    1553    1562    1558
;       1532    1528    1537    1470    1474    1526    1535    1530    1561    1574
; The above are the energy values of the first 50 events with bits 13-14 masked off.
;
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, July 2010
;-

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
        bufferWords:     0L, $
        userDefined:     intarr(32), $
        listMode:        0, $
        wordsPerEvent:   0, $
        totalEvents:     0L, $
        specialRecords:  0L $
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

    xMAPListData = {xMAPListData, $
        listMode:      0L,        $
        pData:         ptr_new(), $
        pPixelClock:   ptr_new(), $
        pNumEvents:    ptr_new(), $
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
    numEvents = lonarr(nModules)
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
            bh.bufferWords    = long(d, 25*2)
            bh.userDefined    = d[32:63]

            case bh.mappingMode of
            1: begin  ; MCA mapping
                offset = 256L
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
                endfor
            end

            2: begin  ; SCA mapping
                offset = 256L
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
                endfor
            end

            3: begin  ; List mapping
                if (firstTime) then begin
                    firstTime = 0
                    maxPixels = nArrays
                    ; The maximum number of events in a module is the buffer size divided by 3
                    ; because each event requires 3 words
                    maxEvents   = (2L^20)/3
                    data         = intarr(maxEvents * nArrays, nModules)
                    pixelClock   = lonarr(maxEvents * nArrays, nModules)
                    realTime     = fltarr(nDetectors, maxPixels)
                    liveTime     = fltarr(nDetectors, maxPixels)
                    inputCounts  = lonarr(nDetectors, maxPixels)
                    outputCounts = lonarr(nDetectors, maxPixels)
                    firstEvent   = lonarr(nDetectors, maxPixels)
                    clockTime    = lonarr(nDetectors, maxPixels)
                endif
                bh.listMode       = d[64]
                bh.wordsPerEvent  = d[65]
                bh.totalEvents    = long(d, 66*2)
                offset = 68
                for channel=0, 3 do begin
                    detector = array*4 + channel
                    pixel = array
                    outputCounts[detector, pixel] = long(d, offset*2)
                    offset+=2
                    firstEvent[detector, pixel]   = long(d, offset*2)
                    offset+=2
                    clockTime[detector, pixel]    = long(d, offset*2)
                    offset+=2
                    inputCounts[detector, pixel]  = long(d, offset*2)
                    offset+=2
                    liveTime[detector, pixel]     = long(d, offset*2)*clockPeriod
                    offset+=2
                    realTime[detector, pixel]     = long(d, offset*2)*clockPeriod
                    offset+=2
                endfor
                bh.specialRecords = long(d, 116*2)
                offset = 256L
                event = numEvents[module]
                for i=0L, bh.totalEvents-1 do begin
                    energy = d[offset]
                    offset++
                    if (energy and '8000'x) then begin
                        ; Special records - not handled yet
                    endif
                    data[event, module] = energy
                    pixelClock[event, module] = long(d, offset*2)
                    offset += 2
                    event++
                endfor
                numEvents[module] = event
            end
            endcase
        endfor  ; Module loop
    endfor  ; Array loop

    if (bh.mappingMode ne 3) then begin
        xMAPData.firstPixel    = firstPixel
        xMAPData.numPixels     = nPixels
        xMAPData.pData         = ptr_new(data, /no_copy)
        xMAPData.pRealTime     = ptr_new(realTime, /no_copy)
        xMAPData.pLiveTime     = ptr_new(liveTime, /no_copy)
        xMAPData.pInputCounts  = ptr_new(inputCounts, /no_copy)
        xMAPData.pOutputCounts = ptr_new(outputCounts, /no_copy)
        return, xMAPData
   endif else begin
        xMAPListData.listMode      = bh.listMode
        xMAPListData.pData         = ptr_new(data, /no_copy)
        xMAPListData.pPixelClock   = ptr_new(pixelClock, /no_copy)
        xMAPListData.pNumEvents    = ptr_new(numEvents, /no_copy)
        xMAPListData.pRealTime     = ptr_new(realTime, /no_copy)
        xMAPListData.pLiveTime     = ptr_new(liveTime, /no_copy)
        xMAPListData.pInputCounts  = ptr_new(inputCounts, /no_copy)
        xMAPListData.pOutputCounts = ptr_new(outputCounts, /no_copy)
        return, xMAPListData
   endelse

end


