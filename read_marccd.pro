bbpro read_marccd, file, data, header

;+
; NAME:
;   READ_MARCCD
;
; PURPOSE:
;   This procedures reads a MAR-CCD format file
;
; CATEGORY:
;   Detectors.
;
; CALLING SEQUENCE:
;   READ_MARCCD, File, Data, Header
;
; INPUTS:
;   File:
;       The name of the MAR-CCD input file.
;
; OUTPUTS:
;   Data:
;       The 2-D array of intensities.  This is a 16-bit UINT array
;
;   Header:
;       A structure which contains the header information.
;       The names of the fields in this structure are meant to be
;       self-explanatory.
;
; EXAMPLE:
;   IDL> READ_MARCCD, 'MgO_090.tif', data, header
;   IDL> print, header.exposure_time
;        60178
;
; MODIFICATION HISTORY:
;   Written by:     Mark Rivers, March 21, 2006
;-

   MAXIMAGES=9
   header = { $
          ; File/header format parameters (256 bytes)
          header_type:          0UL, $ ; flag for header type (can be used as magic number)
          header_name:   bytarr(16), $ ; header name (MMX)
          header_major_version: 0UL, $ ; header_major_version (n.)
          header_minor_version: 0UL, $ ; header_minor_version (.n)
          header_byte_order:    0UL, $ ; BIG_ENDIAN (Motorola,MIPS)
                                       ; LITTLE_ENDIAN (DEC, Intel)
          data_byte_order:      0UL, $ ; BIG_ENDIAN (Motorola,MIPS)
                                       ; LITTLE_ENDIAN (DEC, Intel)
          header_size:          0UL, $ ; in bytes
          frame_type:           0UL, $ ; flag for frame type
          magic_number:         0UL, $ ; to be used as a flag - usually to indicate new file
          compression_type:     0UL, $ ; type of image compression
          compression1:         0UL, $ ; compression parameter 1
          compression2:         0UL, $ ; compression parameter 2
          compression3:         0UL, $ ; compression parameter 3
          compression4:         0UL, $ ; compression parameter 4
          compression5:         0UL, $ ; compression parameter 5
          compression6:         0UL, $ ; compression parameter 6
          nheaders:             0UL, $ ; total number of headers
          nfast:                0UL, $ ; number of pixels in one line
          nslow:                0UL, $ ; number of lines in image
          depth:                0UL, $ ; number of bytes per pixel
          record_length:        0UL, $ ; number of pixels between succesive rows
          signif_bits:          0UL, $ ; true depth of data, in bits
          data_type:            0UL, $ ; (signed,unsigned,float...)
          saturated_value:      0UL, $ ; value marks pixel as saturated
          sequence:             0UL, $ ; TRUE or FALSE
          nimages:              0UL, $ ; total number of images - size of each is nfast*(nslow/nimages)
          origin:               0UL, $ ; corner of origin
          orientation:          0UL, $ ; direction of fast axis
          view_direction:       0UL, $ ; direction to view frame
          overflow_location:    0UL, $ ; FOLLOWING_HEADER, FOLLOWING_DATA
          over_8_bits:          0UL, $ ; # of pixels with counts > 255
          over_16_bits:         0UL, $ ; # of pixels with count > 65535
          multiplexed:          0UL, $ ; multiplex flag
          nfastimages:          0UL, $ ; # of images in fast direction
          nslowimages:          0UL, $ ; # of images in slow direction
          background_applied:   0UL, $ ; flags correction has been applied - hold magic number ?
          bias_applied:         0UL, $ ; flags correction has been applied - hold magic number ?
          flatfield_applied:    0UL, $ ; flags correction has been applied - hold magic number ?
          distortion_applied:   0UL, $ ; flags correction has been applied - hold magic number ?
          original_header_type: 0UL, $ ; Header/frame type from file that frame is read from
          file_saved:           0UL, $ ; Flag that file has been saved, should be zeroed if modified
          reserve1:      bytarr(80), $ ;
          ; Data statistics (128)
          total_counts:  ulonarr(2), $ ; 64 bit integer range = 1.85E19
          special_counts1: ulonarr(2), $ ;
          special_counts2: ulonarr(2), $ ;
          min:                  0UL, $ ;
          max:                  0UL, $ ;
          mean:                 0UL, $ ;
          rms:                  0UL, $ ;
          p10:                  0UL, $ ;
          p90:                  0UL, $ ;
          stats_uptodate:       0UL, $ ;
          pixel_noise: ulonarr(MAXIMAGES), $ ; 1000*base noise value (ADUs)
          reserve2: bytarr((32-13-MAXIMAGES)*4), $ ;
          ; More statistics (256)
          percentile:  uintarr(128), $ ;
          ; Goniostat parameters (128 bytes)
          xtal_to_detector:      0L, $ ; 1000*distance in millimeters
          beam_x:                0L, $ ; 1000*x beam position (pixels)
          beam_y:                0L, $ ; 1000*y beam position (pixels)
          integration_time:      0L, $ ; integration time in milliseconds
          exposure_time:         0L, $ ; exposure time in milliseconds
          readout_time:          0L, $ ; readout time in milliseconds
          nreads:                0L, $ ; number of readouts to get this image
          start_twotheta:        0L, $ ; 1000*two_theta angle
          start_omega:           0L, $ ; 1000*omega angle
          start_chi:             0L, $ ; 1000*chi angle
          start_kappa:           0L, $ ; 1000*kappa angle
          start_phi:             0L, $ ; 1000*phi angle
          start_delta:           0L, $ ; 1000*delta angle
          start_gamma:           0L, $ ; 1000*gamma angle
          start_xtal_to_detector: 0L, $ ; 1000*distance in mm (dist in um)
          end_twotheta:          0L, $ ; 1000*two_theta angle
          end_omega:             0L, $ ; 1000*omega angle
          end_chi:               0L, $ ; 1000*chi angle
          end_kappa:             0L, $ ; 1000*kappa angle
          end_phi:               0L, $ ; 1000*phi angle
          end_delta:             0L, $ ; 1000*delta angle
          end_gamma:             0L, $ ; 1000*gamma angle
          end_xtal_to_detector:  0L, $ ; 1000*distance in mm (dist in um)
          rotation_axis:         0L, $ ; active rotation axis
          rotation_range:        0L, $ ; 1000*rotation angle
          detector_rotx:         0L, $ ; 1000*rotation of detector around X
          detector_roty:         0L, $ ; 1000*rotation of detector around Y
          detector_rotz:         0L, $ ; 1000*rotation of detector around Z
          reserve3: bytarr((32-28)*4), $ ;
          ; Detector parameters (128 bytes)
          detector_type:         0L, $ ; detector type
          pixelsize_x:           0L, $ ; pixel size (nanometers)
          pixelsize_y:           0L, $ ; pixel size (nanometers)
          mean_bias:             0L, $ ; 1000*mean bias value
          photons_per_100adu:    0L, $ ; photons / 100 ADUs
          measured_bias:        lonarr(MAXIMAGES), $ ; 1000*mean bias value for each image
          measured_temperature: lonarr(MAXIMAGES), $ ; Temperature of each detector in milliKelvins
          measured_pressure:    lonarr(MAXIMAGES), $ ; Pressure of each chamber in microTorr
          ; Retired reserve4 when MAXIMAGES set to 9 from 16 and two fields removed,
          ; and temp and pressure added
          ; char reserve4[(32-(5+3*MAXIMAGES))*sizeof(INT32)]
          ; X-ray source and optics parameters (128 bytes)
          ; X-ray source parameters (8*4 bytes)
          source_type:           0L, $ ; (code) - target, synch. etc
          source_dx:             0L, $ ; Optics param. - (size microns)
          source_dy:             0L, $ ; Optics param. - (size microns)
          source_wavelength:     0L, $ ; wavelength (femtoMeters)
          source_power:          0L, $ ; (Watts)
          source_voltage:        0L, $ ; (Volts)
          source_current:        0L, $ ; (microAmps)
          source_bias:           0L, $ ; (Volts)
          source_polarization_x: 0L, $ ; ()
          source_polarization_y: 0L, $ ; ()
          reserve_source: bytarr(4*4), $
          ; X-ray optics_parameters (8*4 bytes)
          optics_type:           0L, $ ; Optics type (code)
          optics_dx:             0L, $ ; Optics param. - (size microns)
          optics_dy:             0L, $ ; Optics param. - (size microns)
          optics_wavelength:     0L, $ ; Optics param. - (size microns)
          optics_dispersion:     0L, $ ; Optics param. - (*10E6)
          optics_crossfire_x:    0L, $ ; Optics param. - (microRadians)
          optics_crossfire_y:    0L, $ ; Optics param. - (microRadians)
          optics_angle:          0L, $ ; Optics param. - (monoch. 2theta - microradians)
          optics_polarization_x: 0L, $ ; ()
          optics_polarization_y: 0L, $ ; ()
          reserve_optics: bytarr(4*4), $
          reserve5: bytarr((32-28)*4), $
          ; File parameters (1024 bytes)
          filetitle:         bytarr(128), $ ; Title
          filepath:          bytarr(128), $ ; path name for data file
          filename:          bytarr(64),  $ ; name of data file
          acquire_timestamp: bytarr(32),  $ ; date and time of acquisition
          header_timestamp:  bytarr(32),  $ ; date and time of header update
          save_timestamp:    bytarr(32),  $ ; date and time file saved
          file_comments:     bytarr(512), $ ; comments - can be used as desired
          reserve6:          bytarr(1024-(128+128+64+(3*32)+512)), $ ;
          ; Dataset parameters (512 bytes)
          dataset_comments:  bytarr(512),  $ ; comments - can be used as desired
          pad: bytarr(3072-(256+128+256+(3*128)+1024+512)) $ ; pad out to 3072 bytes
   }
   openr, lun, file, /get
   tiff_header = bytarr(1024)
   readu, lun, tiff_header, header
   free_lun, lun
   data = read_tiff(file)
end
