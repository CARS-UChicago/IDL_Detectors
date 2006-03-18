; This file defines structures that are in the header of the data files from the Phantom fast cameras

pro phantom_header__define

pTime64 = {phantomTime64, $
   fractions:       0UL, $   ;fractions of seconds (resolution
                             ;1/4Gig i.e. cca. 1/4 ns)
                             ;The fractions of the second are stored
                             ;here multiplied by 2**32
   seconds:         0UL  $   ;seconds from Jan 1 1970
                             ;(max year: 2036 signed ; 2102 unsigned)
}

; Windows structure for image header (BITMAPINFO):
BitMapInfo = {phantom_bitmap_info, $
   biSize:          0UL, $   ;header size (without palette)
   biWidth:          0L, $   ;image width (pixels)
   biHeight:         0L, $   ;image height (pixels)
   biPlanes:        0US, $   ;plane of colors
   biBitCount:      0US, $   ;bits per pixel
   biCompression:   0UL, $   ;=0 means no compression
                             ;not used when the file is JPEG compressed
   biSizeImage:     0UL, $   ;the size in bytes of the image
   biXPelsPerMeter:  0L, $   ;horizontal resolution in pixels per meter
   biYPelsPerMeter:  0L, $   ;vertical resolution in pixels per meter
   biClrUsed:       0UL, $   ;the number of color indexes in the
                             ;actually used by the bitmap
   biClrImportant:  0UL  $   ;the number of color indexes in the color
                             ;table considered important
}

; Camera setup information (the SETUP structure):
CameraSetup = {phantom_camera_setup, $
   FrameRate16:     0US, $   ;frame rate in pictures per second
   Shutter16:       0US, $   ;shutter duration in microseconds
   PostTrigger16:   0US, $   ;the count of the post trigger frames
   FrameDelay16:    0US, $   ;frame delay in microseconds (Synch Frame
                             ;mode)
   AspectRatio:     0US, $   ;aspect ratio (width/height)
   ContrastP:       0US, $   ;the position of the contrast adjustment
   BrightP:         0US, $   ;the position of the brightness adjustment
   RotateP:          0B, $   ;enable the image rotation (90 degrees)
                             ;(BOOL)
   TimeAnnotation:   0B, $   ;source of time information
   TrigCine:         0B, $   ;triggered cine (BOOL)
   TrigFrame:        0B, $   ;Synch imaging (BOOL)
   ShutterOn:        0B, $   ;enable the shutter (BOOL)
   Description: bytarr(121), $ ;event description text
   Mark:            0US, $   ;will be "ST" - maker for setup file
   Length:          0US, $   ;length of the current version of setup
   Binning:         0US, $   ;binning factor - reduce horizontal slice
                             ;dimension
   BinEnable:       0US, $   ;enable the acqui of the binary sig from
                             ;print port
   BinChannels:      0S, $   ;number of multiplexed bytes read from
                             ;paralel port
                             ;multiple of 8
   BinSamples:       0B, $   ;number of samples acquired per image; now:1
   BinName: bytarr(11,8),$   ;8 binary signals names with max 10
                             ;chars/name ended each by a NULL byte
   AnaEnable:       0US, $   ;enable the acqui of the analog signals
   AnaChannels:      0S, $   ;number of analog channels used
   AnaSamples:       0B, $   ;number of samples acquired per image; now: 1
   AnaBoard:         0B, $   ;board type 0=none, 1=dsk (DSP system kit)
                             ;2 = DSP+8 channels ADC (12 bit)
   AnaOffset: intarr(8), $   ;electronic offset correction, per channel
   AnaGain:   fltarr(8), $   ;electronic gain correction, and conversion
                             ;to real units, per channel
   AnaUnit: bytarr(6,8), $   ;8 analog signals unit strings with max 5
                             ;chars/name ended each by a NULL byte
   AnaName: bytarr(11,8),$  ;8 analog signals names with max 10
                             ;chars/name ended each by a NULL byte
   lFirstImage:      0L, $   ;range of images for continuous recording
   dwImageCount:    0UL, $
   nQFactor:         0S, $   ;Quality - for continuous recording; range
                             ;2...255
   wCineFileType:   0US, $   ;Cine file type - for continuous recording
   szCinePath: bytarr(65,4),$;4 paths to save cine files - for continuous
                             ;recording
   bMainsFreq:      0US, $   ;TRUE = 60Hz USA, FALSE = 50Hz Europe,
                             ;for signal view in DSP
                             ;Time board
   bTimeCode:        0B, $   ;Time code (IRIG-B, NASA36, IRIG-A ...
   bPriority:        0B, $   ;Time code has priority over PPS
   wLeapSecDY:      0US, $   ;Next day of year with leap second
   dDelayTC:        0.D, $   ;Propagation delay for time code
   dDelayPPS:       0.D, $   ;Propagation delay for PPS
                             ;General use bits
                             ;Bit 0 = Flip vertical (only for v3, not used in v4)
                             ; invert image upside down - used to
                             ; allow the invert of the 256x256. For example
                             ; channels 8...11 may be directed to the FBM
                             ; memory SIMMs 0...3 but the resulting image
                             ; will be upside-down. The effect is inverting
                             ; bit 3 of the slice address. 0..7 <=> 8..15
                             ;Bit 1 = Flip horizontal (only for v3, not used in v4)
                             ; mirror the image, left-right
                             ; added for the color camera where certain components
                             ; are mirrored
                             ; Effect: mirror every row during transfer from FBM to
                             ; memory buffer.
                             ;Bit 2 = Separate channels v4 . Move the pixels to produce
                             ; rectangular areas coming out from the same video channel
                             ; The video channels are interlaced based on a 8x2 kernel
                             ; in the quarter (512x512) camera
                             ;
   GenBits:         0US, $ 
                             ;color adjustment:
   ContrastR:        0S, $   ;values for adjustment in analog
   BrightR:          0S, $   ;part of the RGB color system; reused for
                             ;digital corrections on V4
   ContrastG:        0S, $
   BrightG:          0S, $
   ContrastB:        0S, $
   BrightB:          0S, $
   ImWidth:         0US, $   ;image dimensions in v4
   ImHeight:        0US, $
   EDRShutter16:    0US, $   ;extended dynamic range exposure (v4)
   Serial:          0UL, $   ;camera serial number - will be stored in
                             ;every cine file
   Saturation:       0S, $   ;Color saturation [-100, 100]
   Reserved:  bytarr(3), $   ;align to dword
   AutoExp:         0UL, $   ;autoexposure
   bFlipH:          0UL, $   ;Flip horizontal, vertical in v4
   bFlipV:          0UL, $   ;For color images flips are postponed after
                             ;interpolation
   bCrossHair:      0UL, $   ;display a crosshair in setup
                             ;upgrade from 16 to 32 bits of a few old variables (July2000)
   FrameRate:       0UL, $
   Shutter:         0UL, $
   EDRShutter:      0UL, $
   PostTrigger:     0UL, $
   FrameDelay:      0UL, $
   bEnableColor:    0UL, $  ;available to user: when 0 force gray images
   CameraVersion:   0UL, $  ;4, 5 ....
   FirmwareVersion: 0UL, $  ;Firmware version
   SoftwareVersion: 0UL, $  ;Phantom version
   RecordingTimeZone:0L, $  ;the time zone active during the recording of
                            ;the cine
   CFA:             0UL, $  ;code for the color filter array (for late
                            ;interpolate or uninterpolate):
                            ;CFA_NONE=0,(gray) CFA_VRI=1(gbrg/rggb),
                            ;CFA_VRIV6=2(bggr/grbg), CFA_BAYER=3(gb/rg)
                            ;high byte carry info about color/gray heads at
                            ;v6
                            ;Masks: 0x80000000: TLgray 0x40000000: TRgray
                            ;0x20000000: BLgray 0x10000000: BRgray
                            ;Final adjustments after image processing:
   Bright:           0L, $  ;Brightness -100...100 neutral:0
   Contrast:         0L, $  ;Contrast -100...100 neutral:0
   Gamma:            0L, $  ;Gamma -100...100 neutral:0
   Reserved1:       0UL, $  ;BOOL LockToIRIG;     ;camera mode : lock to IRIG
                            ;- removed
   AutoExpLevel:    0UL, $  ;level for autoexposure control
   AutoExpSpeed:    0UL, $  ;speed for autoexposure control
   AutoExpRect: ulonarr(4), $;rectangle for autoexposure control ???? type RECT
   WBGain: ulonarr(3,4), $  ;Gain adjust on R,B components, for white type=WBGAIN[4]
                            ;balance,
                            ;1.0 = do nothing,
                            ;index 0: all image for v4,5,7...TL head for v6
                            ;index 1, 2, 3 : TR, BL, BR for v6
   Rotate:           0L, $  ;0=do nothing +90=counterclockwise
                            ;-90=clockwise
   WBView:   ulonarr(3), $  ;White balance to apply on images from cine type=WBGAIN
                            ;file
   RealBPP:         0UL, $  ;real number of camera bits per pixel
                            ;e.g 8 on old cameras and 12 on v7 with 12 bit
                            ;converters; pixel stored on 16 bit
   Conv8Min:        0UL, $  ;Minimum value when convert to 8 bits
   Conv8Max:        0UL, $  ;Max value when convert to 8 bits
   FilterCode:       0L, $  ;ImageProcessing: area processing code
   FilterParam:      0L, $
   UF:               0L, $  ;user filter, see PhInt.h type=IMFILTER
   BlackCalSVer:    0UL, $  ;Black Calibration SoftwareVersion
   WhiteCalSVer:    0UL, $  ;White Calibration SoftwareVersion
   GrayCalSVer:     0UL, $  ;Gray Calibration SoftwareVersion
   bStampTime:      0UL  $  ;Stamp time (in continuous recording)
}

; Cine File Header (the CINEFILEHEADER structure)
CineHeader = {phantom_cine_header, $
   ; All offsets (pointers, addresses) in file are related to the file begin
   Type:            0US, $   ;Marker, must be "CI"
   HeaderSize:      0US, $   ;Header size in bytes
   Compression:     0US, $   ;CC_RGB=0 - uncompressed BMP
                             ;CC_JPEG=1 - JPEG Compressed
                             ;CC_UNINT=2 - Uninterpolated color image for
                             ; the gbrg/rggb CFA
   Version:         0US, $   ;upgrades, now 1, supports files > 4GB
   FirstMovieImage:  0L, $   ;First recorded image number, relative to
                             ;trigger
   TotalImageCount: 0UL, $   ;Total count of recorded movie images
   FirstImageNo:     0L, $   ;First image saved to this file
                             ;(relative to trigger)
   ImageCount:      0UL, $   ;count of images saved to this file
   OffImageHeader:  0UL, $   ;offset in the file of the
                             ;BITMAPINFO structure for all images
   OffSetup:        0UL, $   ;offset in file of the
                             ;SETUP structure
   OffImageOffsets: 0UL,$   ;offset in file of an array with position
                             ;of each annotated image in file
   TriggerTime: {phantomTime64} $ ;Trigger time 32.32 in second and fraction of
                             ;second from Jan 1 1970 (resolution: cca 1/4
                             ;nanosecond)
}

fileHeader = {phantom_header, $
   cineHeader: {phantom_cine_header}, $
   bitmapInfo: {phantom_bitmap_info}, $
   cameraSetup: {phantom_camera_setup} $
}
end

