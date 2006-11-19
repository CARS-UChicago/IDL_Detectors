; These values are obtained by opening Microsoft Visual Studio and using Tools/OLD/COM Object Viewer.
; Open "Type Libraries/Roper Scienfic's WinX/32 3.6 Type Library/typedef enum DM_CMD

function winx32_dm_cmd_init
;+
; NAME:
;       WINX32_DM_CMD_INIT
;
; PURPOSE:
;       This function returns a structure of type {WINX32_DM_CMD} with all of the
;       structure members initialized to the integer values for these parameters.
;
;       This structure is used instead of C constants, which are not supported in IDL.
;
;       These values were obtained by opening Microsoft Visual Studio and using
;       Tools/OLD/COM Object Viewer.
;       Open "Type Libraries/Roper Scienfic's WinX/32 3.6 Type Library/typedef enum DM_CMD.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       dm_cmd = WINX32_DM_CMD_INIT()
;
; INPUTS:
;       None
;
; OUTPUTS:
;       This function returns a structure of type {WINX32_DM_CMD} with all of the
;       structure members initialized to the integer values for these parameters.
;
; EXAMPLE:
;       dm_cmd = WINX32_EXP_CMD_INIT()
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->setProperty(exposure_time=0.1)
;       status = ccd->start()
;       wait, 1.
;       status = ccd->getDocFileProperty(dm_cmd.DM_USERCOMMENT1, comment1)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006
;-

    dm_cmd = {winx32_dm_cmd}
    dm_cmd.DM_XDIMDET = 1
    dm_cmd.DM_YDIMDET = 2
    dm_cmd.DM_TIMINGMODE = 3
    dm_cmd.DM_EXPOSEC = 4
    dm_cmd.DM_DETTYPE = 5
    dm_cmd.DM_XDIM = 6
    dm_cmd.DM_YDIM = 7
    dm_cmd.DM_ASYNEN = 8
    dm_cmd.DM_DATATYPE = 9
    dm_cmd.DM_PIXELSIZE = 10
    dm_cmd.DM_MINBLK = 11
    dm_cmd.DM_NUMMINBLK = 12
    dm_cmd.DM_ADCRATE = 13
    dm_cmd.DM_ADCTYPE = 14
    dm_cmd.DM_ADCRESOLUTION = 15
    dm_cmd.DM_ADCBITADJUST = 16
    dm_cmd.DM_GAIN = 17
    dm_cmd.DM_GEOMETRIC = 18
    dm_cmd.DM_CLEANS = 19
    dm_cmd.DM_NUMSKPPERCLN = 20
    dm_cmd.DM_FILEVERSION = 21
    dm_cmd.DM_SWVERSION = 22
    dm_cmd.DM_CONTROLLERTYPE = 23
    dm_cmd.DM_NUMFRAMES = 24
    dm_cmd.DM_MAXINTENSITY = 25
    dm_cmd.DM_MININTENSITY = 26
    dm_cmd.DM_SHUTTERTYPE = 27
    dm_cmd.DM_SHUTTERCOMP = 28
    dm_cmd.DM_READOUTMODE = 29
    dm_cmd.DM_WINDOWSIZE = 30
    dm_cmd.DM_CLKSPD = 31
    dm_cmd.DM_KINTRIGMODE = 32
    dm_cmd.DM_CLKSPD_us = 33
    dm_cmd.DM_INTERFACETYPE = 34
    dm_cmd.DM_NOT_IN_USE_0 = 35
    dm_cmd.DM_NOT_IN_USE_1 = 36
    dm_cmd.DM_NOT_IN_USE_2 = 37
    dm_cmd.DM_NOT_IN_USE_3 = 38
    dm_cmd.DM_NOT_IN_USE_4 = 39
    dm_cmd.DM_NOT_IN_USE_5 = 40
    dm_cmd.DM_COSMICAPPLIED = 41
    dm_cmd.DM_COSMICTYPE = 42
    dm_cmd.DM_COSMICTHRESHOLD = 43
    dm_cmd.DM_BLEMISHAPPLIED = 44
    dm_cmd.DM_FLATFIELDAPPLIED = 45
    dm_cmd.DM_BACKGROUNDAPPLIED = 46
    dm_cmd.DM_ACCUMS = 47
    dm_cmd.DM_HWACCUMS = 48
    dm_cmd.DM_NOT_IN_USE_6 = 49
    dm_cmd.DM_NOT_IN_USE_7 = 50
    dm_cmd.DM_NOT_IN_USE_8 = 51
    dm_cmd.DM_STORESYNC = 52
    dm_cmd.DM_SWMADE = 53
    dm_cmd.DM_FLATFIELDNAME = 54
    dm_cmd.DM_BACKSUBNAME = 55
    dm_cmd.DM_XLABEL = 56
    dm_cmd.DM_YLABEL = 57
    dm_cmd.DM_DLABEL = 58
    dm_cmd.DM_FILEDATE = 59
    dm_cmd.DM_BLEMISHFILE = 60
    dm_cmd.DM_USERINFO = 61
    dm_cmd.DM_USERCOMMENT1 = 62
    dm_cmd.DM_USERCOMMENT2 = 63
    dm_cmd.DM_USERCOMMENT3 = 64
    dm_cmd.DM_USERCOMMENT4 = 65
    dm_cmd.DM_USERCOMMENT5 = 66
    dm_cmd.DM_xCAL_OFFSET = 67
    dm_cmd.DM_xCAL_FACTOR = 68
    dm_cmd.DM_xCAL_CURR_UNIT = 69
    dm_cmd.DM_xCAL_STRING = 70
    dm_cmd.DM_xCAL_VALID = 71
    dm_cmd.DM_xCAL_INPUT_UNIT = 72
    dm_cmd.DM_xCAL_POLYNOM_UNIT = 73
    dm_cmd.DM_xCAL_CALIB_COUNT = 74
    dm_cmd.DM_xCAL_PXL_POS = 75
    dm_cmd.DM_xCAL_PXL_VAL = 76
    dm_cmd.DM_xCAL_POLYNOM_ORDER = 77
    dm_cmd.DM_xCAL_COEFFS = 78
    dm_cmd.DM_xCAL_LASERLINE = 79
    dm_cmd.DM_xCAL_FILE_LABEL = 80
    dm_cmd.DM_NUMROI = 81
    dm_cmd.DM_ROI_STARTX = 82
    dm_cmd.DM_ROI_ENDX = 83
    dm_cmd.DM_ROI_GP_X = 84
    dm_cmd.DM_ROI_STARTY = 85
    dm_cmd.DM_ROI_ENDY = 86
    dm_cmd.DM_ROI_GP_Y = 87
    dm_cmd.DM_CONTROLLERNUM = 88
    dm_cmd.DM_DEFAULTTYPE = 89
    dm_cmd.DM_FRAMECOUNT = 90
    dm_cmd.DM_LASTFRAMERDY = 91
    dm_cmd.DM_FRAMEINPROS = 92
    dm_cmd.DM_SCANCOUNT = 93
    dm_cmd.DM_TEMPFLAG = 94
    dm_cmd.DM_STOREFLAG = 95
    dm_cmd.DM_FRAMESIZE = 96
    dm_cmd.DM_ISDISPLAYED = 97
    dm_cmd.DM_INUSE = 98
    dm_cmd.DM_LASTVALUE = 99
    dm_cmd.DM_STOREFLAGSAVE = 100
    dm_cmd.DM_YTFLAG = 101
    dm_cmd.DM_YT_AREAS_EQUS = 102
    dm_cmd.DM_YT_POINTS_TAKEN = 103
    dm_cmd.DM_FILENAME = 104
    dm_cmd.DM_FILETITLE = 105
    dm_cmd.DM_DOCTYPE = 106
    dm_cmd.DM_NUMEXPREPEATS = 107
    dm_cmd.DM_NUMEXPACCUMS = 108
    dm_cmd.DM_UPDATEVIEWS = 109
    dm_cmd.DM_PULSEFILENAME = 110
    dm_cmd.DM_PULSEREPWIDTH = 111
    dm_cmd.DM_PULSEREPDELAY = 112
    dm_cmd.DM_CONTROLLERVERSION = 113
    dm_cmd.DM_LOGICOUTPUT = 114
    dm_cmd.DM_VIRTUALCHIPFLAG = 115
    dm_cmd.DM_PULSERTYPE = 116
    dm_cmd.DM_AMPHICAPLOWNOISE = 117
    dm_cmd.DM_VCHIPXDIM = 118
    dm_cmd.DM_VCHIPYDIM = 119
    dm_cmd.DM_PIMAXUSED = 120
    dm_cmd.DM_PIMAXMODE = 121
    dm_cmd.DM_SHUTTERCONTROL = 122
    dm_cmd.DM_ABSORBLIVE = 123
    dm_cmd.DM_ABSORBMODE = 124
    dm_cmd.DM_ABSORBSTRIPNUM = 125
    dm_cmd.DM_THRESHOLDMINLIVE = 126
    dm_cmd.DM_THRESHOLDMAXLIVE = 127
    dm_cmd.DM_SPECAUTOSPECTROMODE = 128
    dm_cmd.DM_SPECGLUEFLAG = 129
    dm_cmd.DM_PULSERMODE = 130
    dm_cmd.DM_PULSERONCHIPACCUMS = 131
    dm_cmd.DM_PULSERREPEATEXP = 132
    dm_cmd.DM_PULSESEQINCMODE = 133
    dm_cmd.DM_ADCOFFSET = 134
    dm_cmd.DM_ABSORBFILENAME = 135
    dm_cmd.DM_NUMROISINEXPERIMENT = 136
    dm_cmd.DM_SPECMIRRORLOCATION = 137
    dm_cmd.DM_SPECSLITLOCATION = 138
    dm_cmd.DM_SPECMIRRORPOS = 139
    dm_cmd.DM_READOUTTIME = 140
    dm_cmd.DM_DETTEMPERATURE = 141
    dm_cmd.DM_DELAYTIME = 142
    dm_cmd.DM_THRESHOLDMINVAL = 143
    dm_cmd.DM_THRESHOLDMAXVAL = 144
    dm_cmd.DM_SPECCENTERWLNM = 145
    dm_cmd.DM_SPECGLUESTARTWLNM = 146
    dm_cmd.DM_SPECGLUEENDWLNM = 147
    dm_cmd.DM_SPECGLUEMINOVRLPNM = 148
    dm_cmd.DM_SPECGLUEFINALRESNM = 149
    dm_cmd.DM_PULSESEQSTARTWIDTH = 150
    dm_cmd.DM_PULSESEQENDWIDTH = 151
    dm_cmd.DM_PULSESEQSTARTDELAY = 152
    dm_cmd.DM_PULSESEQENDDELAY = 153
    dm_cmd.DM_SPECSLITPOS = 154
    dm_cmd.DM_AUTOCLEANSACTIVE = 155
    dm_cmd.DM_USECONTCLEANSINST = 156
    dm_cmd.DM_CUSTOMCHIPFLAG = 157
    dm_cmd.DM_XPREPIXELS = 158
    dm_cmd.DM_XPOSTPIXELS = 159
    dm_cmd.DM_YPREPIXELS = 160
    dm_cmd.DM_YPOSTPIXELS = 161
    dm_cmd.DM_CUSTOMTIMINGFLAG = 162
    dm_cmd.DM_CANDOVIRTUALCHIPFLAG = 163
    dm_cmd.DM_PIMAXGAIN = 164
    dm_cmd.DM_PIMAX2NSBRDUSED = 165
    dm_cmd.DM_TRIGGEREDMODEFLAG = 166
    dm_cmd.DM_CONTINUOUSCLEANSFLAG = 167
    dm_cmd.DM_EXTERNALTRIGGERFLAG = 168
    dm_cmd.DM_EXPERIMENTTIMELOCAL = 169
    dm_cmd.DM_EXPERIMENTTIMEUTC = 170
    dm_cmd.DM_EXPOSUNITS = 171
    dm_cmd.DM_SPECSLITPOSUNITS = 172
    dm_cmd.DM_SPECGROOVES = 173
    dm_cmd.DM_AVGAINUSED = 174
    dm_cmd.DM_AVGAIN = 175
    dm_cmd.DM_ANALOGGAIN = 176
    dm_cmd.DM_SPECTYPE = 177
    dm_cmd.DM_SPECMODEL = 178
    dm_cmd.DM_PULSEBURSTUSED = 179
    dm_cmd.DM_PULSEBURSTCOUNT = 180
    dm_cmd.DM_PULSEBURSTPERIOD = 181
    dm_cmd.DM_PULSEBRACKETUSED = 182
    dm_cmd.DM_PULSEBRACKETTYPE = 183
    dm_cmd.DM_PULSETIMECONSTFAST = 184
    dm_cmd.DM_PULSEAMPLITUDEFAST = 185
    dm_cmd.DM_PULSETIMECONSTSLOW = 186
    dm_cmd.DM_PULSEAMPLITUDESLOW = 187

    return, dm_cmd
end
