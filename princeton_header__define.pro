pro princeton_header__define
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

HEADER_VERSION  = 2.0

  C_UNKNOWN         =  -1
  C_ST1000          =  0
  C_ST120NEW        =  1
  C_ST120OLD        =  2
  C_ST130           =  3
  C_ST121           =  4
  C_ST138           =  5
  C_DC131           =  6
  C_ST133           =  7
  C_ST135           =  8
  C_VICCD           =  9
  C_ST116           = 10
  C_OMA3            = 11
  C_OMA4            = 12
  C_ST143           = 13
  C_VICCDBOX        = 14
  C_MICROMAX        = 15
  C_SPECTROMAX      = 16
  C_MICROVIEW       = 17
  C_LOW_COST_SPEC   = 18
  C_ST133_5MHZ      = 19
  C_EMPTY_5MHZ      = 20
  C_EPIX_CONTROLLER = 21
  C_PVCAM           = 22
  C_GENERIC         = 23

ROIinfo = {princeton_ROIinfo, $      ; ROI information
  startx: 0, $                 ; left x start value.
  endx: 0, $                   ; right x value.
  groupx: 0, $                 ; amount x is binned/grouped in hw.
  starty: 0, $                 ; top y start value.
  endy: 0, $                   ; bottom y value.
  groupy: 0 $                 ; amount y is binned/grouped in hw.
}                              ; 12 Bytes Each

princeton_calibration = {princeton_calibration, $
    offset:         0.d, $          ; 3000  3489  offset for absolut data scaling
    factor:         0.d, $          ; 3008  3497  factor for absolut data scaling
    current_unit:   0B, $;          ; 3016  3505  selected scaling unit
    CalibReserved1: 0B, $           ; 3017  3506  reserved
    display_string: bytarr(40), $   ; 3018  3507  string used for drawing axes...
    CalibReserved2: bytarr(40), $   ; 3058  3547  reserved
    calib_valid:    0B, $           ; 3098  3587  flag if calibration is valid
    input_unit:     0B, $           ; 3099  3588  current input units for "calib_value"
    polynounit:     0B, $           ; 3100  3589  linear UNIT and used in the "polynocoeff"
    polynoorder:    0B, $           ; 3101  3590  ORDER of calibration POLYNOM
    calib_count:    0B, $           ; 3102  3591  valid calibration data pairs
    pixel_position: dblarr(10), $   ; 3103  3592  pixel pos. of calibration data
    calib_value:    dblarr(10), $   ; 3183  3672  calibration VALUE at above pos
    polynocoeff:    dblarr(6), $    ; 3263  3752  polynom COEFFICIENTS
    laser_position: 0.d, $          ; 3311  3800  laser wavenumber for relativ WN
    CalibReserved3: 0B, $           ; 3319  3808  reserved
    leftover_flag:  0B, $           ; 3320  3809  not used.
    user_label:     bytarr(40), $   ; 3321  3810  Calibration label
    expansion:      bytarr(128)  $  ; 3361  3850  Expansion area
}

princeton_header = {princeton_header, $
  ControllerVersion:    0, $                ;    0  Hardware Version
  LogicOutput:          0, $                ;    2  Definition of Output BNC
  AmpHiCapLowNoise:     0, $                ;    4  Amp Switching Mode
  xDimDet:              0, $                ;    6  Detector x dimension of chip.
  mode:                 0, $                ;    8  timing mode
  exp_sec:              0., $               ;   10  alternitive exposure, in sec.
  VChipXdim:            0, $                ;   14  Virtual Chip X dim
  VChipYdim:            0, $;               ;   16  Virtual Chip Y dim
  yDimDet:              0, $                ;   18  y dimension of CCD or detector.
  date:                 "", $               ;   20  date
  VirtualChipFlag:      0, $                ;   30  On/Off
  Spare_1:              bytarr(2), $        ;   32
  noscan:               0, $                ;   34  Old number of scans - should always be -1
  DetTemperature:       0., $               ;   36  Detector Temperature Set
  DetType:              0, $                ;   40  CCD/DiodeArray type
  xdim:                 0, $                ;   42  actual # of pixels on x axis
  stdiode:              0, $                ;   44  trigger diode
  DelayTime:            0., $               ;   46  Used with Async Mode
  ShutterControl:       0, $                ;   50  Normal, Disabled Open, Disabled Closed
  AbsorbLive:           0, $                ;   52  On/Off
  AbsorbMode:           0, $                ;   54  Reference Strip or File
  CanDoVirtualChipFlag: 0, $                ;   56  T/F Cont/Chip able to do Virtual Chip
  ThresholdMinLive:     0, $                ;   58  On/Off
  ThresholdMinVal:      0., $               ;   60  Threshold Minimum Value
  ThresholdMaxLive:     0, $                ;   64  On/Off
  ThresholdMaxVal:      0., $               ;   66  Threshold Maximum Value
  SpecAutoSpectroMode:  0, $                ;   70  T/F Spectrograph Used
  SpecCenterWlNm:       0., $               ;   72  Center Wavelength in Nm
  SpecGlueFlag:         0, $                ;   76  T/F File is Glued
  SpecGlueStartWlNm:    0., $               ;   78  Starting Wavelength in Nm
  SpecGlueEndWlNm:      0., $               ;   82  Starting Wavelength in Nm
  SpecGlueMinOvrlpNm:   0., $               ;   86  Minimum Overlap in Nm
  SpecGlueFinalResNm:   0., $               ;   90  Final Resolution in Nm
  PulserType:           0, $                ;   94  0=None, PG200=1, PTG=2, DG535=3
  CustomChipFlag:       0, $                ;   96  T/F Custom Chip Used
  XPrePixels:           0, $                ;   98  Pre Pixels in X direction
  XPostPixels:          0, $                ;  100  Post Pixels in X direction
  YPrePixels:           0, $                ;  102  Pre Pixels in Y direction 
  YPostPixels:          0, $                ;  104  Post Pixels in Y direction
  asynen:               0, $                ;  106  asynchron enable flag  0 = off
  datatype:             0, $                ;  108  experiment datatype
                                            ;       0 =   FLOATING POINT
                                            ;       1 =   LONG INTEGER
                                            ;       2 =   INTEGER
                                            ;       3 =   UNSIGNED INTEGER
  PulserMode:           0, $                ;  110  Repetitive/Sequential
  PulserOnChipAccums:   0, $                ;  112  Num PTG On-Chip Accums
  PulserRepeatExp:      0L, $               ;  114  Num Exp Repeats (Pulser SW Accum)
  PulseRepWidth:        0., $               ;  118  Width Value for Repetitive pulse (usec)
  PulseRepDelay:        0., $               ;  122  Width Value for Repetitive pulse (usec)
  PulseSeqStartWidth:   0., $               ;  126  Start Width for Sequential pulse (usec)
  PulseSeqEndWidth:     0., $               ;  130  End Width for Sequential pulse (usec)
  PulseSeqStartDelay:   0., $               ;  134  Start Delay for Sequential pulse (usec)
  PulseSeqEndDelay:     0., $               ;  138  End Delay for Sequential pulse (usec)
  PulseSeqIncMode:      0, $                ;  142  Increments: 1=Fixed, 2=Exponential
  PImaxUsed:            0, $                ;  144  PI-Max type controller flag
  PImaxMode:            0, $                ;  146  PI-Max mode
  PImaxGain:            0, $                ;  148  PI-Max Gain
  BackGrndApplied:      0, $                ;  150  1 if background subtraction done
  PImax2nsBrdUsed:      0, $                ;  152  T/F PI-Max 2ns Board Used
  minblk:               0, $                ;  154  min. # of strips per skips
  numminblk:            0, $                ;  156  # of min-blocks before geo skps
  SpecMirrorLocation:   intarr(2), $        ;  158  Spectro Mirror Location, 0=Not Present
  SpecSlitLocation:     intarr(4), $        ;  162  Spectro Slit Location, 0=Not Present
  CustomTimingFlag:     0, $                ;  170  T/F Custom Timing Used
  ExperimentTimeLocal:  "", $               ;  172  Experiment Local Time as hhmmss\0
  ExperimentTimeUTC:    "", $               ;  179  Experiment UTC Time as hhmmss\0
  ExposUnits:           0, $                ;  186  User Units for Exposure
  ADCoffset:            0, $                ;  188  ADC offset
  ADCrate:              0, $                ;  190  ADC rate
  ADCtype:              0, $                ;  192  ADC type
  ADCresolution:        0, $                ;  194  ADC resolution
  ADCbitAdjust:         0, $                ;  196  ADC bit adjust
  gain:                 0, $                ;  198  gain
  Comments:             strarr(5), $        ;  200  File Comments
  geometric:            0, $                ;  600  geometric ops: rotate 0x01,
                                            ;       reverse 0x02, flip 0x04
  xlabel:               "", $               ;  602  intensity display string
  cleans:               0, $                ;  618  cleans
  NumSkpPerCln:         0, $                ;  620  number of skips per clean.
  SpecMirrorPos:        intarr(2), $        ;  622  Spectrograph Mirror Positions
  SpecSlitPos:          fltarr(4), $        ;  626  Spectrograph Slit Positions
  AutoCleansActive:     0, $                ;  642  T/F
  UseContCleansInst:    0, $                ;  644  T/F
  AbsorbStripNum:       0, $                ;  646  Absorbance Strip Number
  SpecSlitPosUnits:     0, $                ;  648  Spectrograph Slit Position Units
  SpecGrooves:          0., $               ;  650  Spectrograph Grating Grooves
  srccmp:               0, $                ;  654  number of source comp. diodes
  ydim:                 0, $                ;  656  y dimension of raw data.
  scramble:             0, $                ;  658  0=scrambled,1=unscrambled
  ContinuousCleansFlag: 0, $                ;  660  T/F Continuous Cleans Timing Option
  ExternalTriggerFlag:  0, $                ;  662  T/F External Trigger Timing Option
  lnoscan:              0L, $               ;  664  Number of scans (Early WinX)
  lavgexp:              0L, $               ;  668  Number of Accumulations
  ReadoutTime:          0., $               ;  672  Experiment readout time
  TriggeredModeFlag:    0, $                ;  676  T/F Triggered Timing Option
  Spare_2:              bytarr(10), $       ;  678  
  sw_version:           "", $               ;  688  Version of SW creating this file
  type:                 0, $                ;  704  0=1000,1=new120,2=old120,3=130,
                                            ;       st121=4,st138=5,dc131(PentaMax)=6,
                                            ;       st133(MicroMax)=7,st135(GPIB)=8,
                                            ;       VICCD=9, ST116(GPIB)=10,
                                            ;       OMA3(GPIB)=11,OMA4=12
  flatFieldApplied:     0, $                ;  706  1 if flat field was applied.
  Spare_3:              bytarr(16), $       ;  708  
  kin_trig_mode:        0, $                ;  724  Kinetics Trigger Mode
  dlabel:               "", $               ;  726  Data label.
  Spare_4:              bytarr(436), $      ;  742
  PulseFileName:        "", $               ;  1178  Name of Pulser File with
                                            ;           Pulse Widths/Delays (for Z-Slice)
  AbsorbFileName:       "", $               ; 1298 Name of Absorbance File (if File Mode)
  NumExpRepeats:        0L, $               ; 1418  Number of Times experiment repeated
  NumExpAccums:         0L, $               ; 1422  Number of Time experiment accumulated
  YT_Flag:              0, $                ; 1426  Set to 1 if this file contains YT data
  clkspd_us:            0., $               ; 1428  Vert Clock Speed in micro-sec
  HWaccumFlag:          0, $                ; 1432  set to 1 if accum done by Hardware.
  StoreSync:            0, $                ; 1434  set to 1 if store sync used.
  BlemishApplied:       0, $                ; 1436  set to 1 if blemish removal applied.
  CosmicApplied:        0, $                ; 1438  set to 1 if cosmic ray removal applied
  CosmicType:           0, $                ; 1440  if cosmic ray applied, this is type.
  CosmicThreshold:      0., $               ; 1442  Threshold of cosmic ray removal.
  NumFrames:            0L, $               ; 1446  number of frames in file.
  MaxIntensity:         0., $               ; 1450  max intensity of data (future)
  MinIntensity:         0., $               ; 1454  min intensity of data (future)
  ylabel:               "", $               ; 1458  y axis label.
  ShutterType:          0, $                ; 1474  shutter type.
  shutterComp:          0., $               ; 1476  shutter compensation time.
  readoutMode:          0, $                ; 1480  readout mode, full,kinetics, etc
  WindowSize:           0, $                ; 1482  window size for kinetics only.
  clkspd:               0, $                ; 1484  clock speed for kinetics & frame transfer.
  interface_type:       0, $                ; 1486  computer interface
                                            ;       (isa-taxi, pci, eisa, etc.)
  NumROIsInExperiment:  0, $                ; 1488  May be more than the 10 allowed in
                                            ;       this header (if 0, assume 1)
  Spare_5:              bytarr(16), $       ; 1490
  controllerNum:        0, $                ; 1506  if multiple controller system will
                                            ;       have controller number data came from.
                                            ;       this is a future item.
  SWmade:               0, $                ; 1508  Which software package created this file
  NumROI:               0, $                ; 1510  number of ROIs used. if 0 assume 1.
  ROIinfoblk:           replicate(ROIinfo, ROIMAX), $     ; 1512  ROI information
  FlatField:            "", $               ; 1632  Flat field file name.
  background:           "", $               ; 1752  background sub. file name.
  blemish:              "", $               ; 1872  blemish file name.
  file_header_ver:      0., $               ; 1992  version of this file header
  YT_Info:              bytarr(1000), $     ; 1996-2996  Reserved for YT information
  WinView_id:           0L, $               ; 2996  == 0x01234567L if in use by WinView
  xcalibration:         {princeton_calibration}, $ ; 3000 -> 3488  X axis calibration
  ycalibration:         {princeton_calibration}, $ ; 3489 -> 3977  Y axis calibration
  Istring:              "", $               ; 3978  special intensity scaling string
  Spare_6:              bytarr(80), $       ; 4018  
  lastvalue:            0  $                ; 4098  Always the LAST value in the header
}                                           ; 4100 Bytes Total Header Size

end
