pro read_princeton, file, $
                data, $
                header=header, $
                x_calibration=x_calibration, $
                y_calibration=y_calibration, $
                comments=comments, $
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
;-

openr, lun, /get, file, /block

header = bytarr(4100)
readu, lun, header

; Get the image size from the header

nx = fix(header, 42)
byteorder, nx, /sswap, /swap_if_big_endian
ny = fix(header, 656)
byteorder, ny, /sswap, /swap_if_big_endian
nframes = long(header, 1446)
byteorder, nframes, /lswap, /swap_if_big_endian
data_type = fix(header, 108)
byteorder, data_type, /sswap, /swap_if_big_endian
case data_type of
        0: data = fltarr(nx, ny, nframes)
        1: data = lonarr(nx, ny, nframes)
        2: data = lonarr(nx, ny, nframes)
        3: data = intarr(nx, ny, nframes)
        else: message, 'Unknown data type'
endcase

offset = 3000
xcal = { $
        offset:         double(header, offset), $
        factor:         double(header, offset+8), $
        current_unit:   byte(header, offset+16), $
        reserved1:      byte(header, offset+17), $
        string1:        byte(header, offset+18, 40), $
        reserved2:      byte(header, offset+58, 40), $
    calib_valid:    byte(header, offset+98), $
    input_unit:     byte(header, offset+99), $
    polynom_unit:   byte(header, offset+100), $
    polynom_order:  byte(header, offset+101), $
    calib_count:    byte(header, offset+102), $
    pixel_pos:      double(header, offset+103, 10), $
    calib_value:    double(header, offset+183, 10), $
    polynom_coeff:  double(header, offset+263, 6), $
    laser_position: double(header, offset+311), $
    reserved3:      byte(header, offset+319), $
    new_calib_flag: byte(header, offset+320), $
    calib_label:    byte(header, offset+321, 81), $
    expansion:      byte(header, offset+402, 87) $
}

offset = 3489
ycal = { $
    offset:         double(header, offset), $
    factor:         double(header, offset+8), $
    current_unit:   byte(header, offset+16), $
    reserved1:      byte(header, offset+17), $
    string1:        byte(header, offset+18, 40), $
    reserved2:      byte(header, offset+58, 40), $
    calib_valid:    byte(header, offset+98), $
    input_unit:     byte(header, offset+99), $
    polynom_unit:   byte(header, offset+100), $
    polynom_order:  byte(header, offset+101), $
    calib_count:    byte(header, offset+102), $
    pixel_pos:      double(header, offset+103, 10), $
    calib_value:    double(header, offset+183, 10), $
    polynom_coeff:  double(header, offset+263, 6), $
    laser_position: double(header, offset+311), $
    reserved3:      byte(header, offset+319), $
    new_calib_flag: byte(header, offset+320), $
    calib_label:    byte(header, offset+321, 81), $
    expansion:      byte(header, offset+402, 87) $
}
temp = xcal.polynom_coeff
byteorder, temp, /l64swap, /swap_if_big_endian
xcal.polynom_coeff = temp
temp = ycal.polynom_coeff
byteorder, temp, /l64swap, /swap_if_big_endian
ycal.polynom_coeff = temp

x_calibration = poly(findgen(nx), xcal.polynom_coeff(0:xcal.polynom_order))
y_calibration = poly(findgen(ny), ycal.polynom_coeff(0:ycal.polynom_order))

comments=byte(header, 200, 80, 5)
comments=string(comments)
date = byte(header, 20, 10)
date = string(date)
hour = fix(header, 30)
byteorder, hour, /sswap, /swap_if_big_endian
minute = fix(header, 32)
byteorder, minute, /sswap, /swap_if_big_endian
second = fix(header, 38)
byteorder, second, /sswap, /swap_if_big_endian
date = date + ":" + string(hour, format='(i2.2)') $
            + ":" + string(minute, format='(i2.2)') $
            + ":" + string(second, format='(i2.2)')

readu, lun, data
data = reform(data)  ; Eliminate trailing dimensions if 1
case data_type of
        0: byteorder, data, /fswap, /swap_if_big_endian
        1: byteorder, data, /lswap, /swap_if_big_endian
        2: byteorder, data, /lswap, /swap_if_big_endian
        3: byteorder, data, /sswap, /swap_if_big_endian
        else: message, 'Unknown data type'
endcase
if (data_type eq 3) and (min(data) lt 0) then $
    data = long(data) and 'ffff'x  ; IDL does not have unsigned int yet
free_lun, lun
end
