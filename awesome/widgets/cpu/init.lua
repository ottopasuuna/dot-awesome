local awful     = require("awful")
local wibox     = require("wibox")
local lain      = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

cpuicon = wibox.container.background(wibox.widget.imagebox(beautiful.widget_cpu), widget_color)

mycpu = lain.widget.cpu({
  settings = function()
   widget:set_markup(" " .. cpu_now.usage .. "%")
  end
})
cpuwidget = wibox.container.background(mycpu.widget, widget_color)

widget_layout = wibox.layout.fixed.horizontal()
widget_layout:add(cpuicon)
widget_layout:add(cpuwidget)

return widget_layout
