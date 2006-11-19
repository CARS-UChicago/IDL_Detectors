function winx32_exp_cmd_init

;+
; NAME:
;       WINX32_EXP_CMD_INIT
;
; PURPOSE:
;       This function returns a structure of type {WINX32_EXP_CMD} with all of the
;       structure members initialized to the integer values for these parameters.
;
;       This structure is used instead of C constants, which are not supported in IDL.
;
;       These values were obtained by opening Microsoft Visual Studio and using
;       Tools/OLD/COM Object Viewer.
;       Open "Type Libraries/Roper Scienfic's WinX/32 3.6 Type Library/typedef enum EXP_CMD.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       exp_cmd = WINX32_EXP_CMD_INIT()
;
; INPUTS:
;       None
;
; OUTPUTS:
;       This function returns a structure of type {WINX32_EXP_CMD} with all of the
;       structure members initialized to the integer values for these parameters.
;
; EXAMPLE:
;       exp_cmd = WINX32_EXP_CMD_INIT()
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->getExpCmdProperty(exp_cmd.EXP_EXPOSURE, exposure_time)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006
;-

exp_cmd = {WINX32_EXP_CMD}
    exp_cmd.EXP_ETACTUAL = 1
    exp_cmd.EXP_SEQUENTS = 2
    exp_cmd.EXP_ERROR = 3
    exp_cmd.EXP_GETCAPS = 4
    exp_cmd.EXP_GETPLSR = 5
    exp_cmd.EXP_DETECTOR_BIT = 16
    exp_cmd.EXP_RUNNING_APP = 23
    exp_cmd.EXP_VIDEO_TYPE = 24
    exp_cmd.EXP_CUSTOM_VIDEO_X = 25
    exp_cmd.EXP_CUSTOM_VIDEO_Y = 26
    exp_cmd.EXP_CUSTOM_VIDEO_FSTWIDTH = 27
    exp_cmd.EXP_CUSTOM_VIDEO_LSTWIDTH = 28
    exp_cmd.EXP_VIDEO_XDIM = 29
    exp_cmd.EXP_VIDEO_YDIM = 30
    exp_cmd.EXP_VIDEO_MAX_ZOOM = 31
    exp_cmd.EXP_VIDEO_HORZ_PAN = 32
    exp_cmd.EXP_VIDEO_VERT_PAN = 33
    exp_cmd.EXP_WORD_MULTIPLIER = 34
    exp_cmd.EXP_TARGET_ID = 35
    exp_cmd.EXP_ADAPTER_ID = 36
    exp_cmd.EXP_NUMADAPTORS = 37
    exp_cmd.EXP_FORCE_PP_INIT = 38
    exp_cmd.EXP_NOP_ADC = 39
    exp_cmd.EXP_ACTUAL_TEMP = 40
    exp_cmd.EXP_FORCE_AUTOSTOP = 41
    exp_cmd.EXP_DEFAULT_VTCLK = 42
    exp_cmd.EXP_MIN_VTCLK = 43
    exp_cmd.EXP_MAX_VTCLK = 44
    exp_cmd.EXP_DEFAULT_HTCLK = 45
    exp_cmd.EXP_MIN_HTCLK = 46
    exp_cmd.EXP_MAX_HTCLK = 47
    exp_cmd.EXP_TIMING_STYLE = 48
    exp_cmd.EXP_HEADSELECT = 49
    exp_cmd.EXP_HORZPHASE = 50
    exp_cmd.EXP_VERTPHASE = 51
    exp_cmd.EXP_SPECIAL_SPEED = 52
    exp_cmd.EXP_PRE_STRIPS = 53
    exp_cmd.EXP_POST_STRIPS = 54
    exp_cmd.EXP_PRE_LINES = 55
    exp_cmd.EXP_POST_LINES = 56
    exp_cmd.EXP_ACTIVE_LINES = 57
    exp_cmd.EXP_ACTIVE_STRIPS = 58
    exp_cmd.EXP_XFER_EXTRA = 59
    exp_cmd.EXP_MIN_BLOCK = 60
    exp_cmd.EXP_NUM_MIN_BLOCK = 61
    exp_cmd.EXP_LOGIC_OUTPUT = 66
    exp_cmd.EXP_VIDEO_BLANK = 67
    exp_cmd.EXP_ZOOM_MODE_VIDEO = 68
    exp_cmd.EXP_LEVEL_SYNC = 69
    exp_cmd.EXP_DISABLE_LASER = 70
    exp_cmd.EXP_ACQBACK_SHUTTER = 71
    exp_cmd.EXP_ACQFLAT_SHUTTER = 72
    exp_cmd.EXP_SMALL_CCD_MINEXP = 73
    exp_cmd.EXP_LARGE_CCD_MINEXP = 74
    exp_cmd.EXP_GATING_MODE = 75
    exp_cmd.EXP_ILME_B1X = 76
    exp_cmd.EXP_ILME_B2X = 77
    exp_cmd.EXP_ILME_D1X = 78
    exp_cmd.EXP_ILME_D2X = 79
    exp_cmd.EXP_ILME_D4X = 80
    exp_cmd.EXP_INIT_HW_ACCUM = 81
    exp_cmd.EXP_5X_GAIN_ENABLE = 82
    exp_cmd.EXP_RET_SRCCMP = 83
    exp_cmd.EXP_EVENT_HANDLE = 84
    exp_cmd.EXP_READOUT_MODE = 85
    exp_cmd.EXP_SHUTTER_TYPE = 86
    exp_cmd.EXP_USER_DEFINED_CHIP = 87
    exp_cmd.EXP_USER_DEFINED_TIMING = 88
    exp_cmd.EXP_CONTROLLER_VERSION = 89
    exp_cmd.EXP_GET_CONTROLLER_VER = 90
    exp_cmd.EXP_TTL_LINES = 91
    exp_cmd.EXP_BIT_ADJUST = 92
    exp_cmd.EXP_RESOLUTION = 93
    exp_cmd.EXP_GAIN = 94
    exp_cmd.EXP_ADC_RATE = 95
    exp_cmd.EXP_ADC_TYPE = 96
    exp_cmd.EXP_NUMBER_OF_CLEANS = 97
    exp_cmd.EXP_NUM_OF_STRIPS_PER_CLN = 98
    exp_cmd.EXP_INTERFACE_CARD = 99
    exp_cmd.EXP_INTERRUPT = 100
    exp_cmd.EXP_IO_ADDRESS1 = 101
    exp_cmd.EXP_IO_ADDRESS2 = 102
    exp_cmd.EXP_IO_ADDRESS3 = 103
    exp_cmd.EXP_HW_ROI = 104
    exp_cmd.EXP_HW_BINNING = 105
    exp_cmd.EXP_EDGE_TRIGGER = 106
    exp_cmd.EXP_SHUTTER_CONTROL = 107
    exp_cmd.EXP_RS170 = 108
    exp_cmd.EXP_RS170_COMPLEX = 109
    exp_cmd.EXP_HW_RS170_LUT = 110
    exp_cmd.EXP_RS170_INTENSITY_SCALING = 111
    exp_cmd.EXP_RS170_OFFSET = 112
    exp_cmd.EXP_RS170_PAN = 113
    exp_cmd.EXP_RS170_ZOOM2X = 114
    exp_cmd.EXP_RS170_ZOOM4X = 115
    exp_cmd.EXP_RS170_BINNING = 116
    exp_cmd.EXP_RS170_DECIMATION = 117
    exp_cmd.EXP_HW_ACCUM = 118
    exp_cmd.EXP_SHT_PREOPEN = 119
    exp_cmd.EXP_STORE_STROBE = 120
    exp_cmd.EXP_CONT_CLNS = 121
    exp_cmd.EXP_TIMING_MODE = 122
    exp_cmd.EXP_EXT_TRIGGER = 123
    exp_cmd.EXP_EVENT_COUNTER = 124
    exp_cmd.EXP_SW_TRIGGER = 125
    exp_cmd.EXP_KINETICS_WINDOWSIZE = 126
    exp_cmd.EXP_EXPOSURE = 127
    exp_cmd.EXP_CONTROLLER_NAME = 128
    exp_cmd.EXP_CCD_CHIP_NAME = 129
    exp_cmd.EXP_BSWBINNING = 297
    exp_cmd.EXP_EDGEENHANCE = 130
    exp_cmd.EXP_BOXVIDEOGAIN = 131
    exp_cmd.EXP_HSHADING_VALUE = 132
    exp_cmd.EXP_VSHADING_VALUE = 133
    exp_cmd.EXP_EDGEENHANCE_FLAG = 134
    exp_cmd.EXP_SHADING_FLAG = 135
    exp_cmd.EXP_GRAYSCALE = 136
    exp_cmd.EXP_OFFSET = 137
    exp_cmd.EXP_CCDGAIN = 138
    exp_cmd.EXP_TEMPERATURE = 139
    exp_cmd.EXP_MCPVOLTAGE = 140
    exp_cmd.EXP_BOXEXPOSURE = 141
    exp_cmd.EXP_ABC_FLAG = 142
    exp_cmd.EXP_GAMMA_FLAG = 143
    exp_cmd.EXP_AUTOBLACK_FLAG = 144
    exp_cmd.EXP_AGC_FLAG = 145
    exp_cmd.EXP_ODD_FIELD = 146
    exp_cmd.EXP_FIELD_SELECT = 147
    exp_cmd.EXP_RESET = 148
    exp_cmd.EXP_EXTERN_ENABLE = 149
    exp_cmd.EXP_CONTROLLERS_SUPPORTED = 150
    exp_cmd.EXP_VTCLK = 151
    exp_cmd.EXP_HTCLK = 152
    exp_cmd.EXP_GATE_VS_CW = 153
    exp_cmd.EXP_COM_PORT = 154
    exp_cmd.EXP_US_UNITS = 156
    exp_cmd.EXP_MS_UNITS = 157
    exp_cmd.EXP_SEC_UNITS = 158
    exp_cmd.EXP_MIN_UNITS = 159
    exp_cmd.EXP_HRS_UNITS = 160
    exp_cmd.EXP_FRAME_UNITS = 161
    exp_cmd.EXP_SYNC_ASYNC = 162
    exp_cmd.EXP_FOCUS_NFRAME = 163
    exp_cmd.EXP_TIMEOUT = 164
    exp_cmd.EXP_TIMEOUT_DEFAULT = 165
    exp_cmd.EXP_HW_AUTOSTOP = 166
    exp_cmd.EXP_RS170_INTEN_OFFSET = 167
    exp_cmd.EXP_CONTROLLER_ALIVE = 168
    exp_cmd.EXP_FOCUS_TYPE = 169
    exp_cmd.EXP_FOCUS_ZOOM = 170
    exp_cmd.EXP_FOCUS_PAN = 171
    exp_cmd.EXP_MULTI_TAP_ROI = 172
    exp_cmd.EXP_USE_INTERUPTS = 173
    exp_cmd.EXP_DATA_ACQ_STATE = 174
    exp_cmd.EXP_VERIFY_GOOD_VALUES = 175
    exp_cmd.EXP_WHITE_CLAMP = 176
    exp_cmd.EXP_BLACK_CLAMP = 177
    exp_cmd.EXP_DELAY_TIME = 178
    exp_cmd.EXP_READOUT_TIME = 179
    exp_cmd.EXP_SW_DIAG = 180
    exp_cmd.EXP_DIAG1 = 181
    exp_cmd.EXP_DIAG2 = 182
    exp_cmd.EXP_DIAG3 = 183
    exp_cmd.EXP_DIAG4 = 184
    exp_cmd.EXP_DIAG5 = 185
    exp_cmd.EXP_AorB_GROUP = 186
    exp_cmd.EXP_ABSORBANCE_FLAG = 187
    exp_cmd.EXP_ABSORBANCE_METHOD = 188
    exp_cmd.EXP_ABSORBANCE_STRIPNUM = 189
    exp_cmd.EXP_DMASIZE_VIA_DRIVER = 190
    exp_cmd.EXP_DRIVERVERSION = 191
    exp_cmd.EXP_NUM_DEVICES = 192
    exp_cmd.EXP_ECPDMA_CHANNEL = 193
    exp_cmd.EXP_CUSTOM_SHUTTER = 194
    exp_cmd.EXP_ADC_OFFSET = 195
    exp_cmd.EXP_CURRENT_READOUT_MODE = 196
    exp_cmd.EXP_BANK_ADD = 197
    exp_cmd.EXP_LUT_BANK = 198
    exp_cmd.EXP_SETUP_STATUS = 201
    exp_cmd.EXP_XY_GROUPING = 239
    exp_cmd.EXP_MESSAGES_FLAG = 240
    exp_cmd.EXP_TTL_LINE_TO_WAIT = 253
    exp_cmd.EXP_DATA_COLLECTION_MODE = 258
    exp_cmd.EXP_DATA_COLLECTION_TYPE = 262
    exp_cmd.EXP_SKIPFRAMES = 274
    exp_cmd.EXP_CLR_INT_CNTR = 276
    exp_cmd.EXP_ENABLE_INT_CNTR = 277
    exp_cmd.EXP_INT_CNTR = 278
    exp_cmd.EXP_INTERNAL_SYNC_SRC = 279
    exp_cmd.EXP_SW_EXTSYNC = 280
    exp_cmd.EXP_PTG_PRESENT = 281
    exp_cmd.EXP_ELEC_SHT = 282
    exp_cmd.EXP_BOARDS_WITH_NVRAM = 283
    exp_cmd.EXP_ANLGMASTER_ST143 = 284
    exp_cmd.EXP_ANLGSLAVE_ST143 = 285
    exp_cmd.EXP_DISPLAY_ST143 = 286
    exp_cmd.EXP_INTRFACE_ST143 = 287
    exp_cmd.EXP_SCANCONTROL_ST143 = 288
    exp_cmd.EXP_NUMBERFRAMES_IRQ = 204
    exp_cmd.EXP_COOL_TYPE = 214
    exp_cmd.EXP_HD_TYPE = 215
    exp_cmd.EXP_INTENSIFER_GAIN = 216
    exp_cmd.EXP_SHT_GATE_MODE = 217
    exp_cmd.EXP_HD_CHECK = 218
    exp_cmd.EXP_AMP_MODE = 219
    exp_cmd.EXP_ANALOG_GAIN = 220
    exp_cmd.EXP_HW_FIXES = 221
    exp_cmd.EXP_PCI_CARDS = 222
    exp_cmd.EXP_NOT_REVERSE = 223
    exp_cmd.EXP_LOAD_NVRAM_DEFAULTS = 234
    exp_cmd.EXP_CNTR_BRD = 235
    exp_cmd.EXP_XDIMHW = 237
    exp_cmd.EXP_YDIMHW = 238
    exp_cmd.EXP_SPECIAL_FAST_RDOUT = 254
    exp_cmd.EXP_SPCL_FAST_Y_DIM = 255
    exp_cmd.EXP_SPCL_FAST_X_DIM = 256
    exp_cmd.EXP_SPCL_FAST_Y_INDEX = 257
    exp_cmd.EXP_SHUTTER_COMP_TIME_MS = 266
    exp_cmd.EXP_NVRAM_AVAIL = 267
    exp_cmd.EXP_NUMBER_AGAIN_AVAIL = 269
    exp_cmd.EXP_SENSOR_TYPE = 270
    exp_cmd.EXP_EVENT_TYPE = 292
    exp_cmd.EXP_ANTI_BLOOMING = 293
    exp_cmd.EXP_FAST_PULSE_ENABLE = 233
    exp_cmd.EXP_USE_HEADCALIB = 296
    exp_cmd.EXP_TEMP_STATUS = 301
    exp_cmd.EXP_MULTIPLE_READMODES_LIVE = 302
    exp_cmd.EXP_FIRST_ACQUIRE_FLAG = 303
    exp_cmd.EXP_ANTI_BLOOMING_CONTROL = 304
    exp_cmd.EXP_PRE_HORZ_DELAY = 305
    exp_cmd.EXP_NVRAM_TRIES = 306
    exp_cmd.EXP_XASCEND = 307
    exp_cmd.EXP_YASCEND = 308
    exp_cmd.EXP_ALT_TIMING = 309
    exp_cmd.EXP_SHUTTER_PRE_COMP = 310
    exp_cmd.EXP_PVCAM_POSSIBLE = 311
    exp_cmd.EXP_ADC_IN_NVRAM = 312
    exp_cmd.EXP_PASSTHRU_MODE = 313
    exp_cmd.EXP_FIRMWAREVERSION = 314
    exp_cmd.EXP_IMMEDIATE_SHUTTER = 315
    exp_cmd.EXP_STAGE2_TEMP = 316
    exp_cmd.EXP_AVGAIN_ENABLED = 317
    exp_cmd.EXP_AVGAIN_SETPOINT = 318
    exp_cmd.EXP_AVGAIN = 319
    exp_cmd.EXP_AVGAIN_CALIB_TEMP = 320
    exp_cmd.EXP_AVGAIN_CALIB_COEFF1 = 321
    exp_cmd.EXP_AVGAIN_CALIB_COEFF2 = 322
    exp_cmd.EXP_AVGAIN_CALIB_COEFF3 = 323
    exp_cmd.EXP_AVGAIN_CALIB_COEFF4 = 324
    exp_cmd.EXP_AVGAIN_CALIB_COEFF5 = 325
    exp_cmd.EXP_FORCE_READOUT_MODE = 326
    exp_cmd.EXP_RESET_DATACOLLECTION = 327
    exp_cmd.EXP_ACTIVE_SUBFRAME = 328
    exp_cmd.EXP_CLASSNAME = 775
    exp_cmd.EXP_FLATFLDNAME = 776
    exp_cmd.EXP_DARKNAME = 777
    exp_cmd.EXP_SETUPNAME = 778
    exp_cmd.EXP_ACCESSNAME = 779
    exp_cmd.EXP_DATFILENAME = 780
    exp_cmd.EXP_ABSORBFILENAME = 781
    exp_cmd.EXP_BLEMISHFILENAME = 782
    exp_cmd.EXP_COSMICFILENAME = 783
    exp_cmd.EXP_FILEINCBASENAME = 784
    exp_cmd.EXP_YTNAME = 785
    exp_cmd.EXP_DEVNAME = 786
    exp_cmd.EXP_USEROI = 787
    exp_cmd.EXP_DOBLEMISH = 788
    exp_cmd.EXP_DOABSORB = 789
    exp_cmd.EXP_DOCOSMIC = 790
    exp_cmd.EXP_COSMICSENS = 791
    exp_cmd.EXP_ABSORBSTRIP = 792
    exp_cmd.EXP_DATATYPE = 793
    exp_cmd.EXP_OVERWRITECONFIRM = 794
    exp_cmd.EXP_FILEINCENABLE = 795
    exp_cmd.EXP_FILEINCCOUNT = 796
    exp_cmd.EXP_RUNNING = 797
    exp_cmd.EXP_SAVEROPT = 798
    exp_cmd.EXP_TIME_UNITS = 799
    exp_cmd.EXP_FILEACCESS = 800
    exp_cmd.EXP_AUTOSAVE = 801
    exp_cmd.EXP_NEWWINDOW = 802
    exp_cmd.EXP_XDIM = 803
    exp_cmd.EXP_YDIM = 804
    exp_cmd.EXP_XDIMDET = 805
    exp_cmd.EXP_YDIMDET = 806
    exp_cmd.EXP_ROIMODE = 807
    exp_cmd.EXP_NUMREPEATSEXP = 808
    exp_cmd.EXP_NUMACCUMSEXP = 809
    exp_cmd.EXP_THREADSTATE = 810
    exp_cmd.EXP_USEMINTHRESHOLDING = 811
    exp_cmd.EXP_MINTHRESHOLDVALUE = 812
    exp_cmd.EXP_USEMAXTHRESHOLDING = 813
    exp_cmd.EXP_MAXTHRESHOLDVALUE = 814
    exp_cmd.EXP_RUNNING_EXPERIMENT = 815
    exp_cmd.EXP_THRESHOLD_DEMAND_UPDATE = 816
    exp_cmd.EXP_ROICOUNT = 817
    exp_cmd.EXP_ACCUMS = 818
    exp_cmd.EXP_CACCUMS = 819
    exp_cmd.EXP_CSEQUENTS = 820
    exp_cmd.EXP_PHOTON_ESTIMATION_ENABLE = 821
    exp_cmd.EXP_PHOTON_MAXTIME = 822
    exp_cmd.EXP_PHOTON_MAXTIMEUNIT = 823
    exp_cmd.EXP_CUSTOMFILTER_ENABLE = 824
    exp_cmd.EXP_CUSTOMFILTER_SIZE = 825
    exp_cmd.EXP_LOOKUPTABLE_ENABLE = 826
    exp_cmd.EXP_BSHOWWINDOW = 827
    exp_cmd.EXP_BBACKSUBTRACT = 828
    exp_cmd.EXP_BDOFLATFIELD = 829
    exp_cmd.EXP_ASCIIOUTPUTFILE = 830
    exp_cmd.EXP_ASCIIOUTPUT_DELIMITER = 831
    exp_cmd.EXP_ASCIIOUTPUT_TERMINATOR = 832
    exp_cmd.EXP_FFTYPE = 833
    exp_cmd.EXP_BGTYPE = 834
    exp_cmd.EXP_COSGRASS = 835
    exp_cmd.EXP_RUNASCONFIRM = 836
    exp_cmd.EXP_RUNASRUNACCESS = 837
    exp_cmd.EXP_DATAFILETYPE = 838
    exp_cmd.EXP_ROTATE = 839
    exp_cmd.EXP_FLIP = 840
    exp_cmd.EXP_REVERSE = 841
    exp_cmd.EXP_SWBINNING = 842
    exp_cmd.EXP_AUTOSTORE = 843
    exp_cmd.EXP_XBINNED = 844
    exp_cmd.EXP_YBINNED = 845
    exp_cmd.EXP_NUMPATTERNS = 846
    exp_cmd.EXP_EXPERIMENTTIME = 847
    exp_cmd.EXP_ASYNCSEQUENTIALS = 848
    exp_cmd.EXP_SEQUENTIALS = 849
    exp_cmd.EXP_CSEQUENTIALS = 850
    exp_cmd.EXP_AUTOD = 851
    exp_cmd.EXP_EXPOSURETIME = 852
    exp_cmd.EXP_EXPOSURETIME_UNITS = 853
    exp_cmd.EXP_ACQMODE = 854
    exp_cmd.EXP_DMASIZE_PVCAM = 855
    exp_cmd.EXP_INITIALIZE = 856
    exp_cmd.EXP_CELL_X_SIZE = 857
    exp_cmd.EXP_CELL_Y_SIZE = 858
    exp_cmd.EXP_X_GAP_SIZE = 859
    exp_cmd.EXP_Y_GAP_SIZE = 860

    return, exp_cmd

end
