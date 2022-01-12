function get_sfrm_param, header, keyword
  for i=0, n_elements(header)-1 do begin
    if (strpos(header[i], keyword) eq 0) then begin
      pos = strpos(header[i], ':')
      value = strmid(header[i], pos+1)
      return, strtrim(value, 2)
    endif
  endfor
  return, ''
end

pro read_sfrm, file, header, data
;+
; NAME:
;   READ_SFRM
;
; PURPOSE:
;   This procedures reads a Bruker SFRM format file
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   READ_BRUKER, File, Header, Data
;
; INPUTS:
;   File:
;       The name of the SFRM input file.
;
; OUTPUTS:
;   Header:
;       An array of strings containing the header information
;
;   Data:
;       The 2-D array of intensities.  It always returns a 32-bit integer array.
;
; EXAMPLE:
;   READ_SFRM, 'Myfile.sfrm', header, data
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, March 27, 2018
;-

openr, lun, file, /get
; The header is fixed-length 80 character lines.  The minimum number of lines is 32 (5 * 512 byte blocks)
temp = bytarr(80, 32)
readu, lun, temp
header = strtrim(string(temp), 2)
blocks = fix(get_sfrm_param(header, 'HDRBLKS'))
for i=0, blocks/5-2 do begin
  readu, lun, temp
  header = [header, strtrim(string(temp), 2)]
endfor
ncols = fix(get_sfrm_param(header, 'NCOLS'))
nrows = fix(get_sfrm_param(header, 'NROWS'))
temp = get_sfrm_param(header, 'NPIXELB')
temp = long(strsplit(temp, ' ', /extract))
bytesPerPixel = temp[0]
bytesPerUnderflow = temp[1]
if (bytesPerPixel eq 1) then data = bytarr(ncols, nrows)
if (bytesPerPixel eq 2) then data = intarr(ncols, nrows)
if (bytesPerPixel eq 4) then data = lonarr(ncols, nrows)
readu, lun, data
if (bytesPerPixel eq 2) then byteorder, data, /sswap, /swap_if_big_endian
if (bytesPerPixel eq 4) then byteorder, data, /lswap, /swap_if_big_endian
; Convert data to long because overflows may require it
data = long(data)
temp = get_sfrm_param(header, 'NOVERFL')
temp = long(strsplit(temp, ' ', /extract))
numUnderflow = temp[0]
numOverflow2 = temp[1]
numOverflow4 = temp[2]

if (numUnderflow gt 0) then begin
  if (bytesPerUnderflow eq 1) then underflows = bytarr(numUnderflow)
  if (bytesPerUnderflow eq 2) then underflows = intarr(numUnderflow)
  if (bytesPerUnderflow eq 4) then underflows = lonarr(numUnderflow)
  readu, lun, underflows
  ; Read junk so total size is a multiple of 16
  t = (numUnderflow * bytesPerUnderflow) mod 16
  if (t ne 0) then begin
    numExtra = 16-t
    junk = bytarr(numExtra)
    readu, lun, junk
  endif
endif

if (numOverflow2 gt 0) then begin
  overflow = intarr(numOverflow2)
  readu, lun, overflow
  overflowIndex = where(data eq 255)
  data[overflowIndex] = overflow
  ; Read junk so total size is a multiple of 16
  t = (numOverflow2 * 2) mod 16
  if (t ne 0) then begin
    numExtra = 16-t
    junk = bytarr(numExtra)
    readu, lun, junk
  endif
endif

if (numOverflow4 gt 0) then begin
  overflow = lonarr(numOverflow4)
  readu, lun, overflow
  overflowIndex = where(data eq 65535)
  data[overflowIndex] = overflow
  ; Read junk so total size is a multiple of 16
  t = (numOverflow4 * 4) mod 16
  if (t ne 0) then begin
    numExtra = 16-t
    junk = bytarr(numExtra)
    readu, lun, junk
  endif
endif

free_lun, lun
end
