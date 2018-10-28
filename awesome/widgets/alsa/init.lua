local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

terminal = "termite"

widget_color = "#313131"

volicon = wibox.widget.imagebox(beautiful.widget_vol)

volwidget = wibox.container.background(volicon, widget_color)

volume = lain.widget.alsabar({
  settings = function()
    if volume_now.status == "off" then
     volicon:set_image(beautiful.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
     volicon:set_image(beautiful.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
     volicon:set_image(beautiful.widget_vol_low)
    else
     volicon:set_image(beautiful.widget_vol)
    end
  end,
  width      = 10,
  ticks      = true,
  ticks_size = 2,
  vertical   = true,
  colors     = {unmute="#00ccff"},
})

vol_layout = wibox.layout.fixed.horizontal()
vol_layout:add(volwidget)
vol_layout:add(volume.bar)


return vol_layout

