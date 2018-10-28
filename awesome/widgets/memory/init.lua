local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

memicon = wibox.container.background(wibox.widget.imagebox(beautiful.widget_mem), widget_color)

memwidget = wibox.container.background(lain.widget.mem({
  settings = function()
    widget:set_text(mem_now.used/1000)
  end
}).widget, widget_color)

mem_layout = wibox.layout.fixed.horizontal()
mem_layout:add(memicon)
mem_layout:add(memwidget)


return mem_layout

