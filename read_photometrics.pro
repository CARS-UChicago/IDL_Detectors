pro read_photometrics, file, header, data

;+
; NAME:
;   READ_PHOTOMETRICS
;
; PURPOSE:
;   This procedures reads a Photometrics image proicessing format file (PMIS).
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   READ_PHOTOMETRICS, File, Header, Data
;
; INPUTS:
;   File:  
;       The name of the Photometrics PMIS input file.
;
; OUTPUTS:
;   Header:  
;       A structure which contains the header information.
;       The names of the fields in this structure are meant to be
;       self-explanatory.
;
;   Data:  
;       The 2-D array of intensities.  This is a 16-bit INT array
;
; EXAMPLE:
;   READ_PHOTOMETRICS, 'Myfile.pmis', header, data
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, 1993?
;   Modifications:
;       MLR 26-APR-1999 Added documentation header
;-

openr, lun, file, /get
header = {pmis, $
            ID:             bytarr(4), $
            header_size:    0, $
            file_version:   0, $
            xstart:         0, $
            ystart:         0, $
            xsize:          0, $
            ysize:          0, $
            xbin:           0, $
            ybin:           0, $
            name:           bytarr(40), $
            comment:        bytarr(100), $
            created:        0L, $
            modified:       0L, $
            gain:           0, $
            nimages:        0 }

readu, lun, header
data = intarr(header.xsize, header.ysize)
readu, lun, data
free_lun, lun
end
