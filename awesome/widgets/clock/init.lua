local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

clock = wibox.widget.textclock()
clockbg = wibox.container.background(clock, "#313131")
calendar = lain.widget.calendar({
    attach_to = {clockbg},
})


return clockbg

