function bas2000_response, settings, input

;+
; NAME:
;   BAS2000_RESPONSE
;
; PURPOSE:
;   This function converts values measured by the BAS2000 scanner into
;   actual x-ray intensities.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   Results = BAS2000_RESPONSE(Settings, Data)
;
; INPUTS:
;   Settings:  
;       A structure of BAS2000 instrument settings of the type created by 
;       READ_BAS2000.
;
;   Data:
;       Raw data values such as those read by READ_BAS2000.  This can be either
;       a single value or an array of values.
;
; OUTPUTS:
;   This function returns the actual x-ray intensities corresponding to the
;   raw input values.
;
; PROCEDURE:
;   This function converts values measured by the BAS2000 scanner into
;   actual x-ray intensities according to the equation:
;
;       PSL = (4000/S)*10^(L*QSL)/1023 - 0.5)
;   where
;       PSL = x-ray intensity
;       S   = sensitivity setting
;       L   = latitude setting
;       QSL = measured value from BAS2000
;
;   This equation appears somewhere in the BAS2000 documentation?
;   
; EXAMPLE:
;   READ_BAS2000, 'Myfile', settings, data
;   Actual = BAS2000_RESPONSE(settings, data)
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, 1997?
;   Modifications:
;       MLR 26-APR-1999 Added documentation header
;-

return, (4000./settings.sensitivity) * $
                exp(alog(10.)*(settings.latitude*(input/1023. - 0.5)))
end
