pro test_point_grey, exposure, readout, nframes

pulser = '13BNC1:BNC1:'
camera = '13BMDPG1:cam1:'
sis = '13BMD:SIS1:'

; Stop the camera and SIS
t = caput(camera + 'Acquire', 'Done')
t = caput(sis + 'StopAll', 'Stop')

t = caput(sis + 'Dwell', exposure+readout)
t = caput(sis + 'NuseAll', nframes)
t = caput(sis + 'ChannelAdvance', 'Internal')

; Set the pulser
t = caput(pulser + 'P1:Width', exposure)
t = caput(pulser + 'Mode', 'Single')
t = caput(pulser + 'ExtMode', 'Trigger')
t = caput(pulser + 'Run', 'Run')


; Set the camera
t = caput(camera + 'ArrayCounter', 0)
t = caput(camera + 'ImageMode', 'Multiple')
t = caput(camera + 'NumImages', nframes)

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
t = caput(sis + 'Run', 'Stop')

end

