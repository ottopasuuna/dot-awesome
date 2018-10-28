local awful     = require("awful")
local wibox     = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

widget_color = "#313131"

weatherwidget = wibox.container.background(lain.widget.weather({
    city_id = 6141256,
    settings = function()
        widget:set_text(math.floor(weather_now["main"]["temp"]))
    end
}).widget, widget_color)

-- weather_layout = wibox.layout.fixed.horizontal()
-- weather_layout:add(weatherwidget.icon)
-- weather_layout:add(weatherwidget)


return weatherwidget

