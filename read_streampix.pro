pro read_streampix, file, data, time, header

;+
; NAME:
;   READ_STEAMPIX
;
; PURPOSE:
;   Reads StreamPix "sequence" (.seq) file.  These are binary video files.
;
; CATEGORY:
;   Cameras and detectors.
;
; CALLING SEQUENCE:
;   READ_STREAMPIX, File, Data, Time, Header
;
; INPUTS:
;   File: The name of the StreamPix sequence file
;
; OUTPUTS:
;   Data:   The video data as a 3-D array (imageWidth, imageHeight, nFrames)
;
;   Time:   An double precision array (nFrames) containing the timestamps for each frame.
;           The timestamps are seconds since the Epoch (00:00:00 UTC, January 1, 1970),
;           and have millisecond precision.
;
;   Header: A structure of type {STREAMPIX_HEADER} that contains information about the video data.
;
; RESTRICTIONS:
;   The current version of this procedure only handles 8-bit monochrome data.
;   It should be extended to support the other StreamPix data types.
;
; EXAMPLE:
;   IDL> read_streampix, 'sequence4.seq', data, time, header
;   IDL> window, 0, xsize=header.imageWidth, ysize=header.imageHeight
;   IDL> tvscl, data[*,*,0]
;
; MODIFICATION HISTORY:
;   Written by:  Mark Rivers, October 12, 2007
;-

    openr, lun, /get, file

    header = {streampix_header}
    readu, lun, header

    data = bytarr(header.imageWidth, header.imageHeight, header.allocatedFrame)
    temp = data[*,*,0]
    time = dblarr(header.allocatedFrame)

    for i=0, header.allocatedFrame-1 do begin
        readu, lun, temp
        point_lun, -lun, pointer
        data[0,0,i] = temp
        seconds = 0UL
        milliseconds = 0US
        readu, lun, seconds, milliseconds
        time[i] = double(seconds) + double(milliseconds)/1000.
        point_lun, lun, pointer + header.trueImageSize - header.imageSizeBytes
    endfor
    free_lun, lun

end
