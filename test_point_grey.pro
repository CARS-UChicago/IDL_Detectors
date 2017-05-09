pro test_point_grey, exposure, readout, nframes

camera = '13PG1:cam1:'
sis = '13LAB:SIS3820:'

; Stop the camera and SIS
t = caput(camera + 'Acquire', 'Done')
t = caput(sis + 'StopAll', 'Stop')

t = caput(sis + 'Dwell', exposure+readout)
t = caput(sis + 'NuseAll', nframes)
t = caput(sis + 'ChannelAdvance', 'Internal')

; Set the camera
t = caput(camera + 'ArrayCounter', 0)
t = caput(camera + 'ImageMode', 'Multiple')
t = caput(camera + 'NumImages', nframes)
t = caput(camera + 'AcquireTime', exposure)
t = caput(camera + 'TriggerMode', 'Overlapped')

; Start the camera
t = caput(camera + 'Acquire', 'Acquire')
; Wait .2 seconds for camera to start
wait, .2

; Start the SIS
t = caput(sis + 'EraseStart', 'Erase')

; Wait for the expected time
wait, (exposure + readout)*nframes + 3
t = caget(camera + 'Acquire', acquire)
t = caget(camera + 'ArrayCounter_RBV', ndone)
if (acquire eq 0) and (ndone eq nframes) then begin
  print, 'Success, ndone=', ndone
endif else begin
  print, 'Failure, ndone=', ndone
endelse
t = caput(camera + 'Acquire', 'Done')
t = caput(sis + 'StopAll', 'Stop')

end

