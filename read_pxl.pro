pro read_pxl, file, header, data

;+
; NAME:
;   READ_PXL
;
; PURPOSE:
;   This procedures reads a Photometrics PXL image proicessing format file
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   READ_PXL, File, Header, Data
;
; INPUTS:
;   File:
;       The name of the Photometrics PXL input file.
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
;   READ_PXL, 'Myfile.pxl', header, data
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, Feb. 20, 2000
;-

openr, lun, file, /get
header = {pxl, $
        hsiz:           0L, $ ; 0     pointer to image data                  
        text:           0L, $ ; 4     total history data appended    
        startx:         0L, $ ; 8     starting col           
        starty:         0L, $ ; 12    starting row           
        totalx:         0L, $ ; 16    total number of cols           
        totaly:         0L, $ ; 20    total number of rows           
        bpp:            0L, $ ; 24    bits per pixel [1-8]           
        exp_t:          0L, $ ; 28    exposure time * 33 mSEC        
        exp_n:          0L, $ ; 32    exposure number        
        spc:     bytarr(4), $ ; 36    x,y length per unit pixel      
        units:   bytarr(4), $ ; 40    in ascii format        
        date:   bytarr(36), $ ; 44    Time-date of aquisition        
        drk:    bytarr(36), $ ; 80    dark-current and/or bkg        
        rad:    bytarr(36), $ ; 116   radiometric correction         
        geom:   bytarr(36), $ ; 152   geometric correction           
        src:    bytarr(36), $ ; 188   image src descriptor           
        opt:    bytarr(36), $ ; 224   filters, optics        
        pos:    bytarr(36), $ ; 260   world x,y,z position           
        expt:   bytarr(36), $ ; 296   experimental protocol          
        label: bytarr(144), $ ; 332   image title            
        pixel_type:     0B, $ ; 476   TYPE_BYTE, _SHORT,             
        is_rgb:         0B, $ ; 477   Boolean for color images       
        section_type:    0, $ ; 478   Time, Z, Other         
        mosaic_x:        0, $ ; 480   # horizontal tiles             
        mosaic_y:        0, $ ; 482   # vertical tiles               
        nbands:         0L, $ ; 484   # bands for multispectral      
        nsections:      0L, $ ; 488   # images of section_type       
        version_magic:  0L, $ ; 492   Magic # for version 2          
        zspc:           0., $ ; 496   z length/unit voxel            
        xspc:           0., $ ; 500   x length/unit pixel            
        yspc:           0., $ ; 504   y length/unit pixel            
        magic:          0L $  ; 508   magic number           
}

readu, lun, header
xsize = header.totalx
ysize = header.totaly
byteorder, xsize, /lswap, /swap_if_little_endian
byteorder, ysize, /lswap, /swap_if_little_endian
data = intarr(xsize, ysize)
readu, lun, data
byteorder, data, /sswap, /swap_if_little_endian
free_lun, lun
end
