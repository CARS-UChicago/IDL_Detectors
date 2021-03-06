pro winx32_dm_cmd__define

;+
; NAME:
;       WINX32_DM_CMD__DEFINE
;
; PURPOSE:
;       This is the definition code which is invoked when a new structure of
;       type WINX32_DM_CMD is created.  It cannot be called directly, but only
;       indirectly by using the IDL automatic structure creation mechanism.
;       It defines the data structure for the WINX32_DM_CMD structure type.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       dm_cmd = {WINX32_DM_CMD}
;
; INPUTS:
;       None
;
; OUTPUTS:
;       None
;
; RESTRICTIONS:
;       This routine cannot be called directly.  It is called indirectly when
;       creating a new structure of type WINX32_DM_CMD.
;
;       Note that the values in the definition are actually lost when the structure is
;       created, all values are set to 0.  The function WINX32_DM_CMD_INIT() should be used
;       to create a structure of this type with their values initialized correctly.
;;
; EXAMPLE:
;       dm_cmd = {WINX32_DM_CMD}
;       print, dm_cmd.DM_USERCOMMENT1
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006
;-

dm_cmd = {WINX32_DM_CMD, $
    DM_XDIMDET: 1, $
    DM_YDIMDET: 2, $
    DM_TIMINGMODE: 3, $
    DM_EXPOSEC: 4, $
    DM_DETTYPE: 5, $
    DM_XDIM: 6, $
    DM_YDIM: 7, $
    DM_ASYNEN: 8, $
    DM_DATATYPE: 9, $
    DM_PIXELSIZE: 10, $
    DM_MINBLK: 11, $
    DM_NUMMINBLK: 12, $
    DM_ADCRATE: 13, $
    DM_ADCTYPE: 14, $
    DM_ADCRESOLUTION: 15, $
    DM_ADCBITADJUST: 16, $
    DM_GAIN: 17, $
    DM_GEOMETRIC: 18, $
    DM_CLEANS: 19, $
    DM_NUMSKPPERCLN: 20, $
    DM_FILEVERSION: 21, $
    DM_SWVERSION: 22, $
    DM_CONTROLLERTYPE: 23, $
    DM_NUMFRAMES: 24, $
    DM_MAXINTENSITY: 25, $
    DM_MININTENSITY: 26, $
    DM_SHUTTERTYPE: 27, $
    DM_SHUTTERCOMP: 28, $
    DM_READOUTMODE: 29, $
    DM_WINDOWSIZE: 30, $
    DM_CLKSPD: 31, $
    DM_KINTRIGMODE: 32, $
    DM_CLKSPD_us: 33, $
    DM_INTERFACETYPE: 34, $
    DM_NOT_IN_USE_0: 35, $
    DM_NOT_IN_USE_1: 36, $
    DM_NOT_IN_USE_2: 37, $
    DM_NOT_IN_USE_3: 38, $
    DM_NOT_IN_USE_4: 39, $
    DM_NOT_IN_USE_5: 40, $
    DM_COSMICAPPLIED: 41, $
    DM_COSMICTYPE: 42, $
    DM_COSMICTHRESHOLD: 43, $
    DM_BLEMISHAPPLIED: 44, $
    DM_FLATFIELDAPPLIED: 45, $
    DM_BACKGROUNDAPPLIED: 46, $
    DM_ACCUMS: 47, $
    DM_HWACCUMS: 48, $
    DM_NOT_IN_USE_6: 49, $
    DM_NOT_IN_USE_7: 50, $
    DM_NOT_IN_USE_8: 51, $
    DM_STORESYNC: 52, $
    DM_SWMADE: 53, $
    DM_FLATFIELDNAME: 54, $
    DM_BACKSUBNAME: 55, $
    DM_XLABEL: 56, $
    DM_YLABEL: 57, $
    DM_DLABEL: 58, $
    DM_FILEDATE: 59, $
    DM_BLEMISHFILE: 60, $
    DM_USERINFO: 61, $
    DM_USERCOMMENT1: 62, $
    DM_USERCOMMENT2: 63, $
    DM_USERCOMMENT3: 64, $
    DM_USERCOMMENT4: 65, $
    DM_USERCOMMENT5: 66, $
    DM_xCAL_OFFSET: 67, $
    DM_xCAL_FACTOR: 68, $
    DM_xCAL_CURR_UNIT: 69, $
    DM_xCAL_STRING: 70, $
    DM_xCAL_VALID: 71, $
    DM_xCAL_INPUT_UNIT: 72, $
    DM_xCAL_POLYNOM_UNIT: 73, $
    DM_xCAL_CALIB_COUNT: 74, $
    DM_xCAL_PXL_POS: 75, $
    DM_xCAL_PXL_VAL: 76, $
    DM_xCAL_POLYNOM_ORDER: 77, $
    DM_xCAL_COEFFS: 78, $
    DM_xCAL_LASERLINE: 79, $
    DM_xCAL_FILE_LABEL: 80, $
    DM_NUMROI: 81, $
    DM_ROI_STARTX: 82, $
    DM_ROI_ENDX: 83, $
    DM_ROI_GP_X: 84, $
    DM_ROI_STARTY: 85, $
    DM_ROI_ENDY: 86, $
    DM_ROI_GP_Y: 87, $
    DM_CONTROLLERNUM: 88, $
    DM_DEFAULTTYPE: 89, $
    DM_FRAMECOUNT: 90, $
    DM_LASTFRAMERDY: 91, $
    DM_FRAMEINPROS: 92, $
    DM_SCANCOUNT: 93, $
    DM_TEMPFLAG: 94, $
    DM_STOREFLAG: 95, $
    DM_FRAMESIZE: 96, $
    DM_ISDISPLAYED: 97, $
    DM_INUSE: 98, $
    DM_LASTVALUE: 99, $
    DM_STOREFLAGSAVE: 100, $
    DM_YTFLAG: 101, $
    DM_YT_AREAS_EQUS: 102, $
    DM_YT_POINTS_TAKEN: 103, $
    DM_FILENAME: 104, $
    DM_FILETITLE: 105, $
    DM_DOCTYPE: 106, $
    DM_NUMEXPREPEATS: 107, $
    DM_NUMEXPACCUMS: 108, $
    DM_UPDATEVIEWS: 109, $
    DM_PULSEFILENAME: 110, $
    DM_PULSEREPWIDTH: 111, $
    DM_PULSEREPDELAY: 112, $
    DM_CONTROLLERVERSION: 113, $
    DM_LOGICOUTPUT: 114, $
    DM_VIRTUALCHIPFLAG: 115, $
    DM_PULSERTYPE: 116, $
    DM_AMPHICAPLOWNOISE: 117, $
    DM_VCHIPXDIM: 118, $
    DM_VCHIPYDIM: 119, $
    DM_PIMAXUSED: 120, $
    DM_PIMAXMODE: 121, $
    DM_SHUTTERCONTROL: 122, $
    DM_ABSORBLIVE: 123, $
    DM_ABSORBMODE: 124, $
    DM_ABSORBSTRIPNUM: 125, $
    DM_THRESHOLDMINLIVE: 126, $
    DM_THRESHOLDMAXLIVE: 127, $
    DM_SPECAUTOSPECTROMODE: 128, $
    DM_SPECGLUEFLAG: 129, $
    DM_PULSERMODE: 130, $
    DM_PULSERONCHIPACCUMS: 131, $
    DM_PULSERREPEATEXP: 132, $
    DM_PULSESEQINCMODE: 133, $
    DM_ADCOFFSET: 134, $
    DM_ABSORBFILENAME: 135, $
    DM_NUMROISINEXPERIMENT: 136, $
    DM_SPECMIRRORLOCATION: 137, $
    DM_SPECSLITLOCATION: 138, $
    DM_SPECMIRRORPOS: 139, $
    DM_READOUTTIME: 140, $
    DM_DETTEMPERATURE: 141, $
    DM_DELAYTIME: 142, $
    DM_THRESHOLDMINVAL: 143, $
    DM_THRESHOLDMAXVAL: 144, $
    DM_SPECCENTERWLNM: 145, $
    DM_SPECGLUESTARTWLNM: 146, $
    DM_SPECGLUEENDWLNM: 147, $
    DM_SPECGLUEMINOVRLPNM: 148, $
    DM_SPECGLUEFINALRESNM: 149, $
    DM_PULSESEQSTARTWIDTH: 150, $
    DM_PULSESEQENDWIDTH: 151, $
    DM_PULSESEQSTARTDELAY: 152, $
    DM_PULSESEQENDDELAY: 153, $
    DM_SPECSLITPOS: 154, $
    DM_AUTOCLEANSACTIVE: 155, $
    DM_USECONTCLEANSINST: 156, $
    DM_CUSTOMCHIPFLAG: 157, $
    DM_XPREPIXELS: 158, $
    DM_XPOSTPIXELS: 159, $
    DM_YPREPIXELS: 160, $
    DM_YPOSTPIXELS: 161, $
    DM_CUSTOMTIMINGFLAG: 162, $
    DM_CANDOVIRTUALCHIPFLAG: 163, $
    DM_PIMAXGAIN: 164, $
    DM_PIMAX2NSBRDUSED: 165, $
    DM_TRIGGEREDMODEFLAG: 166, $
    DM_CONTINUOUSCLEANSFLAG: 167, $
    DM_EXTERNALTRIGGERFLAG: 168, $
    DM_EXPERIMENTTIMELOCAL: 169, $
    DM_EXPERIMENTTIMEUTC: 170, $
    DM_EXPOSUNITS: 171, $
    DM_SPECSLITPOSUNITS: 172, $
    DM_SPECGROOVES: 173, $
    DM_AVGAINUSED: 174, $
    DM_AVGAIN: 175, $
    DM_ANALOGGAIN: 176, $
    DM_SPECTYPE: 177, $
    DM_SPECMODEL: 178, $
    DM_PULSEBURSTUSED: 179, $
    DM_PULSEBURSTCOUNT: 180, $
    DM_PULSEBURSTPERIOD: 181, $
    DM_PULSEBRACKETUSED: 182, $
    DM_PULSEBRACKETTYPE: 183, $
    DM_PULSETIMECONSTFAST: 184, $
    DM_PULSEAMPLITUDEFAST: 185, $
    DM_PULSETIMECONSTSLOW: 186, $
    DM_PULSEAMPLITUDESLOW: 187 $
}
end
