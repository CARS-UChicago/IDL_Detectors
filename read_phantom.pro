function read_phantom, file, header=header, $
         xrange=xrange, yrange=yrange, zrange=zrange
;+
; NAME:
;   READ_PHANTOM
;
; PURPOSE:
;   Reads in data files written by the Vision Research Phantom high-speed cameras.
;
; CATEGORY:
;   Detectors
;
; CALLING SEQUENCE:
;   Result = READ_PHANTOM(File)
;
; INPUTS:
;   File:
;       The name of the volume file to be read.  If this is not specified then
;       the function will use DIALOG_PICKFILE to allow the user to select a
;       file.
; KEYWORD PARAMETERS:
;   XRANGE=[xstart, xstop]
;       The range of X values to read in.  The default is to read the entire
;       X range of the data
;   YRANGE=[ystart, ystop]
;       The range of Y values to read in.  The default is to read the entire
;       Y range of the data
;   ZRANGE=[zstart, zstop]
;       The range of Z values to read in.  The default is to read the entire
;       Z range of the data
;
; OUTPUTS:
;   This function returns a 3-D 8-bit unsigned array.  The dimensions are
;   NX, NY, NZ
;
; KEYWORD OUTPUTS:
;   HEADER=header
;       A structure of type {phantom_header} containing the file header.  This structure
;       is defined as:
;          {phantom_header, $
;              cineHeader: {phantom_cine_header}, $
;              bitmapInfo: {phantom_bitmap_info}, $
;              cameraSetup: {phantom_camera_setup} $
;          }
;       These structures are all defined in the file phantom_header__define.pro
;
;
; RESTRICTIONS:
;   There are some fields in the phantom_camera_setup structure that are not described in the 
;   documentation we have, and so are not being read correctly.
;   This routine will currently only work on little-endian machines like Intel, since I have
;   not added byte-swapping yet.
;
; EXAMPLE:
; IDL> data = read_phantom('BMD_30mm_60mmh_1.cin', header=header) 
; IDL> help, data
; DATA            BYTE      = Array[800, 600, 831]
; IDL> help, /structure, header             
; ** Structure PHANTOM_HEADER, 3 tags, length=1048, data length=1040:
;    CINEHEADER      STRUCT    -> PHANTOM_CINE_HEADER Array[1]
;    BITMAPINFO      STRUCT    -> PHANTOM_BITMAP_INFO Array[1]
;    CAMERASETUP     STRUCT    -> PHANTOM_CAMERA_SETUP Array[1]
; 
; IDL> help, /structure, header.cineheader
; ** Structure PHANTOM_CINE_HEADER, 12 tags, length=44, data length=44:
;   TYPE            UINT         18755
;   HEADERSIZE      UINT            44
;   COMPRESSION     UINT             0
;   VERSION         UINT             1
;   FIRSTMOVIEIMAGE LONG             -2939
;   TOTALIMAGECOUNT ULONG             2940
;   FIRSTIMAGENO    LONG             -2286
;   IMAGECOUNT      ULONG              831
;   OFFIMAGEHEADER  ULONG               44
;   OFFSETUP        ULONG               84
;   OFFIMAGEOFFSETS ULONG            11576
;   TRIGGERTIME     STRUCT    -> PHANTOMTIME64 Array[1]
;
; The cineHeader tells how many frames were captured (2940), the total number that were saved 
; to disk (831), the index of the first captured frame relative to the trigger (-2939), 
; and the index of the first saved frame relative to the trigger (-2286).  It also contains 
; information on where the data are located in the file.
;  
; IDL> help, /structure, header.bitmapinfo
; ** Structure PHANTOM_BITMAP_INFO, 11 tags, length=40, data length=40:
;   BISIZE          ULONG               40
;   BIWIDTH         LONG               800
;   BIHEIGHT        LONG               600
;   BIPLANES        UINT             1
;   BIBITCOUNT      UINT             8
;   BICOMPRESSION   ULONG                0
;   BISIZEIMAGE     ULONG           480000
;   BIXPELSPERMETER LONG             45454
;   BIYPELSPERMETER LONG             45454
;   BICLRUSED       ULONG                0
;   BICLRIMPORTANT  ULONG                0
;
; The bitmapHeader give the dimension of each frame, the how many bits, etc.
;
; IDL> help, /structure, header.camerasetup
; ** Structure PHANTOM_CAMERA_SETUP, 87 tags, length=964, data length=956:
;   FRAMERATE16     UINT          4800
;   SHUTTER16       UINT           125
;   POSTTRIGGER16   UINT             1
;   FRAMEDELAY16    UINT             0
;   ASPECTRATIO     UINT             1
;   CONTRASTP       UINT             0
;   BRIGHTP         UINT             0
;   ROTATEP         BYTE         0
;   TIMEANNOTATION  BYTE         1
;   TRIGCINE        BYTE         1
;   TRIGFRAME       BYTE         0
;   SHUTTERON       BYTE         1
;   DESCRIPTION     BYTE      Array[121]
;   MARK            UINT         21587
;   LENGTH          UINT          1504
;   BINNING         UINT             1
;   BINENABLE       UINT             0
;   BINCHANNELS     INT              0
;   BINSAMPLES      BYTE         1
;   BINNAME         BYTE      Array[11, 8]                   
;...
;
; MODIFICATION HISTORY:
;   Written by: Mark Rivers, March 5, 2005
;-
   if (n_elements(file) eq 0) then file = dialog_pickfile(/read, /must_exist)
   if file eq "" then return, 0
   openr, lun, /get, file
   header = {phantom_header}
   cineHeader = {phantom_cine_header}
   cameraSetup = {phantom_camera_setup}
   readu, lun, cineHeader
   nz = cineHeader.ImageCount
   point_lun, lun, cineHeader.OffImageHeader
   bitmapInfo = {phantom_bitmap_info}
   readu, lun, bitmapInfo
   nx = bitmapInfo.biWidth
   ny = bitmapInfo.biHeight
   point_lun, lun, cineHeader.OffSetup
   readu, lun, cameraSetup
   imageOffsets = ulon64arr(nz)
   point_lun, lun, cineHeader.OffImageOffsets
   readu, lun, imageOffsets
   if (n_elements(xrange) eq 0) then xrange = [0, nx-1]
   if (n_elements(yrange) eq 0) then yrange = [0, ny-1]
   if (n_elements(zrange) eq 0) then zrange = [0, nz-1]
   ; Make sure ranges are valid
   xrange = (xrange > 0) < (nx-1)
   yrange = (yrange > 0) < (ny-1)
   zrange = (zrange > 0) < (nz-1)
   nx_keep = xrange[1]-xrange[0]+1
   ny_keep = yrange[1]-yrange[0]+1
   nz_keep = zrange[1]-zrange[0]+1
 
   data = bytarr(nx_keep, ny_keep, nz_keep)
   temp = bytarr(nx, ny)
   annotationSize = 0L
   for i=zrange[0], zrange[1] do begin
      point_lun, lun, imageOffsets[i]
      readu, lun, annotationSize
      extra = bytarr(annotationSize-4)
      readu, lun, extra, temp
      t = temp[xrange[0]:xrange[1], yrange[0]:yrange[1]]
      data[0,0,i] = t
   endfor
   header.cineHeader = cineHeader
   header.bitmapInfo = bitmapInfo
   header.cameraSetup = cameraSetup
   free_lun, lun
   return, data
end

