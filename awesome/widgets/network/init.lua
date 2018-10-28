local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

neticon    = wibox.container.background(wibox.widget.imagebox(beautiful.widget_net), widget_color)

netwidget  = wibox.container.background(lain.widget.net({
  settings = function()
     widget:set_text(net_now.sent .. "^ " .. net_now.received .. "v")
  end
}).widget, widget_color)

net_layout = wibox.layout.fixed.horizontal()
net_layout:add(neticon)
net_layout:add(netwidget)


return net_layout

