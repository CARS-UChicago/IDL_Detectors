pro read_princeton, file, $
                data, $
                header=header, $
                x_calibration=x_calibration, $
                y_calibration=y_calibration, $
                comments=comments, $
                exposure=exposure, $
                background_file = background_file, $
                date=date
;+
; NAME:
;   READ_PRINCETON
;
; PURPOSE:
;   This procedure reads data files written by Princeton Instruments'
;   WinSPEC and WinVIEW software.
;
; CATEGORY:
;   File input.
;
; CALLING SEQUENCE:
;   READ_PRINCETON, File, Data
;
; INPUTS:
;   File:
;       The name of the data file to read.
;
; OUTPUTS:
;   Data[nx, ny, nframes]:
;   The output data array.  The array will be 1, 2 or 3 dimensions
;   (depending upon whether ny and nframes are 1) and can be integer,
;   long or float data type.
;
; KEYWORD OUTPUTS:
;   HEADER:
;       The 4100 byte header from the file.  This header can be used to
;       extract additional information about the file.  See the Princteon
;       Instruments "PC Interface Library Programming Manual" for the
;       description of the header structure, and this procedure for
;       examples of how to extract information from the header.
;
;   X_CALIBRATION:
;       An nx array of calibrated values for each pixel in the X direction.
;   Y_CALIBRATION:
;       An ny array of calibrated values for each pixel in the Y direction.
;   COMMENTS:
;       A 5-element string array containing the "experiment comments"
;       fields, which is a 5x80 byte array starting at location 200 in
;       the PI header.  These fields are typically used to store
;       experiment-specific information.  For example, in the tomography
;       experiments we use the first two strings to store the frame type
;       and rotation angle.
;   DATE:
;       A date string of the form DDMMMYYYY:HH:MM:SS
;   EXPOSURE:
;       The exposure time in seconds.
;   BACKGROUND_FILE:
;       The name of the background file that was subtracted from the data
;
; RESTRICTIONS:
;   This procedure currently only extracts limited information from the
;   header. It should be exhanced to extract more fields, probably into a
;   structure.
;   The data and calibration are corrected for byte order when reading on
;   a big-endian host, but other elements of the header are not converted.
;
; EXAMPLE:
;   Read a data file:
;
;       IDL> READ_PRINCETON, 'test.spe', data, header=header, x_cal=x_cal
;       IDL> plot, x_cal, data
;       IDL> clock_speed = float(header, 1428)
;       IDL> print, 'Vertical clock speed (microseconds) = ', clock_speed
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, 11/4/97
;   Mark Rivers 10/27/98  Convert data to long if any pixels are > 32K
;   Mark Rivers 11/12/98  Fix to not convert data if already long
;   Mark Rivers 3/16/99   Added /BLOCK keyword to openr to work with VMS
;   Mark Rivers 3/27/99   Added "Comments" keyword
;   Mark Rivers 3/29/99   Added "Date" keyword
;   Mark Rivers 2/22/00   Corrected byte order for data and calibration.
;   Mark Rivers 9/11/01   Added "exposure" keyword
;   Mark Rivers 9/12/01   Added "background_file" keyword
;-

openr, lun, /get, file, /block

header = bytarr(4100)
readu, lun, header

; Convert the header from a byte array to a structure
header = convert_princeton_header(header)

; Get the image size from the header
nx = header.xdim
ny = header.ydim
nframes = header.NumFrames
data_type = header.datatype
case data_type of
        0: data = fltarr(nx, ny, nframes)
        1: data = lonarr(nx, ny, nframes)
        2: data = intarr(nx, ny, nframes)
        3: data = uintarr(nx, ny, nframes)
        else: message, 'Unknown data type'
endcase

xcal = header.xcalibration
ycal = header.ycalibration
x_calibration = poly(findgen(nx), xcal.polynocoeff(0:xcal.polynoorder))
y_calibration = poly(findgen(ny), ycal.polynocoeff(0:ycal.polynoorder))

comments=header.comments
comments=string(comments)
date = header.date
;hour = fix(header, 30)
;byteorder, hour, /sswap, /swap_if_big_endian
;minute = fix(header, 32)
;byteorder, minute, /sswap, /swap_if_big_endian
;second = fix(header, 38)
;byteorder, second, /sswap, /swap_if_big_endian
;date = date + ":" + string(hour, format='(i2.2)') $
;            + ":" + string(minute, format='(i2.2)') $
;            + ":" + string(second, format='(i2.2)')
exposure = header.exp_sec
if (header.BackGrndApplied) then background_file = header.background $
else background_file = ""

readu, lun, data
data = reform(data)  ; Eliminate trailing dimensions if 1
case data_type of
        0: byteorder, data, /lswap, /swap_if_big_endian
        1: byteorder, data, /lswap, /swap_if_big_endian
        2: byteorder, data, /sswap, /swap_if_big_endian
        3: byteorder, data, /sswap, /swap_if_big_endian
        else: message, 'Unknown data type'
endcase
free_lun, lun
end
