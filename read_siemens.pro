pro read_siemens, file, header, data

;+
; NAME:
;   READ_SIEMENS
;
; PURPOSE:
;   This procedure reads Siemens (now Bruker) CCD data files written by
;   their SMART software.
;
; CATEGORY:
;   Detectors
;
; CALLING SEQUENCE:
;   READ_SIEMENS, File, Header, Data
;
; INPUTS:
;   File:
;       The name of the input file to be read.
;
; OUTPUTS:
;   Header:
;       A string array [2, 96].  Header[0,i] is a keyword, such as "NROWS"
;       or "ANGLES".  Header[1,i] is the value of that keyword parameter,
;       such as "512" or "29.9989000    90.0001000     2.2500000   .0000000"
;
;   Data:
;       A 2-D LONG array containing the CCD data.
;
; RESTRICTIONS:
;   This procedure requires at least IDL 5.1 because it uses the
;   SWAP_IF_LITTLE_ENDIAN keyword to BYTEORDER.
;
; EXAMPLE:
;   READ_SIEMENS, 'Corund13.178', Header, Data
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, 1995?
;   MLR 4-FEB-1999  Modified procedure to work with 8-bit data files
;   MLR 26-APR-1999 Added documentation header
;-

openr, lun, /get, file, /block
t = bytarr(80, 15*512/80)
readu, lun, t
header = strarr(2, 96)
header(0,*) = string(t(0:7, *))
header(1,*) = strtrim(string(t(8:*, *)))
nbytes = long(header(1,39))  ; Bytes per pixel
nrows = long(header(1,40))   ; Rows in frame
ncols = long(header(1,41))   ; Columns in frame
case nbytes of
    1: data = bytarr(ncols, nrows)
    2: data = intarr(ncols, nrows)
    4: data = lonarr(ncols, nrows)
endcase
readu, lun, data
data = long(temporary(data)) and '0000FFFF'x
byteorder, data, /swap_if_big_endian
n_over = long(header(1,20))
if (n_over gt 0) then begin
   t = bytarr(16, n_over)
   readu, lun, t
   inten = long(string(t(0:8, *)))
   offset = long(string(t(9:*, *)))
   data(offset) = inten
endif
free_lun, lun
end
