pro read_bas2000, file, settings, data

;+
; NAME:
;   READ_BAS2000
;
; PURPOSE:
;   This procedure reads data files from the Fuji BAS2000 image plate scanner.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   READ_BAS2000, File, Settings, Data
;
; INPUTS:
;   File:
;       The name of the input file without the '.inf' or '.img' extensions.
;
; OUTPUTS:
;   Settings:
;       A structure which contains the instrument settings for the scanner.
;       The names of the fields in this structure are meant to be
;       self-explanatory.
;
;   Data:
;       The 2-D array of intensities.  This is either an 8-bit BYTE array or
;       a 16-bit INT array depending upon the setting of the scanner when
;       the file was written.
;
; RESTRICTIONS:
;   This procedure requires at least IDL 5.1 because it uses the
;   SWAP_IF_LITTLE_ENDIAN keyword to BYTEORDER.
;
; EXAMPLE:
;   READ_BAS2000, 'Myfile', settings, data
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, 1993?
;   Modifications:
;       MLR 20-AUG-1998 Changed to use SWAP_IF_LITTLE_ENDIAN on BYTEORDER.
;       MLR 26-APR-1999 Added documentation header
;       MLR 21-JUL-1999 Fixed bug, replace CLOSE, lun with FREE_LUN, lun
;-

settings = {header:         "", $
            plate_size:     "", $
            file:           "", $
            date_string:    "", $
            date:           0L, $
            comment:        "", $
            x_pixel_size:   0., $
            y_pixel_size:   0., $
            bits:           0L, $
            n_rows:         0L, $
            n_cols:         0L, $
            sensitivity:    0L, $
            latitude:       0L, $
            n_sat:          0L  $
}

openr, lun, file + '.inf', /get_lun
t = ""
readf, lun, t             ; First line = BAS_IMAGE_FILE
settings.header=t
readf, lun, t             ; Read the original file name
settings.file=t
readf, lun, t             ; IP size
settings.plate_size=t
t = 0.
readf, lun, t             ; Read X pixel size
settings.x_pixel_size=t
readf, lun, t             ; Read Y size
settings.y_pixel_size=t
readf, lun, t             ; Read number of bits/pixel
settings.bits=t
readf, lun, t             ; Read number of pixels in raster
settings.n_cols=t
readf, lun, t             ; Read number of rasters
settings.n_rows=t
readf, lun, t             ; Read sensitivity
settings.sensitivity=t
readf, lun, t             ; Read latitude
settings.latitude=t
t = ""
readf, lun, t             ; Read date string
settings.date_string=t
t = 0.
readf, lun, t             ; Read date numbers
settings.date=t
readf, lun, t             ; Read number of saturated pixels
settings.n_sat=t
t=""
readf, lun, t             ; Skip blank line
readf, lun, t             ; Comment field
settings.comment=t
free_lun, lun

if settings.bits eq 8 then $
        data = bytarr(settings.n_cols, settings.n_rows, /nozero) $
   else $
        data = intarr(settings.n_cols, settings.n_rows, /nozero)
if !version.os eq "vms" then $
  openr, lun, file+'.img', /get_lun, /block $
else $
  openr, lun, file+'.img', /get_lun

readu, lun, data   ; Read data file
free_lun, lun
; Swap byte order on little-endian machines
byteorder, data, /swap_if_little_endian

end
