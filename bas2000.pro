pro bas2000_event, event

@img_com
common bas2000_common, data

widget_control, event.id, get_value=value, /hourglass

case value of
  "Open...": begin
    file = pickfile( filter='*.img', /read, /noconfirm, /must_exist)
    if file ne "" then begin
      widget_control, /hourglass
      file_parse, file, dev, dir, name, ext, ver
      file = dev + dir + name
      read_bas2000, file, settings, data
      data = rebin( data, 512, 640)
      data = transpose( data)
;     data = bas2000_response( settings, data)
      img_scl, data
    endif
  endcase

  "Exit": widget_control, event.top, /destroy

  "Color": xloadct

  "Zoom":  ;pan_zoom

  "Rectangle": ;box_cursor, x0, y0, nx, ny

  "Circle":    ;circle_cursor, x0, y0, r

  "Irregular": begin
    ; a = def_roi()
    ; statistics, raw_data(a)
   endcase
     
  "Line Profile":      ;points=profile()
  "Row and Column":    if n_elements(data) ne 0 then profile_row_col

  "Sobel":          img_scl, sobel(data)
  "Roberts":        img_scl, roberts(data)
  "Boxcar":         img_scl, smooth(data, 5)
  "Median":         img_scl, median(data, 5)
  "Original Image": img_scl, data

  "Help": xdisplayfile, 'idl_dir:[user.detectors]bas2000_help.txt', $
                        title = 'Help on BAS2000', width = 50, height = 4

endcase

end


;*************************************************************************

pro bas2000 ; procedure to display BAS2000 image plate images

@font_common
font_init
widget_control, default_font=MEDIUM_FONT

base    = widget_base( title="BAS2000")
buttons = widget_base( base, /row)
image   = widget_draw( base,  retain=2, xsize=640, ysize=512, yoffset=50)

file_menu = ['"File" {',    $
               '"Open..."', $
               '"Exit" }']   
xpdmenu, file_menu, buttons

b = widget_button( buttons, value="Color")
b = widget_button( buttons, value="Zoom")

prmenu = ['"Profiles" {',           $
              '"Line Profile"',     $
              '"Row and Column" }']
xpdmenu, prmenu, buttons

ipmenu = ['"Image Processing" {',     $
              '"Edge Enhancement" {', $
                  '"Sobel"',          $
                  '"Roberts"',        $
              '}',                    $
               '"Smoothing" {',       $
                  '"Boxcar"',         $
                  '"Median"',         $
              '}',                    $
               '"Original Image"',    $
              '}',                    $
        '}']
xpdmenu, ipmenu, buttons

roimenu = ['"Regions" {',    $
              '"Rectangle"', $
              '"Circle"',    $
              '"Irregular" }']
xpdmenu, roimenu, buttons

b = widget_label(  buttons, value = '         ')
b = widget_button( buttons, value = 'Help')

widget_control, base, /REALIZE
xmanager, "BAS2000", base

end
