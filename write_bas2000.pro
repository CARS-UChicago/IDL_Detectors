pro write_bas2000, array, file

;+
; NAME:
;   WRITE_BAS2000
;
; PURPOSE:
;   This procedure writes an 8 bit data file in BAS2000 format. It can then
;   be sent to the BAS2000 printer, although colors are a problem.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   WRITE_BAS2000, Data, File
;
; INPUTS:
;   Data:  
;       An 8-bit array of data.  The first dimension must be 1024 or 2048
;       and the second dimension must be 1280, 2048 or 4096.
;
;   File:
;       The name of the output file without the '.inf' or '.img' extensions
;
; SIDE EFFECTS:
;   This procedure creates  File.inf and File.img, which the scanner software
;   can then read.
;
; RESTRICTIONS:
;   This routine is really only useful for creating files to be printed on
;   the BAS2000 printer, which probably does not even work any more!
;
; EXAMPLE:
;   data = bytscl(dist(256))
;   WRITE_BAS2000, data, 'Myfile'
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, 1993?
;   Modifications:
;       MLR 26-APR-1999 Added documentation header
;-


; Check for valid data size
n_cols = n_elements(array(*,0))
n_rows = n_elements(array(0,*))
if (n_cols ne 1024 and n_cols ne 2048) then $
 message, "X dimension must be 1024 or 2048"
if (n_rows ne 1280 and n_rows ne 2048 and n_rows ne 4096) then $
 message, "Y dimension must be 1280, 2048 or 4096"

openw, lun, file+'.inf', /get_lun
printf, lun, "BAS_IMAGE_FILE"
printf, lun, "IDL_Image_file"
printf, lun, "20*25"        ; IP size
printf, lun, "200"          ; Resolution
printf, lun, "200"          ; Resolution
printf, lun, "8"            ; Number of bits/pixel
printf, lun, strtrim(n_cols,2)  ; Number of pixels in raster
printf, lun, strtrim(n_rows,2)  ; Number of rasters
printf, lun, "400"          ; Sensitivity
printf, lun, "4.0"          ; Latitude
printf, lun, systime()      ; Date string
printf, lun, "1000000"      ; Fake date number
printf, lun, "0"            ; Number of saturated pixels
printf, lun, " "            ; Blank line
printf, lun, "IDL generated data"
close, lun

if !version.os eq "vms" then $
  openw, lun, file+'.img', /get_lun, /block $
else $
  openw, lun, file+'.img', /get_lun

writeu, lun, array         ; Write data file
close, lun

end
