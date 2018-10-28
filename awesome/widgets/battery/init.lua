local awful     = require("awful")
local wibox     = require("wibox")
local lain      = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

local battery = lain.widget.bat({
    settings = function()
    widget:set_text(bat_now.perc .. '%')
    end
})
batterywidget = wibox.container.background(battery.widget, widget_color)

widget_layout = wibox.layout.fixed.horizontal()
widget_layout:add(batterywidget)

return widget_layout
