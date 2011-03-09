function read_xmap_2d, base_file, ny, $
                       live_time=live_time, real_time=real_time, $
                       triggers=triggers, events=events, $
                       xRange=xRange, yRange=yRange, $
                       channelRange=channelRange, detectorRange=detectorRange

;+
; NAME:
;   READ_XMAP_2D
;
; PURPOSE:
;   This function reads a series of MCA mapping netCDF files written by the DXP mapping mode software.
;   The data are assumed to be 1 file for each row of a 2-D scan, with file names base_name + num + '.nc'.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   Data = READ_XMAP_2D(base_file, nY, $
;                       live_time=live_time, real_time=real_time, $
;                       triggers=triggers, events=events, $
;                       xRange=xRange, yRange=yRange, $
;                       channelRange=channelRange, detectorRange=detectorRange)
;
; INPUTS:
;   base_file:
;       The base name of the input files. The files are assumed to be named base_file + num + '.nc', where
;       num goes from 1 to nY and .nc is the file extension for netCDF files
;   nY:
;       The number of Y points in the scan, i.e. the number of netCDF mapping files.
;
; KEYWORD INPUTS:
;    xRange:        Used to optionally restrict the returned data to only a specific range of pixels in the 
;                   X (fast) direction. The default is to return all pixels in that direction.  
;                   Example: xRange=[100,200].
;   yRange:         Used to optionally restrict the returned data to only a specific range of pixels in the 
;                   Y (slow) direction. The default is to return all pixels in that direction.  
;                       Example: yRange=[100,200].
;   channelRange:   Used to optionally restrict the returned data to only a specific range of MCA channels.
;                   The default is to return all MCAchannels.  This is very useful for extracting the data 
;                   for a specific ROI from the data, for example the counts around the Zn K-alpha peak.  
;                   Example: channelRange=[680,720].
;   detectorRange:  Used to optionally restrict the returned data to only a specific range of detectors.
;                   The default is to return all detectors.  
;                   Example: detectorRange=[5,5] will return the data for detector 5 only.
; OUTPUTS:
;   By default this function returns a 4-D array [nChannels, nDetectors, nX, nY], i.e. the MCA counts for 
;   each detector, at each X and Y pixel in the scan.  This can be an enormous amount of data!  
;   The amount of data returned by the function can be restricted with the input keywords described above.
;
; KEYWORD OUTPUTS:
;   live_time:  The live time for each detector at each pixel in the scan
;   real_time:  The real time for each detector at each pixel in the scan
;   triggers :  The number of triggers (input counts) for each detector at each pixel in the scan
;   events:     The number of events (output counts) for each detector at each pixel in the scan
;
; EXAMPLE:
;   The following is an IDL program that calls read_xmap_2d for a 501x500 scan of a Ni mesh.  
;   It extracts the Ni Ka peak (channels 716 to 776) from the data.  
;   It sums over all the channels in this region, normalizes by live time, sums over all 7 detectors, and 
;   finally displays the image with the IDL iTools iimage procedure.
;       ; Read data, only channels 716 to 776
;       d = read_xmap_2d('Scan4_', 501, live_time=live_time, real_time=real_time, events=events, $
;                        triggers=triggers, channel=[716,776])
;       ; Sum over channels 716 to 776 (first dimension)
;       tot = total(d, 1)
;       ; Divide by live time for each detector for each pixel, but live=0 increase to .001
;       tot1 = tot/(live_time>.001)
;       ; Sum over the detectors
;       tot2 = total(tot1, 1)
;       ; Display
;       iimage, tot2
;   end
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, September 2010

;-    ; Read the first file to get the dimensions
    file = base_file + strtrim(1,2) + '.nc'
    d = read_xmap_netcdf(file)
    size = size(*d.pdata, /dimensions)
    nchannels = size[0]
    ndetectors = size[1]
    firstX = 0
    lastX = d.numPixels-1
    firstY = 0
    lastY = ny - 1
    firstChannel = 0
    lastChannel = nchannels-1
    firstDetector = 0
    lastDetector = ndetectors-1
    if (n_elements(xRange) eq 2) then begin
        firstX = xRange[0]
        lastX  = xRange[1]
    endif
    if (n_elements(yRange) eq 2) then begin
        firstY = yRange[0]
        lastY  = yRange[1]
    endif
    if (n_elements(channelRange) eq 2) then begin
        firstChannel = channelRange[0]
        lastChannel  = channelRange[1]
    endif
    if (n_elements(detectorRange) eq 2) then begin
        firstDetector = detectorRange[0]
        lastDetector  = detectorRange[1]
    endif
    nchannels = lastChannel - firstChannel + 1
    ndetectors = lastDetector - firstDetector + 1
    nx = lastX - firstX + 1
    ny = lastY - firstY + 1
    data = intarr(nchannels, ndetectors, nx, ny)
    real_time = fltarr(ndetectors, nx, ny)
    live_time = fltarr(ndetectors, nx, ny)
    triggers = lonarr(ndetectors, nx, ny)
    events = lonarr(ndetectors, nx, ny)
    j = 0
    for i=firstY, lastY do begin
        file = base_file + strtrim(i+1,2) + '.nc'
        print, file
        d = read_xmap_netcdf(file)
        real_time[0,0,j] = (*d.pRealTime)[firstDetector:lastDetector,firstX:lastX]
        live_time[0,0,j] = (*d.pLiveTime)[firstDetector:lastDetector,firstX:lastX]
        triggers[0,0,j]  = (*d.pInputCounts)[firstDetector:lastDetector,firstX:lastX]
        events[0,0,j]    = (*d.pOutputCounts)[firstDetector:lastDetector,firstX:lastX]
        data[0,0,0,j] = (*d.pdata)[firstChannel:lastChannel,firstDetector:lastDetector,firstX:lastX]
        ptr_free, d.pdata
        ptr_free, d.prealtime
        ptr_free, d.plivetime
        ptr_free, d.pinputcounts
        ptr_free, d.poutputcounts
        d=0
        j = j+1
    endfor
    return, data
end
