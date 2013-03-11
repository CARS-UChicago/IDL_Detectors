pro test_pilatus_snl, pilatus=pilatus, mode=mode, file=file, npoints=npoints, time=time, triggerPV=triggerPV, $
                  trigger_low=trigger_low, trigger_high=trigger_high, detector_delay=detector_delay

    ; This procedure tests the ExtMTrigger or ExtEnable modes of the Pilatus, seeing
    ; how long after the Pilatus is told to acquire before pulses can be sent to
    ; it.
    
    ; This version uses the EPICS SNL code to communicate with the Pilatus

    if (n_elements(pilatus) eq 0) then pilatus = 'GSE-PILATUS2:'
    if (n_elements(mode) eq 0) then mode = 3  ; 3 = ExtMTrigger, 1=ExtEnable
    if (n_elements(file) eq 0) then file = '/disk2/images/testA'
    if (n_elements(triggerPV) eq 0) then triggerPV = '13BMC:DAC1_1'
    if (n_elements(trigger_low) eq 0) then trigger_low = 0
    if (n_elements(trigger_high) eq 0) then trigger_high = 5
    if (n_elements(detector_delay) eq 0) then detector_delay = 0.0
    if (n_elements(npoints) eq 0) then npoints = 50
    if (n_elements(time) eq 0) then time = 0.1

    PULSE_WIDTH = .001
    READOUT_TIME = .004
    response = bytarr(512)
    t = casetmonitor(pilatus + 'Armed')
    
    ; Create a socket connection to camserver
    
    ; Number of points
    t0 = systime(1)
    t = caput(pilatus + 'NImages', npoints, /wait)
    t1 = systime(1)
 
    ; Acquisition time
    t2 = systime(1)
    t = caput(pilatus + 'ExposureTime', time - READOUT_TIME, /wait)
    t3 = systime(1)

    ; Acquisition period
    t2 = systime(1)
    t = caput(pilatus + 'ExposurePeriod', time, /wait)
    t3 = systime(1)
    
    ; Set trigger to be initially low
    t = caput(triggerPV, trigger_low)
    
    ; Set the mode
    t = caput(pilatus + 'AcquireMode', mode)

    if (mode eq 1) then begin  
        ; ExtEnable
        t4 = systime(1)
        t = caput(pilatus + 'Acquire', 1)
        t5 = systime(1)

        ; Wait for the delay time
        wait, detector_delay
        
        ; Wait for the Armed PV to go to 1
        t = caget(pilatus + 'Armed', armed)
        while (armed eq 0) do begin
            wait, .01
            t = caget(pilatus + 'Armed', armed)
        endwhile

        for i=0, npoints-1 do begin
            t = caput(triggerPV, trigger_high)
            wait, time - READOUT_TIME
            t = caput(triggerPV, trigger_low)
            wait, READOUT_TIME
        endfor
     endif else if (mode eq 2) then begin 
        ; ExtTrigger 
        t4 = systime(1)
        t = caput(pilatus + 'Acquire', 1)
        t5 = systime(1)

        ; Wait for the delay time
        wait, detector_delay

        ; Wait for the Armed PV to go to 1
        t = caget(pilatus + 'Armed', armed)
        while (armed eq 0) do begin
            wait, .01
            t = caget(pilatus + 'Armed', armed)
        endwhile

        ; Send a single pulse
         t = caput(triggerPV, trigger_high)
         wait, PULSE_WIDTH
         t = caput(triggerPV, trigger_low)
     endif else if (mode eq 3) then begin 
        ; ExtMTrigger 
        t4 = systime(1)
        t = caput(pilatus + 'Acquire', 1)
        t5 = systime(1)

        ; Wait for the delay time
        wait, detector_delay

        ; Wait for the Armed PV to go to 1
        t = caget(pilatus + 'Armed', armed)
        while (armed eq 0) do begin
            wait, .01
            t = caget(pilatus + 'Armed', armed)
        endwhile

        for i=0, npoints-1 do begin
            t = caput(triggerPV, trigger_high)
            wait, PULSE_WIDTH
            t = caput(triggerPV, trigger_low)
            wait, time - PULSE_WIDTH
        endfor
    endif else begin
        print, 'ERROR - unsupported mode'
    endelse
    print, 'Time for NImages', t1-t0
    print, 'Time for ExpTime', t3-t2
    print, 'Time for expose ', t5-t4
end
