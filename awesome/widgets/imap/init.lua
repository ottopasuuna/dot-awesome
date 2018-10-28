local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

mailicon   = wibox.container.background(wibox.widget.imagebox(beautiful.widget_mail), widget_color)

mailwidget = wibox.container.background(lain.widget.imap({
  timeout  = 120,
  port     = 993,
  server   = "imap.gmail.com",
  mail     = "jawaofsktoon@gmail.com",
  password = "carlsick",
  settings = function()
    widget:set_text(mailcount)
  end
}).widget, widget_color)

mail_layout = wibox.layout.fixed.horizontal()
mail_layout:add(mailicon)
mail_layout:add(mailwidget)


return mail_layout
