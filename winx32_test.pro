; This program collects a bunch of images with WinView as quickly as possible
    numImages = 10
    exposureTime = 0.1
    ccd = obj_new('winx32_ccd')
    t = ccd->stop()
    t = ccd->setProperty(nframes=1)
    t = ccd->setProperty(timing_mode=1)
    t = ccd->setProperty(exposure_time = exposureTime)
    fileName = 'C:\TEMP\testD_'

    for i=1, numImages do begin
        t = ccd->start()
        if (t ne 0) then print, 'Error calling start'
        ; Wait for acquisition to complete
        while (ccd->busy()) do begin
            ;wait, .01
        endwhile
        ; Save the file
        t = ccd->setProperty(file_name=fileName + strtrim(i,2)+'.SPE')
        if (t ne 0) then print, 'Error setting file name'
        t = ccd->save()
        ;if (t ne 0) then print, 'Error calling save =', t
        t = ccd->closeDocfile()
        ;if (t ne 0) then print, 'Error calling close =', t
    endfor
end