local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

tempicon = wibox.container.background(wibox.widget.imagebox(beautiful.widget_temp), widget_color)

tempwidget = wibox.container.background(lain.widget.temp({
  settings = function()
   widget:set_text(" " .. coretemp_now .. "°C")
  end,
  tempfile = "/sys/class/thermal/thermal_zone2/temp"
}).widget, widget_color)

temp_layout = wibox.layout.fixed.horizontal()
temp_layout:add(tempicon)
temp_layout:add(tempwidget)


return temp_layout

