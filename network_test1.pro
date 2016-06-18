; This program tests the speed of writing a TIFF file and then immediately reading it back in the
; same IDL process.  We are trying to track down why it is very slow to read files back from the
; Pilatus areaDetector driver running on Linux, when the files are on a Windows file server, but very fast when they
; are local or on a Linux file server.

pro network_test1, nLoops=nLoops, read=read, write=write
    if (n_elements(nLoops) eq 0) then nLoops = 100
    if (n_elements(read) eq 0) then read=0
    if (n_elements(write) eq 0) then write=0
    data = lindgen(512, 512)
    write_time = dblarr(nLoops)
    read_time = dblarr(nLoops)
    t0 = systime(1)
    
    for i=0, nLoops-1 do begin
        file = 'test' + strtrim(i+1,2) + '.tif'
        t1 = systime(1)
        if (write) then write_tiff, file, data, /long
        t2 = systime(1)
        if (read) then temp = read_tiff(file)
        t3 = systime(1)
        write_time[i] = t2 - t1
        read_time[i] = t3 - t2
        if (i mod 10) eq 0 then print, 'Completed ', i, '/', nLoops
    endfor
    t4 = systime(1)
    cd, current=curdir
    print, 'Current directory = ', curdir
    print, 'Total time = ', t4-t0
    print, 'Write times:'
    print, '  max   =', max(write_time), format='(a, f6.3)' 
    print, '  min   =', min(write_time), format='(a, f6.3)' 
    print, '  mean  =', mean(write_time), format='(a, f6.3)' 
    print, '  median=', median(write_time), format='(a, f6.3)' 
    print, 'Read times:'
    print, '  max   =', max(read_time), format='(a, f6.3)'  
    print, '  min   =', min(read_time), format='(a, f6.3)' 
    print, '  mean  =', mean(read_time), format='(a, f6.3)' 
    print, '  median=', median(read_time), format='(a, f6.3)' 
    ymax = max([max(write_time), max(read_time)])
    plot, write_time, psym=-1, yrange=[0,ymax]
    oplot, read_time, psym=-2
end
    
