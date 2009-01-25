pro test_pilatus, pilatus=pilatus, mode=mode, file=file, npoints=npoints, time=time, triggerPV=triggerPV, $
                 trigger_low=trigger_low, trigger_high=trigger_high, detector_delay=detector_delay

    ; This procedure tests the ExtMTrigger or ExtEnable modes of the Pilatus, seeing
    ; how long after the Pilatus is told to acquire before pulses can be sent to
    ; it.

    if (n_elements(pilatus) eq 0) then pilatus = 'gse-pilatus2'
    if (n_elements(mode) eq 0) then mode = 1  ; 3 = ExtMTrigger, 1=ExtEnable
    if (n_elements(file) eq 0) then file = '/disk2/images/testA'
    if (n_elements(triggerPV) eq 0) then triggerPV = '13BMC:DAC1_1'
    if (n_elements(trigger_low) eq 0) then trigger_low = 0
    if (n_elements(trigger_high) eq 0) then trigger_high = 5
    if (n_elements(detector_delay) eq 0) then detector_delay = 0.0
    if (n_elements(npoints) eq 0) then npoints = 50
    if (n_elements(time) eq 0) then time = 0.1

    PORT = 41234L
    PULSE_WIDTH = .001
    READOUT_TIME = .004
    response = bytarr(512)
    
    ; Create a socket connection to camserver
    
    socket, lun, /get, pilatus, PORT, read_timeout=5, /rawio

    ; Number of points
    str = 'NImages ' + string(npoints) + string(10b)
    t0 = systime(1)
    writeu, lun, str
    readu, lun, response, transfer_count=transfer_count
    t1 = systime(1)
    r1 = string(response[0:transfer_count-1])
 
    ; Acquisition time
    t2 = systime(1)
    str = 'ExpTime ' + string(time - READOUT_TIME) + string(10b)
    writeu, lun, str
    readu, lun, response, transfer_count=transfer_count
    t3 = systime(1)
    r2 = string(response[0:transfer_count-1])
    
    ; Set trigger to be initially low
    t = caput(triggerPV, trigger_low)

    if (mode eq 3) then begin  
        ; ExtMTrigger
        str = 'ExtMTrigger ' + file
        t4 = systime(1)
        writeu, lun, str
        readu, lun, response, transfer_count=transfer_count
        t5 = systime(1)
        r3 = string(response[0:transfer_count-1])

        ; Wait for the delay time
        wait, detector_delay

        for i=0, npoints-1 do begin
            t = caput(triggerPV, trigger_high)
            wait, PULSE_WIDTH
            t = caput(triggerPV, trigger_low)
            wait, time - PULSE_WIDTH
        endfor
    endif else if (mode eq 1) then begin  
        ; ExtEnable
        str = 'ExtEnable ' + file + string(10b)
        t4 = systime(1)
        writeu, lun, str
        readu, lun, response, transfer_count=transfer_count
        t5 = systime(1)
        r3 = string(response[0:transfer_count-1])

        ; Wait for the delay time
        wait, detector_delay

        for i=0, npoints-1 do begin
            t = caput(triggerPV, trigger_high)
            wait, time - READOUT_TIME
            t = caput(triggerPV, trigger_low)
            wait, READOUT_TIME
        endfor
    endif else begin
        print, 'ERROR - unsupported mode'
    endelse
    free_lun, lun
    print, 'Time for NImages response = ', t1-t0, ' response = ', r1
    print, 'Time for ExpTime response = ', t3-t2, ' response = ', r2
    print, 'Time for expose  response = ', t5-t4, ' response = ', r3
end
