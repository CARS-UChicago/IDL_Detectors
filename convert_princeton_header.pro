function convert_princeton_header, header

; NOTE: the following values should not change, otherwise the header will
; be bleeped up.
HDRNAMEMAX = 120     ; max char str length for file name
USERINFOMAX = 1000   ; user information space.
COMMENTMAX = 80      ; User comment string max length (5 comments)
LABELMAX = 16        ; Label string max length.
FILEVERMAX = 16      ; File version string max length.
DATEMAX = 10         ; string length of file creation date string as ddmmmyyyy\0
ROIMAX = 10          ; Max size of roi array of structures.
TIMEMAX = 7          ; Max time store as hhmmss\0


str = {princeton_header}

str.ControllerVersion      = fix(header, 0)            ;    0  Hardware Version
str.LogicOutput            = fix(header, 2)            ;    2  Definition of Output BNC
str.AmpHiCapLowNoise       = fix(header, 4)            ;    4  Amp Switching Mode
str.xDimDet                = fix(header, 6)            ;    6  Detector x dimension of chip.
str.mode                   = fix(header, 8)            ;    8  timing mode
str.exp_sec                = float(header, 10)         ;   10  alternitive exposure, in sec.
str.VChipXdim              = fix(header, 14)           ;   14  Virtual Chip X dim
str.VChipYdim              = fix(header, 16)           ;   16  Virtual Chip Y dim
str.yDimDet                = fix(header, 18)           ;   18  y dimension of CCD or detector.
temp                       = byte(header, 20, DATEMAX) ;   20  date
str.date                   = string(temp)              ;   20  date
str.VirtualChipFlag        = fix(header, 30)           ;   30  On/Off
str.Spare_1                = byte(header, 32, 2)       ;   32
str.noscan                 = fix(header, 34)           ;   34  Old number of scans - should always be -1
str.DetTemperature         = float(header, 36)         ;   36  Detector Temperature Set
str.DetType                = fix(header, 40)           ;   40  CCD/DiodeArray type
str.xdim                   = fix(header, 42)           ;   42  actual # of pixels on x axis
str.stdiode                = fix(header, 44)           ;   44  trigger diode
str.DelayTime              = float(header, 46)         ;   46  Used with Async Mode
str.ShutterControl         = fix(header, 50)           ;   50  Normal, Disabled Open, Disabled Closed
str.AbsorbLive             = fix(header, 52)           ;   52  On/Off
str.AbsorbMode             = fix(header, 54)           ;   54  Reference Strip or File
str.CanDoVirtualChipFlag   = fix(header, 56)           ;   56  T/F Cont/Chip able to do Virtual Chip
str.ThresholdMinLive       = fix(header, 58)           ;   58  On/Off
str.ThresholdMinVal        = float(header, 60)         ;   60  Threshold Minimum Value
str.ThresholdMaxLive       = fix(header, 64)           ;   64  On/Off
str.ThresholdMaxVal        = float(header, 66)         ;   66  Threshold Maximum Value
str.SpecAutoSpectroMode    = fix(header, 70)           ;   70  T/F Spectrograph Used
str.SpecCenterWlNm         = float(header, 72)         ;   72  Center Wavelength in Nm
str.SpecGlueFlag           = fix(header, 76)           ;   76  T/F File is Glued
str.SpecGlueStartWlNm      = float(header, 78)         ;   78  Starting Wavelength in Nm
str.SpecGlueEndWlNm        = float(header, 82)         ;   82  Starting Wavelength in Nm
str.SpecGlueMinOvrlpNm     = float(header, 86)         ;   86  Minimum Overlap in Nm
str.SpecGlueFinalResNm     = float(header, 90)         ;   90  Final Resolution in Nm
str.PulserType             = fix(header, 94)           ;   94  0=None, PG200=1, PTG=2, DG535=3
str.CustomChipFlag         = fix(header, 96)           ;   96  T/F Custom Chip Used
str.XPrePixels             = fix(header, 98)           ;   98  Pre Pixels in X direction
str.XPostPixels            = fix(header, 100)          ;  100  Post Pixels in X direction
str.YPrePixels             = fix(header, 102)          ;  102  Pre Pixels in Y direction 
str.YPostPixels            = fix(header, 104)          ;  104  Post Pixels in Y direction
str.asynen                 = fix(header, 106)          ;  106  asynchron enable flag  0 = off
str.datatype               = fix(header, 108)          ;  108  experiment datatype
                                                       ;       0 =   FLOATING POINT
                                                       ;       1 =   LONG INTEGER
                                                       ;       2 =   INTEGER
                                                       ;       3 =   UNSIGNED INTEGER
str.PulserMode             = fix(header, 110)          ;  110  Repetitive/Sequential
str.PulserOnChipAccums     = fix(header, 112)          ;  112  Num PTG On-Chip Accums
str.PulserRepeatExp        = long(header, 114)         ;  114  Num Exp Repeats (Pulser SW Accum)
str.PulseRepWidth          = float(header, 118)        ;  118  Width Value for Repetitive pulse (usec)
str.PulseRepDelay          = float(header, 122)        ;  122  Width Value for Repetitive pulse (usec)
str.PulseSeqStartWidth     = float(header, 126)        ;  126  Start Width for Sequential pulse (usec)
str.PulseSeqEndWidth       = float(header, 130)        ;  130  End Width for Sequential pulse (usec)
str.PulseSeqStartDelay     = float(header, 134)        ;  134  Start Delay for Sequential pulse (usec)
str.PulseSeqEndDelay       = float(header, 138)        ;  138  End Delay for Sequential pulse (usec)
str.PulseSeqIncMode        = fix(header, 142)          ;  142  Increments: 1=Fixed, 2=Exponential
str.PImaxUsed              = fix(header, 144)          ;  144  PI-Max type controller flag
str.PImaxMode              = fix(header, 146)          ;  146  PI-Max mode
str.PImaxGain              = fix(header, 148)          ;  148  PI-Max Gain
str.BackGrndApplied        = fix(header, 150)          ;  150  1 if background subtraction done
str.PImax2nsBrdUsed        = fix(header, 152)          ;  152  T/F PI-Max 2ns Board Used
str.minblk                 = fix(header, 154)          ;  154  min. # of strips per skips
str.numminblk              = fix(header, 156)          ;  156  # of min-blocks before geo skps
str.SpecMirrorLocation     = fix(header, 158, 2)       ;  158  Spectro Mirror Location, 0=Not Present
str.SpecSlitLocation       = fix(header, 162, 4)       ;  162  Spectro Slit Location, 0=Not Present
str.CustomTimingFlag       = fix(header, 170)          ;  170  T/F Custom Timing Used
temp                       = byte(header, 172, TIMEMAX);  172  Experiment Local Time as hhmmss\0
str.ExperimentTimeLocal    = string(temp)              ;  172  Experiment Local Time as hhmmss\0
temp                       = byte(header, 179, TIMEMAX);  179  Experiment UTC Time as hhmmss\0
str.ExperimentTimeUTC      = string(temp)              ;  179  Experiment UTC Time as hhmmss\0
str.ExposUnits             = fix(header, 186)          ;  186  User Units for Exposure
str.ADCoffset              = fix(header, 188)          ;  188  ADC offset
str.ADCrate                = fix(header, 190)          ;  190  ADC rate
str.ADCtype                = fix(header, 192)          ;  192  ADC type
str.ADCresolution          = fix(header, 194)          ;  194  ADC resolution
str.ADCbitAdjust           = fix(header, 196)          ;  196  ADC bit adjust
str.gain                   = fix(header, 198)          ;  198  gain
temp                       = byte(header, 200, COMMENTMAX, 5) ;  200  File Comments
str.Comments               = string(temp)              ;  200  File Comments
str.geometric              = fix(header, 600)          ;  600  geometric ops: rotate 0x01,
                                                        ;       reverse 0x02, flip 0x04
temp                       = byte(header, 602, LABELMAX) ;  602  intensity display string
str.xlabel                 = string(temp)              ;  602  intensity display string
str.cleans                 = fix(header, 618)          ;  618  cleans
str.NumSkpPerCln           = fix(header, 620)          ;  620  number of skips per clean.
str.SpecMirrorPos          = fix(header, 622, 2)       ;  622  Spectrograph Mirror Positions
str.SpecSlitPos            = float(header, 626, 4)     ;  626  Spectrograph Slit Positions
str.AutoCleansActive       = fix(header, 642)          ;  642  T/F
str.UseContCleansInst      = fix(header, 644)          ;  644  T/F
str.AbsorbStripNum         = fix(header, 646)          ;  646  Absorbance Strip Number
str.SpecSlitPosUnits       = fix(header, 648)          ;  648  Spectrograph Slit Position Units
str.SpecGrooves            = float(header, 650)        ;  650  Spectrograph Grating Grooves
str.srccmp                 = fix(header, 654)          ;  654  number of source comp. diodes
str.ydim                   = fix(header, 656)          ;  656  y dimension of raw data.
str.scramble               = fix(header, 658)          ;  658  0=scrambled,1=unscrambled
str.ContinuousCleansFlag   = fix(header, 660)          ;  660  T/F Continuous Cleans Timing Option
str.ExternalTriggerFlag    = fix(header, 662)          ;  662  T/F External Trigger Timing Option
str.lnoscan                = long(header, 664)         ;  664  Number of scans (Early WinX)
str.lavgexp                = long(header, 668)         ;  668  Number of Accumulations
str.ReadoutTime            = float(header, 672)        ;  672  Experiment readout time
str.TriggeredModeFlag      = fix(header, 676)          ;  676  T/F Triggered Timing Option
str.XML_Offset             = ulong64(header, 678)      ;  678  XML Offset
str.Spare_2                = byte(header, 686, 2)      ;  686  
temp                       = byte(header, FILEVERMAX)  ;  688  Version of SW creating this file
str.sw_version             = string(temp)              ;  688  Version of SW creating this file
str.type                   = fix(header, 704)          ;  704  0=1000,1=new120,2=old120,3=130,
                                                       ;       st121=4,st138=5,dc131(PentaMax)=6,
                                                       ;       st133(MicroMax)=7,st135(GPIB)=8,
                                                       ;       VICCD=9, ST116(GPIB)=10,
                                                       ;       OMA3(GPIB)=11,OMA4=12
str.flatFieldApplied       = fix(header, 706)          ;  706  1 if flat field was applied.
str.Spare_3                = byte(header, 708, 16)     ;  708  
str.kin_trig_mode          = fix(header, 724)          ;  724  Kinetics Trigger Mode
temp                       = byte(header, 726, LABELMAX);  726  Data label.
str.dlabel                 = string(temp)              ;  726  Data label.
str.Spare_4                = byte(header, 742, 436)    ;  742
temp                       = byte(header, 1178, HDRNAMEMAX) ;  1178  Name of Pulser File with
                                                       ;           Pulse Widths/Delays (for Z-Slice)
str.PulseFileName          = string(temp)              ;  1178  Name of Pulser File with
                                                       ;           Pulse Widths/Delays (for Z-Slice)
temp                       = byte(header, 1298, HDRNAMEMAX) ; 1298 Name of Absorbance File (if File Mode)
str.AbsorbFileName         = string(temp)              ; 1298 Name of Absorbance File (if File Mode)
str.NumExpRepeats          = long(header, 1418)        ; 1418  Number of Times experiment repeated
str.NumExpAccums           = long(header, 1422)        ; 1422  Number of Time experiment accumulated
str.YT_Flag                = fix(header, 1426)         ; 1426  Set to 1 if this file contains YT data
str.clkspd_us              = float(header, 1428)       ; 1428  Vert Clock Speed in micro-sec
str.HWaccumFlag            = fix(header, 1432)         ; 1432  set to 1 if accum done by Hardware.
str.StoreSync              = fix(header, 1434)         ; 1434  set to 1 if store sync used.
str.BlemishApplied         = fix(header, 1436)         ; 1436  set to 1 if blemish removal applied.
str.CosmicApplied          = fix(header, 1438)         ; 1438  set to 1 if cosmic ray removal applied
str.CosmicType             = fix(header, 1440)         ; 1440  if cosmic ray applied, this is type.
str.CosmicThreshold        = float(header, 1442)       ; 1442  Threshold of cosmic ray removal.
str.NumFrames              = long(header, 1446)        ; 1446  number of frames in file.
str.MaxIntensity           = float(header, 1450)       ; 1450  max intensity of data (future)
str.MinIntensity           = float(header, 1454)       ; 1454  min intensity of data (future)
temp                       = byte(header, 1458, LABELMAX) ; 1458  y axis label.
str.ylabel                 = string(temp)              ; 1458  y axis label.
str.ShutterType            = fix(header, 1474)         ; 1474  shutter type.
str.shutterComp            = float(header, 1476)       ; 1476  shutter compensation time.
str.readoutMode            = fix(header, 1480)         ; 1480  readout mode, full,kinetics, etc
str.WindowSize             = fix(header, 1482)         ; 1482  window size for kinetics only.
str.clkspd                 = fix(header, 1484)         ; 1484  clock speed for kinetics & frame transfer.
str.interface_type         = fix(header, 1486)         ; 1486  computer interface
                                                       ;       (isa-taxi, pci, eisa, etc.)
str.NumROIsInExperiment    = fix(header, 1488)         ; 1488  May be more than the 10 allowed in
                                                       ;       this header (if 0, assume 1)
str.Spare_5                = byte(header, 1490, 16)    ; 1490
str.controllerNum          = fix(header, 1506)         ; 1506  if multiple controller system will
                                                       ;       have controller number data came from.
                                                       ;       this is a future item.
str.SWmade                 = fix(header, 1508)             ; 1508  Which software package created this file
str.NumROI                 = fix(header, 1510)             ; 1510  number of ROIs used. if 0 assume 1.
str.ROIinfoblk             = replicate({princeton_ROIinfo}, ROIMAX)    ; 1512  ROI information  NEEDS WORK
temp                       = byte(header, 1632, HDRNAMEMAX) ; 1632  Flat field file name.
str.FlatField              = string(temp)                   ; 1632  Flat field file name.
temp                       = byte(header, 1752, HDRNAMEMAX) ; 1752  background sub. file name.
str.background             = string(temp)                   ; 1752  background sub. file name.
temp                       = byte(header, 1872, HDRNAMEMAX) ; 1872  blemish file name.
str.blemish                = string(temp)                   ; 1872  blemish file name.
str.file_header_ver        = float(header, 1992)            ; 1992  version of this file header
str.YT_Info                = byte(header, 1996, 1000)  ; 1996-2996  Reserved for YT information
str.WinView_id             = long(header, 2996)        ; 2996  == 0x01234567L if in use by WinView
offset = 3000                                          ; 3000 -> 3488  X axis calibration
str.xcalibration.offset         = double(header, offset)
str.xcalibration.factor         = double(header, offset+8)
str.xcalibration.current_unit   = byte(header, offset+16)
str.xcalibration.CalibReserved1 = byte(header, offset+17)
str.xcalibration.display_string = byte(header, offset+18, 40)
str.xcalibration.CalibReserved2 = byte(header, offset+58, 40)
str.xcalibration.calib_valid    = byte(header, offset+98)
str.xcalibration.input_unit     = byte(header, offset+99)
str.xcalibration.polynounit     = byte(header, offset+100)
str.xcalibration.polynoorder    = byte(header, offset+101)
str.xcalibration.calib_count    = byte(header, offset+102)
str.xcalibration.pixel_position = double(header, offset+103, 10)
str.xcalibration.calib_value    = double(header, offset+183, 10)
str.xcalibration.polynocoeff    = double(header, offset+263, 6)
str.xcalibration.laser_position = double(header, offset+311)
str.xcalibration.CalibReserved3 = byte(header, offset+319)
str.xcalibration.leftover_flag  = byte(header, offset+320)
str.xcalibration.user_label     = byte(header, offset+321, 40)
str.xcalibration.expansion      = byte(header, offset+361, 128)
str.ycalibration           = {princeton_calibration}        
offset = 3489                                         ; 3489 -> 3977  Y axis calibration
str.ycalibration.offset         = double(header, offset)
str.ycalibration.factor         = double(header, offset+8)
str.ycalibration.current_unit   = byte(header, offset+16)
str.ycalibration.CalibReserved1 = byte(header, offset+17)
str.ycalibration.display_string = byte(header, offset+18, 40)
str.ycalibration.CalibReserved2 = byte(header, offset+58, 40)
str.ycalibration.calib_valid    = byte(header, offset+98)
str.ycalibration.input_unit     = byte(header, offset+99)
str.ycalibration.polynounit     = byte(header, offset+100)
str.ycalibration.polynoorder    = byte(header, offset+101)
str.ycalibration.calib_count    = byte(header, offset+102)
str.ycalibration.pixel_position = double(header, offset+103, 10)
str.ycalibration.calib_value    = double(header, offset+183, 10)
str.ycalibration.polynocoeff    = double(header, offset+263, 6)
str.ycalibration.laser_position = double(header, offset+311)
str.ycalibration.CalibReserved3 = byte(header, offset+319)
str.ycalibration.leftover_flag  = byte(header, offset+320)
str.ycalibration.user_label     = byte(header, offset+321, 40)
str.ycalibration.expansion      = byte(header, offset+361, 128)
temp                       = byte(header, 3978, 40)    ; 3978  special intensity scaling string
Istring                    = string(temp)              ; 3978  special intensity scaling string
str.Spare_6                = byte(header, 4018, 80)    ; 4018  
str.lastvalue              = fix(header, 4098)         ; 4098  Always the LAST value in the header
                                                       ; 4100 Bytes Total Header Size

; If this is a big-endian machine swap the byte order
; I don't know of a built-in IDL test for endianness, do it ourselves
t1 = 1
t2 = 1
byteorder, t2, /sswap, /swap_if_big_endian
big_endian = (t1 ne t2)
if (big_endian) then str = swap_endian(str)
return, str
end
