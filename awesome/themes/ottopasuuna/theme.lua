---------------------------------
-- Ottopasuuna's Awesome Wm theme
---------------------------------

--141414,262626,6E6E6E,0D2535,1D4558,164133,38211F,3F4620,953D1D,F1F5E0,
--possible colours:


blue = "#0000ff"
green = "#00ff00"
red = "#953d1d"
cyan = "#00CCFF"
magenta = "#ff00ff"
yellow = "#ffff00"
white = "#f1f5e0"
black = "#141414"

grey0 = "#262626"
grey1 = "#404040"

lblue = "#8080ff"
lgreen = "#80ff80"
lred = "#ff8080"
lcyan = "#80ffff"
lmagenta = "#ff80ff"
lyellow = "#ffff80"

theme = {}


themes_dir          = os.getenv("HOME") .. "/.config/awesome/themes/ottopasuuna"
--theme.wallpaper     = themes_dir .. "/background_white.png"
theme.font          = "mono 8"

--Background settings (Affects task bar and selected tag colors)
theme.bg_normal     = black    --
theme.bg_focus      = grey0     --
theme.bg_urgent     = lgreen
theme.bg_minimize   = grey1
theme.bg_systray    = theme.bg_normal


--Foreground settings (Affects fonts in tasks)
theme.fg_normal     = white    --
theme.fg_focus      = cyan     --
theme.fg_urgent     = magenta
theme.fg_minimize   = white    --
theme.fg_widget_value = white
theme.fg_widget_clock = yellow
theme.fg_widget_value_important = red

--Border settings
theme.border_width  = 1
theme.border_normal = black
theme.border_focus  = cyan
theme.border_marked = "#91231c"

-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

-- Display the taglist squares
theme.taglist_squares_sel   = themes_dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = themes_dir .. "/icons/square_unsel.png"

-- Layout icons. (must be present)
theme.layout_tile                   = themes_dir .. "/icons/tile.png"
theme.layout_tilegaps               = themes_dir .. "/icons/tilegaps.png"
theme.layout_tileleft               = themes_dir .. "/icons/tileleft.png"
theme.layout_tilebottom             = themes_dir .. "/icons/tilebottom.png"
theme.layout_tiletop                = themes_dir .. "/icons/tiletop.png"
theme.layout_fairv                  = themes_dir .. "/icons/fairv.png"
theme.layout_fairh                  = themes_dir .. "/icons/fairh.png"
theme.layout_spiral                 = themes_dir .. "/icons/spiral.png"
theme.layout_dwindle                = themes_dir .. "/icons/dwindle.png"
theme.layout_max                    = themes_dir .. "/icons/max.png"
theme.layout_fullscreen             = themes_dir .. "/icons/fullscreen.png"
theme.layout_magnifier              = themes_dir .. "/icons/magnifier.png"
theme.layout_floating               = themes_dir .. "/icons/floating.png"


-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

--Icons
theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

theme.widget_cpu        = themes_dir .. "/icons/cpu.png"
theme.widget_temp       = themes_dir .. "/icons/temp.png"
theme.widget_vol        = themes_dir .. "/icons/vol.png"
theme.widget_vol_low    = themes_dir .. "/icons/vol_low.png"
theme.widget_vol_no     = themes_dir .. "/icons/vol_no.png"
theme.widget_vol_mute   = themes_dir .. "/icons/vol_mute.png"
theme.widget_mail       = themes_dir .. "/icons/mail.png"
theme.widget_mem        = themes_dir .. "/icons/mem.png"
theme.widget_net        = themes_dir .. "/icons/net.png"
theme.widget_task       = themes_dir .. "/icons/tasksmall.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil

return theme
