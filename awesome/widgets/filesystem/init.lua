local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

fsicon = wibox.container.background(wibox.widget.imagebox(beautiful.widget_fs), widget_color)

fswidget = wibox.container.background(lain.widget.fs({
    settings = function()
        widget:set_text(" " .. fs_now.used .. "%")
    end
}).widget, widget_color)

fs_layout = wibox.layout.fixed.horizontal()
fs_layout:add(fsicon)
fs_layout:add(fswidget)


return fs_layout

