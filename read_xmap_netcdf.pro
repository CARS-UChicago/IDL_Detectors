function read_xmap_netcdf, file, range=range
;+
; NAME:
;   READ_XMAP_NETCDF
;
; PURPOSE:
;   This function reads a netCDF file written by the NDPluginFile plugin in the areaDetector module
;   containing mapping mode data from the XIA xMAP or Mercury modules.
;
;   This function simply calls <a href=#READ_ND_NETCDF>READ_ND_NETCDF</a>, and then calls <a href=#DECODE_XMAP_BUFFERS>DECODE_XMAP_BUFFERS</a>.  
;   It returns the structure returned by <a href=#DECODE_XMAP_BUFFERS>DECODE_XMAP_BUFFERS</a>.
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   Data = READ_XMAP_NETCDF(File, Range=Range)
;
; INPUTS:
;   File:
;       The name of the input file.  If this argument is missing then the dialog_pickfile() function
;       will be called to produce a file browser to select a file interactively.
;
; KEYWORD INPUTS:
;  Range:
;       This keyword is simply passed to READ_ND_NETCDF.  
;       See the documentation for that function for detailed information.
;
; OUTPUTS:
;       This function returns the structure returned by DECODE_XMAP_BUFFERS.  
;       See the documentation for that function for detailed information.
;
; EXAMPLE:
;   This is an example of decoding the buffers for MCA mapping mode data:
;   IDL> d = read_xmap_netcdf('mca_mapping_001.nc')
;   IDL> help, /structure, d
;   ** Structure XMAPDATA, 7 tags, length=28, data length=28:
;      FIRSTPIXEL      LONG                 0
;      NUMPIXELS       LONG              1000
;      PDATA           POINTER   <PtrHeapVar3>
;      PREALTIME       POINTER   <PtrHeapVar4>
;      PLIVETIME       POINTER   <PtrHeapVar5>
;      PINPUTCOUNTS    POINTER   <PtrHeapVar6>
;      POUTPUTCOUNTS   POINTER   <PtrHeapVar7>
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, July 2010
;-
    ; Read the file
    fileData = read_nd_netcdf(file, range=range)
    xmapData = decode_xmap_buffers(fileData)
    return, xmapData
end


