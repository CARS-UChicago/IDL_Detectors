pro read_wdx, file, energy, counts, header

;+
; NAME:
;   READ_WDX
;
; PURPOSE:
;   This procedure reads scan data files written by the "Qualitative Analysis"
;   program in the Windows version of Oxford Instruments/Microspec WinSpec 
;   software for driving the WDX wavelength spectrometer.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   READ_WDX, File, Energy, Counts, Header
;
; INPUTS:
;   File:  
;       The name of the WDX input file.
;
; OUTPUTS:
;   Energy:  
;       A 1-D array containing the energy values for each point in the scan.
;
;   Counts:
;       A 1-D array containing the counts for each point in the scan.
;       
;   Header:  
;       A structure containing the instrument settings under which the scan
;       was collected.  The fields in this structure are meant to be
;       self-explanatory.
;
; RESTRICTIONS:
;   This procedure requires at least IDL 5.1 because it uses the
;   SWAP_IF_LITTLE_ENDIAN keyword to BYTEORDER.
;
; PROCEDURE:
;   This code is a bit complex because of a deficiency in the point_lun 
;   function under Windows.  Under Unix and VMS this procedure could be 
;   simpler, because point_lun work correctly, but under Windows it does not.
;   The files have an ASCII header, followed by a control-Z, CR, LF, then 
;   binary 32-bit integer pairs of (wavelength*10000, counts).
;
; EXAMPLE:
;   READ_WDX, 'Myfile.001', Energy, Counts, Header
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, 1996?
;   Modifications:
;       MLR 26-APR-1999 Added documentation header
;-
openr, lun, file, /get

header = {npoints:   0L, $
          emin:      0., $
          emax:      0., $
          slit_size: 0., $
          slit_position:  0. }

angstroms_to_kev = 12.398  ; Conversion from Angstroms to keV
; First read the ASCII header part of the file
line = ''
while (1) do begin
   readf, lun, line
   words = str_sep(line, ' ', /trim)
   case words[0] of
       'points' : header.npoints = long(words[1])
       'begin'  : header.emax = angstroms_to_kev/(long(words[1]) / 1.e4)
       'end'    : header.emin = angstroms_to_kev/(long(words[1]) / 1.e4)
       'sltsiz' : header.slit_size = float(words[1])
       'sltpos' : header.slit_position = float(words[1])
       'scan'   : goto, read_data
       else:
   endcase
endwhile

read_data:
; Now read the entire file as a byte array. We don't know exactly how
; how long it will be.  We know the data is 8*npoints bytes, but the header
; size is variable.  It is typically 500-600 bytes.  Assume it is less than 
; 4096.
point_lun, lun, 0
; Error handling because we will be asking for more byte than file contains
on_ioerror, done
temp = bytarr(8*header.npoints + 4096)
readu, lun, temp
done: free_lun, lun
; Now search for the first control-Z in the file
p = where(temp eq 26)
; The binary data begins 3 bytes after this
start = p[0] + 3
; Extract binary data
data = long(temp, start, 2, header.npoints)
wavelength = data[0,*]/1.e4
counts = data[1,*]
energy = 12.398/wavelength
end
