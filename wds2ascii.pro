pro wds2ascii, file
;
; convert WDX .SPM file to an ascii file
;
read_wdx, file, energy, counts, header

f      = getfilename(file)
prefix = f.name
suffix = strtrim(f.suffix, 2)
if (suffix ne '') then begin
    nsuffix = strpos(f.name, f.suffix)
    prefix  = strmid(f.name, 0, nsuffix-1)
endif else begin
    suffix = 'dat'
endelse
outfile = prefix + '_ascii.' + suffix
;;; outfile = f.path + '/' + prefix + '_ascii.' + suffix

openw, lun,   outfile, /get_lun
printf, lun, '; MicroSPEC scan: ', file
printf, lun, ';  npoints       = ', header.npoints
printf, lun, ';  begin         = ', header.emin
printf, lun, ';  end           = ', header.emax
printf, lun, ';  slit size     = ', header.slit_size
printf, lun, ';  slit position = ', header.slit_position
printf, lun, ';--------------------'
printf, lun, '; Energy  Counts'
for i = header.npoints-1,0, -1 do begin
    printf, lun, format='(1x,f15.6,1x,f12.2)' , energy[i], counts[i]   
endfor

print, 'wrote ', outfile
close, lun
free_lun, lun
return
end
