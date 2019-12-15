-- Standard awesome library
local gears = require("gears")

local awful = require("awful")
awful.rules = require("awful.rules")

local lain = require("lain")

require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

local widgets = require("widgets")
-- require("eminent")
local keydoc = require("keydoc")

-- {{{ Error handling ******************************************************
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}} ____________________________________________________________________

-- {{{ Variable definitions **************************************************
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/ottopasuuna/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "termite"
terminal_cmd = terminal .. " -e /home/carl/bin/zsh_tmux.sh"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor
inetbrowser = "firefox"
emailclient = "thunderbird"
filemanager = terminal .. " -e ranger"

modkey = "Mod4"
altkey = "Mod1"



-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.floating,
}

awesome_menu = {
   {"Restart", awesome.restart},
   {"Quit", function() awesome.quit() end}
}

system_menu = {
   {"Suspend", "systemctl suspend"},
   {"Reboot", "reboot"},
   {"Shut down", "systemctl poweroff"}
}

main_menu = awful.menu.new({ items = {
   {"Awesome", awesome_menu},
   {"System", system_menu},
	{"Sleep", "systemctl suspend"}

} })

launcher = awful.widget.launcher({image = beautiful.awesome_icon, menu = main_menu })
-- }}}

-- Autostart applications{{{
--
autorunApps = {
    "cadence",
    "nextcloud",
    "ibus-daemon --xim -d"
}

for i,app in ipairs(autorunApps) do
    awful.util.spawn(app)
end

-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Tags **************************************************************
-- Define a tag table which hold all screen tags.
-- tags = {
--     names={"1","2","3","4","5","6","7","8","9"}
-- }
-- for s = 1, screen.count() do
--     -- Each screen has its own tag table.
--     tags[s] = awful.tag(tags.names, s, layouts[1])
-- end
-- }}} ____________________________________________________________________

-- {{{ Wibox
-- Battery
-- batterywidget = lain.widget.bat({
--     settings = function()
--     widget:set_text(bat_now.perc .. '%')
--     end
-- })

-- Create a wibox for each screen and add it
mywibox = {}
mywiboxbottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
-- mytaglist.buttons = awful.util.table.join(
--                     awful.button({ }, 1, awful.tag.viewonly),
--                     awful.button({ modkey }, 1, awful.client.movetotag),
--                     awful.button({ }, 3, awful.tag.viewtoggle),
--                     awful.button({ modkey }, 3, awful.client.toggletag),
--                     awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
--                     awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
--                     )
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
mytasklist = {}
-- mytasklist.buttons = awful.util.table.join(
--                      awful.button({ }, 1, function (c)
--                                               if c == client.focus then
--                                                   c.minimized = true
--                                               else
--                                                   -- Without this, the following
--                                                   -- :isvisible() makes no sense
--                                                   c.minimized = false
--                                                   if not c:isvisible() then
--                                                       awful.tag.viewonly(c:tags()[1])
--                                                   end
--                                                   -- This will also un-minimize
--                                                   -- the client, if needed
--                                                   client.focus = c
--                                                   c:raise()
--                                               end
--                                           end),
--                      awful.button({ }, 3, function ()
--                                               if instance then
--                                                   instance:hide()
--                                                   instance = nil
--                                               else
--                                                   instance = awful.menu.clients({ width=250 })
--                                               end
--                                           end),
--                      awful.button({ }, 4, function ()
--                                               awful.client.focus.byidx(1)
--                                               if client.focus then client.focus:raise() end
--                                           end),
--                      awful.button({ }, 5, function ()
--                                               awful.client.focus.byidx(-1)
--                                               if client.focus then client.focus:raise() end
--                                           end))
local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- for s = 1, screen.count() do
awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[2])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })
    s.mywiboxbottom = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the top wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            launcher,
            s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            widgets.weather,
            widgets.imap,
            widgets.alsa,
            widgets.battery,
            -- batterywidget,
            widgets.clock,
            s.mylayoutbox
        },
    }

    -- Add widgets to the bottom wibox
    s.mywiboxbottom:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            widgets.cpu,
            widgets.temperature,
            widgets.memory,
            widgets.filesystem,
        },
        s.mypromptbox,-- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
        },
    }

    -- Bright_layout:add(widgets.notifications({max_items = 10, direction = bottom_right}))

end)

-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Layout manipulation
    keydoc.group("Layout manipulation"),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev, "Previous tag"),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext, "Next tag"),
    -- TODO: These bindings are broken...
    -- awful.key({ modkey, "Shift"   }, "Left",
    --   function (c)
    --     local curidx = awful.tag.getidx()
    --     if curidx == 1 then
    --         awful.client.movetotag(tags[client.focus.screen][#tags[client.focus.screen]])
    --     else
    --         awful.client.movetotag(tags[client.focus.screen][curidx - 1])
    --     end
    --     awful.tag.viewidx(-1)
    --   end),
    -- awful.key({ modkey, "Shift"   }, "Right",
    --   function (c)
    --     local curidx = awful.tag.getidx()
    --     if curidx == #tags[client.focus.screen] then
    --       awful.client.movetotag(tags[client.focus.screen][1])
    --     else
    --       awful.client.movetotag(tags[client.focus.screen][curidx + 1])
    --     end
    --     awful.tag.viewidx(1)
    --   end),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore, "Go to last selected tag"),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end, "Next client"),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end, "Previous client"),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end, "Swap client forward"),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end, "Swap client backward"),
    awful.key({ modkey, "Shift", "Control"   }, "j", function () awful.client.movetoscreen()    end, "Move client next screen"),
    awful.key({ modkey, "Shift", "Control"   }, "k", function () awful.client.movetoscreen()    end, "Move client next screen"),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, "Swap screen forward"),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, "Swap screen backward"),
    -- awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, "Focus previous client"),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end, "Increase main window"),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end, "Decrease main window"),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end, "Incrase number of masters"),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end, "Decrease number of masters"),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end, "Increase number of columns"),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end, "Decrease number of columns"),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end, "Next layout"),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end, "Previous layout"),
    awful.key({ modkey, "Shift" }, "n", awful.client.restore),

    -- Volume Control
    keydoc.group("Music/Audio"),
    awful.key({}, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer set %s 1%%+", volume.channel))
            volume.notify()
        end, "Raise volume"),
    awful.key({}, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer set %s 1%%-", volume.channel))
            volume.notify()
        end, "Lower volume"),
    awful.key({}, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer set %s toggle", volume.togglechannel or volume.channel))
            volume.notify()
        end, "Mute"),

    --Mpd control
    awful.key({}, "XF86AudioPlay",
      function()
        awful.util.spawn("mpc play")
      end, "Play mpd"),
    awful.key({}, "XF86AudioStop",
      function()
        awful.util.spawn("mpc pause")
      end, "Pause mpd"),
    awful.key({}, "XF86AudioNext",
      function()
        awful.util.spawn("mpc next")
      end, "Next mpd track"),
    awful.key({}, "XF86AudioPrev",
      function()
        awful.util.spawn("mpc prev")
      end, "Next mpd track"),



    -- Spawn User Apps
    keydoc.group("Spawn apps"),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal_cmd) end, "Terminal"),
    awful.key({modkey,            }, "i",   function () awful.util.spawn(inetbrowser) end, "Internet browser"),
    awful.key({modkey,            }, "e",   function () awful.util.spawn(emailclient) end, "Email client"),
    awful.key({modkey,            }, "f",   function () awful.util.spawn(filemanager) end, "File manager"),
    awful.key({modkey,  "Shift"   }, "c", function () awful.util.spawn('catia') end, "Jack patchbay"),

    -- Standard program
    keydoc.group("Awesome"),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Control"   }, "q", awesome.quit),

    -- Password menu
    awful.key({ modkey,           }, "p", function () awful.util.spawn('passmenu') end, "pass-clip"),

    -- show launcher menu
    awful.key({modkey,            }, "`",   function () main_menu:show() end, "Show launcher menu"),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end, "Start prompt"),


    awful.key({ modkey, "Shift"},            "r",     function () awful.util.spawn('rofi -combi-modi drun -show drun') end, "Start prompt"),
    -- awful.key({ modkey, "Shift" }, "r",
    --           function ()
    --               awful.prompt.run({ prompt = "Run Lua code: " },
    --               mypromptbox[mouse.screen].widget,
    --               awful.util.eval, nil,
    --               awful.util.getdir("cache") .. "/history_eval")
    --           end, "Lua prompt"),
	  awful.key({ modkey, }, "F1", keydoc.display)
)

-- Client bindings
clientkeys = awful.util.table.join(
    keydoc.group("Client Bindings"),
    awful.key({ modkey, "Shift"   }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
        end, "Toggle fullscreen"),
    awful.key({ modkey,           }, "w",      function (c) c:kill()                         end, "Close window"),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle, "Toggle floating mode"),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end, "Swap with master"),
    awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end, "Toggle on top mode"),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, "Minimize"),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end, "Maximize"),
    awful.key({ modkey,  "Shift"  }, "m",
        function (c)
            c.maximized_horizontal = false
            c.maximized_vertical   = false
        end, "Unmaximize")
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
        -- switch to tag
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
        -- toggle visibility of other tags
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
        -- move client to tag
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
        -- add client to other tag
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     size_hints_honor = false }, callback = awful.client.setslave },
    { rule = {"Euro Truck Simulator 2"},
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     floating = false,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     size_hints_honor = false }, callback = awful.client.setslave },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
   c:connect_signal("mouse::enter", function(c)
           if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
               and awful.client.focus.filter(c) then
               client.focus = c
               --c:raise()
           end
       end)


    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
