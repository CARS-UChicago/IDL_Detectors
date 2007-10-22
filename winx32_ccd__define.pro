function winx32_ccd::docfileValid
;+
; NAME:
;       WINX32_CCD::docfileValid
;
; PURPOSE:
;       This function returns 1 if there is a valid docFile open with the current
;       WINX32_CCD object, and 0 if there is no valid docFile.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       valid = ccd->docfileValid()
;
; INPUTS:
;       None
;
; OUTPUTS:
;       This function returns 1 if there is a valid docFile open with the current
;       WINX32_CCD object, and 0 if there is no valid docFile.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       valid = ccd->docfileValid()
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    return, obj_valid(self.docfile)
end

function winx32_ccd::setProperty, $
                     exposure_time=exposure_time, $
                     nframes=nframes, $
                     comments=comments, $
                     timing_mode = timing_mode, $
                     file_name = file_name, $
                     file_increment_count = file_increment_count, $
                     file_increment_enable = file_increment_enable
;+
; NAME:
;       WINX32_CCD::setProperty
;
; PURPOSE:
;       This function sets one or more properties of the WINX32_CCD object.   Note that this
;       keyword driven function only allows setting the most commonly used properties.
;       The functions WINX32_CCD::setExpCmdProperty and WINX32_CCD:setDocFileProperty can be used
;       to set any property.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->setProperty()
;
; INPUTS:
;       None
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success and -1 for
;       for failure.
;
; KEYWORD PARAMETERS:
;   EXPOSURE_TIME:  The exposure time in seconds.
;   NFRAMES:        The number of frames to be collected with a single call to WINX32_CCD::Start
;   TIMING_MODE:    The timing mode.  1=Free run, 3=External trigger.
;   FILE_NAME:      The name of the data file for this image.
;   FILE_INCREMENT_COUNT: The next file number if file increment is enabled.
;   FILE_INCREMENT_ENABLE: Set to 1 to enable automatic file incrementing, 0 to disable.
;   COMMENTS:       An string array of up to 5 elements containing comments to be put into the
;                   data file.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->setProperty(exposure_time=0.1, timing_mode=1, file_name='myfile')
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    if (n_elements(exposure_time) ne 0) then begin
        status = self.exp_setup->SetParam(self.exp_cmd.EXP_EXPOSURE, exposure_time)
    endif

    if (n_elements(nframes) ne 0) then begin
        status = self.exp_setup->SetParam(self.exp_cmd.EXP_SEQUENTS, nframes)
    endif
    if (n_elements(timing_mode) ne 0) then begin
        status = self.exp_setup->SetParam(self.exp_cmd.EXP_TIMING_MODE, timing_mode)
    endif
    if (n_elements(file_name) ne 0) then begin
        status = self.exp_setup->SetParam(self.exp_cmd.EXP_DATFILENAME, file_name)
    endif
    if (n_elements(file_increment_count) ne 0) then begin
        status = self.exp_setup->SetParam(self.exp_cmd.EXP_FILEINCCOUNT, file_increment_count)
    endif
    if (n_elements(file_increment_enable) ne 0) then begin
        status = self.exp_setup->SetParam(self.exp_cmd.EXP_FILEINCENABLE, file_increment_enable)
    endif
    if (self->docfileValid()) then begin
        if (n_elements(comments) ne 0) then begin
            ; Make a string array of 5, copy up to 5 input comments to this
            ; This will null out any existing comments beyond those passed
            com = strarr(5)
            com[0] = comments
            status = self.docfile->SetParam(self.dm_cmd.DM_USERCOMMENT1, com[0])
            status = self.docfile->SetParam(self.dm_cmd.DM_USERCOMMENT2, com[1])
            status = self.docfile->SetParam(self.dm_cmd.DM_USERCOMMENT3, com[2])
            status = self.docfile->SetParam(self.dm_cmd.DM_USERCOMMENT4, com[3])
            status = self.docfile->SetParam(self.dm_cmd.DM_USERCOMMENT5, com[4])
        endif
    endif else begin
        status = -1
    endelse
    return, status
end


function winx32_ccd::setExpCmdProperty, property, value
;+
; NAME:
;       WINX32_CCD::setExpCmdProperty
;
; PURPOSE:
;       This function sets a single ExpCmd property of the WINX32_CCD object.  Note that for
;       the most commonly set properties the function WINX32_CCD::setProperty can be used
;       instead of this function.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->setExpCmdProperty(Property, Value)
;
; INPUTS:
;       Property:
;           The property to set.  This is an integer value, which is typically obtained
;           as a member of the structure type {WINX32_EXP_CMD}.
;
;       Value:
;           The value of the property.  The data type of the value will depend on the property
;           being set.
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success and -1 for
;       for failure.
;;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       exp_cmd = WINX32_EXP_CMD_INIT()
;       status = ccd->setExpCmdProperty(exp_cmd.EXP_EXPOSURE, 0.1)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    status = self.exp_setup->SetParam(property, value)
    return, status
end


function winx32_ccd::setDocFileProperty, property, value
;+
; NAME:
;       WINX32_CCD::setDocFileProperty
;
; PURPOSE:
;       This function sets a single DocFile property of the WINX32_CCD object.  Note that for
;       the most commonly set properties the function WINX32_CCD::setProperty can be used
;       instead of this function.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->setDocFileProperty(Property, Value)
;
; INPUTS:
;       Property:
;           The property to set.  This is an integer value, which is typically obtained
;           as a member of the structure type {WINX32_DM_CMD}.
;
;       Value:
;           The value of the property.  The data type of the value will depend on the property
;           being set.
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success and -1 for
;       for failure.
;;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       dm_cmd = WINX32_DM_CMD_INIT()
;       status = ccd->setDocFileProperty(dm_cmd.DM_USERCOMMENT1, "This is comment 1")
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    if (self->docfileValid()) then begin
        status = self.docfile->SetParam(property, value)
    endif else begin
        status = -1
    endelse
    return, status
end

function winx32_ccd::getProperty, $
                     exposure_time=exposure_time, $
                     nframes=nframes, $
                     comments=comments, $
                     timing_mode=timing_mode, $
                     file_name=file_name, $
                     file_increment_count = file_increment_count, $
                     file_increment_enable = file_increment_enable, $
                     controller_name = controller_name
;+
; NAME:
;       WINX32_CCD::getProperty
;
; PURPOSE:
;       This function gets one or more properties of the WINX32_CCD object.   Note that this
;       keyword driven function only allows reading the most commonly used properties.
;       The functions WINX32_CCD::getExpCmdProperty and WINX32_CCD:getDocFileProperty can be used
;       to get any property.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->getProperty()
;
; INPUTS:
;       None
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success and -1 for
;       for failure.
;
; KEYWORD PARAMETERS:
;   EXPOSURE_TIME:  The exposure time in seconds.
;   NFRAMES:        The number of frames to be collected with a single call to WINX32_CCD::Start
;   TIMING_MODE:    The timing mode.  1=Free run, 3=External trigger.
;   FILE_NAME:      The name of the data file for this image.
;   FILE_INCREMENT_COUNT: The next file number if file increment is enabled.
;   FILE_INCREMENT_ENABLE: Set to 1 to enable automatic file incrementing, 0 to disable.
;   CONTROLLER_NAME: The type of controller.  Note that this is actually a number, not a string.
;       0 = "No Controller"
;       1 = "ST143"
;       2 = "ST130"
;       3 = "ST138"
;       4 = "VICCD BOX"
;       5 = "PentaMax"
;       6 = "ST120_T1"
;       7 = "ST120_T2"
;       8 = "ST121"
;       9 = "ST135"
;      10 = "ST133"
;      11 = "VICCD"
;      12 = "ST116"
;      13 = "OMA3"
;      14 = "LOW_COST_SPEC"
;      15 = "MICROMAX"
;      16 = "SPECTROMAX"
;      17 = "MICROVIEW"
;      18 = "ST133_5MHZ"
;      19 = "EMPTY_5MHZ"
;      20 = "EPIX_CONTROLLER"
;      21 = "PVCAM"
;      22 = "GENERIC"
;      23 = "ARC_CCD_100"
;      24 = "ST133_2MHZ"
;   COMMENTS:       An string array of 5 elements containing comments for the data file header.                   data file.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->getProperty(exposure_time=exposure_time, timing_mode=timing_mode,$
;                                 file_name=file_name, controller_name=controller_name)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    status = 0
    if (arg_present(exposure_time)) then begin
        exposure_time = self.exp_setup->GetParam(self.exp_cmd.EXP_EXPOSURE)
    endif
    if (arg_present(nframes)) then begin
        nframes = self.exp_setup->GetParam(self.exp_cmd.EXP_SEQUENTS)
    endif
    if (arg_present(timing_mode)) then begin
        timing_mode = self.exp_setup->GetParam(self.exp_cmd.EXP_TIMING_MODE)
    endif
    if (arg_present(file_name)) then begin
        file_name = self.exp_setup->GetParam(self.exp_cmd.EXP_DATFILENAME)
    endif
    if (arg_present(file_increment_count)) then begin
        file_increment_count = self.exp_setup->GetParam(self.exp_cmd.EXP_FILEINCCOUNT, count)
    endif
    if (arg_present(file_increment_enable)) then begin
        file_increment_enable = self.exp_setup->GetParam(self.exp_cmd.EXP_FILEINCENABLE)
    endif
    if (arg_present(controller_name)) then begin
        controller_name = self.exp_setup->GetParam(self.exp_cmd.EXP_CONTROLLER_NAME)
    endif

    if (self->docfileValid()) then begin
        if (arg_present(comments)) then begin
            comments = strarr(5)
            comments[0] = self.docfile->GetParam(self.dm_cmd.DM_USERCOMMENT1)
            comments[1] = self.docfile->GetParam(self.dm_cmd.DM_USERCOMMENT2)
            comments[2] = self.docfile->GetParam(self.dm_cmd.DM_USERCOMMENT3)
            comments[3] = self.docfile->GetParam(self.dm_cmd.DM_USERCOMMENT4)
            comments[4] = self.docfile->GetParam(self.dm_cmd.DM_USERCOMMENT5)
        endif
    endif else begin
        status = -1
    endelse
    return, status
end

function winx32_ccd::getExpCmdProperty, property, value
;+
; NAME:
;       WINX32_CCD::getExpCmdProperty
;
; PURPOSE:
;       This function gets a single ExpCmd property of the WINX32_CCD object.  Note that for
;       the most commonly read properties the function WINX32_CCD::getProperty can be used
;       instead of this function.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->getExpCmdProperty(Property, Value)
;
; INPUTS:
;       Property:
;           The property to returned.  This is an integer value, which is typically obtained
;           as a member of the structure type {WINX32_EXP_CMD}.
;
; OUTPUTS:
;       Value:
;           The current value of the property.  The data type of the value will depend on the property
;           being read.
;
;       This function returns the status of the command, typically 0 for success and -1 for
;       for failure.
;;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       exp_cmd = WINX32_EXP_CMD_INIT()
;       status = ccd->getExpCmdProperty(exp_cmd.EXP_EXPOSURE, exposure_time)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    value = self.exp_setup->GetParam(property)
    return, 0
end

function winx32_ccd::getDocFileProperty, property, value
;+
; NAME:
;       WINX32_CCD::getDocFileProperty
;
; PURPOSE:
;       This function gets a single DocFile property of the WINX32_CCD object.  Note that for
;       the most commonly read properties the function WINX32_CCD::getProperty can be used
;       instead of this function.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->getDocFileProperty(Property, Value)
;
; INPUTS:
;       Property:
;           The property to return.  This is an integer value, which is typically obtained
;           as a member of the structure type {WINX32_DM_CMD}.
;
; OUTPUTS:
;       Value:
;           The value of the property.  The data type of the value will depend on the property
;           being read.
;
;       This function returns the status of the command, typically 0 for success and -1 for
;       for failure.
;;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       dm_cmd = WINX32_DM_CMD_INIT()
;       status = ccd->getDocFileProperty(dm_cmd.DM_USERCOMMENT1, comment1)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    status = 0
    if (self->docfileValid()) then begin
        value = self.docfile->GetParam(property)
    endif else begin
        status = -1
    endelse
    return, status
end

function winx32_ccd::getData, data, frame=frame
;+
; NAME:
;       WINX32_CCD::getData
;
; PURPOSE:
;       This function returns the data for a single frame from the WINX32_CCD object.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->getData(Data)
;
; INPUTS:
;       None:
;
; OUTPUTS:
;       Data:
;           The data for the frame.
;
;       This function returns the status of the command, typically 0 for success and -1 for
;       for failure.
;
; KEYWORD PARAMETERS:
;   FRAME:  The frame number to return.  Default=1.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->getData(data, frame=100)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    status = 0
    if (n_elements(frame) eq 0) then frame = 1
    if (self->docfileValid()) then begin
       self.docfile->GetFrame, frame, temp
       s = size(temp)
       data = reform(temp, s[2], s[1])
    endif else begin
        status = -1
    endelse
    return, status
end

function winx32_ccd::busy
;+
; NAME:
;       WINX32_CCD::busy
;
; PURPOSE:
;       This function returns the busy status of the WINX32_CCD object. 1 means the controller
;       is busy exposing or reading out, 0 means the controller is idle.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       busy = ccd->busy()
;
; INPUTS:
;       None:
;
; OUTPUTS:
;       This function returns the busy status of the controller,  1 means the controller
;       is busy exposing or reading out, 0 means the controller is idle.
;;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       busy = ccd->busy()
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    busy = self.exp_setup->GetParam(self.exp_cmd.EXP_RUNNING)
    return, busy
end

function winx32_ccd::start
;+
; NAME:
;       WINX32_CCD::start
;
; PURPOSE:
;       This function starts data acquisition on the WINX32_CCD object.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->start()
;
; INPUTS:
;       None:
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success, -1 for failure.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->start()
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    obj_destroy, self.docfile
    self.docfile = self.exp_setup->Start2()
    return, 0
end

function winx32_ccd::stop
;+
; NAME:
;       WINX32_CCD::stop
;
; PURPOSE:
;       This function stops data acquisition on the WINX32_CCD object.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->stop()
;
; INPUTS:
;       None:
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success, -1 for failure.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->stop()
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    status = self.exp_setup->Stop()
    return, status
end

function winx32_ccd::save, file_name
;+
; NAME:
;       WINX32_CCD::save
;
; PURPOSE:
;       This function saves the data for the WINX32_CCD object.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->save, Filename
;
; OPTIONAL INPUTS:
;       Filename:
;           The name of the file to save the data to.  If this input is present then the file
;           name is used to set the DM_FILENAME parameter of the current DocFile object before
;           saving the file.
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success, -1 for failure.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->save('Test1.SPE')
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    if (self->docfileValid()) then begin
        if (n_elements(file_name) ne 0) then begin
            status = self.docfile->SetParam(self.dm_cmd.DM_FILENAME, file_name)
        endif
        status = self.docfile->Save()
    endif else begin
        status = -1
    endelse
    return, status
end

function winx32_ccd::closeDocFile
;+
; NAME:
;       WINX32_CCD::closeDocFile
;
; PURPOSE:
;       This function closes the current DocFile for the WINX32_CCD object. This has the effect of
;       closing the image window in WinView/WinSpec and freeing the DocFile resources.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       status = ccd->closeDocFile()
;
; INPUTS:
;       None
;
; OUTPUTS:
;       This function returns the status of the command, typically 0 for success, -1 for failure.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->closeDocFile()
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006.
;-
    if (self->docfileValid()) then begin
        status = self.docfile->Close()
    endif else begin
        status = -1
    endelse
    return, status
end

function winx32_ccd::init
;+
; NAME:
;       WINX32_CCD::INIT
;
; PURPOSE:
;       This is the initialization code which is invoked when a new object of
;       type WINX32_CCD is created.  It cannot be called directly, but only
;       indirectly by the IDL OBJ_NEW() function.  It initializes the COM interface
;       so that IDL can call the Princeton WINX32 class library under Windows.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       Result = OBJ_NEW('WINX32_CCD')
;
; INPUTS:
;       None
;
; OUTPUTS:
;       This function returns success (1) if it was able to create the EXP_SETUP object in
;       the Princeton WINX32 COM interface.  It returns failure (0) if is was unable to create
;       this object.
;
;       Typically failure means that the Princeton Instruments WinView or WinSpec software is not
;       installed on the machine running IDL.
;
; RESTRICTIONS:
;       This routine cannot be called directly.  It is called indirectly when
;       creating a new object of class MCA by the IDL OBJ_NEW() function.
;
;       This function only works on Windows systems that have the Princeton Instruments
;       WinView or WinSpec software installed.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->start()
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006
;-
    catch, error
    if (error) then return, 0

    ; The Class ID for the exp_setup class can be found as follows:
    ; - Run the Microsoft oleview.exe program that comes with Visual Studio.
    ; - Open Object Classes/All Objects/ExpSetup Class
    ; - The CLSID string displayed there is the one that is needed after the $CLSID$ string below.
    self.exp_setup = obj_new('IDLcomIDispatch$CLSID$E715B92B-25F9-11D1-9330-444553540000')
;    self.docfile = self.exp_setup->GetDocument()
    self.dm_cmd = winx32_dm_cmd_init()
    self.exp_cmd = winx32_exp_cmd_init()
    catch, /cancel
    return, 1
end

pro winx32_ccd__define
;+
; NAME:
;       WINX32_CCD__DEFINE
;
; PURPOSE:
;       This is the definition code which is invoked when a new object of
;       type WINX32_CCD is created.  It cannot be called directly, but only
;       indirectly by the IDL OBJ_NEW() function.  It defines the data
;       structures used for the WINX32_CCD class.
;
; CATEGORY:
;       IDL device class library.
;
; CALLING SEQUENCE:
;       Result = OBJ_NEW('WINX32_CCD')
;
; INPUTS:
;       None
;
; OUTPUTS:
;       None
;
; RESTRICTIONS:
;       This routine cannot be called directly.  It is called indirectly when
;       creating a new object of class WINX32_CCD by the IDL OBJ_NEW()
;       function.
;
;       This procedure only works on Windows systems that have the Princeton Instruments
;       WinView or WinSpec software installed.
;
; EXAMPLE:
;       ccd = obj_new('WINX32_CCD')
;       status = ccd->getProperty(exposure_time=exposure_time)
;
; MODIFICATION HISTORY:
;       Written by:     Mark Rivers, November 1, 2006
;-
    winx32_ccd = {winx32_ccd, $
        docfile: obj_new(), $
        exp_setup: obj_new(), $
        dm_cmd: {winx32_dm_cmd}, $
        exp_cmd: {winx32_exp_cmd} $
    }
end
