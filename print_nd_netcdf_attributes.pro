pro print_nd_netcdf_attributes, file

;+
; NAME:
;   PRINT_ND_NETCDF_ATTRIBUTES
;
; PURPOSE:
;   This function prints the values of the attributes in a netCDF file written by the NDPluginFile plugin in the areaDetector module.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   PRINT_ND_NETCDF_ATTRIBUTES, File
;
; INPUTS:
;   File:
;       The name of the input file.  If this argument is missing then the dialog_pickfile() function
;       will be called to produce a file browser to select a file interactively.
;
; 
    d = read_nd_netcdf(file, attr=attr, /nodata)
    numAttr = n_elements(attr)
    for i=0, numAttr-1 do begin
        val = *attr[i].pValue
        diff = val ne val[0]
        if (max(diff) eq 0) then val = val[0]
        name = attr[i].name
        if (strpos(name, 'Attr_') eq 0) then name = strmid(name, 5)
        print, name
        print, '  Description: ', attr[i].description
        print, '  Value:       ', strtrim(val,2)
        print
    endfor
end 

