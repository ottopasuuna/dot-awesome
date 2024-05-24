--[[

     Awesome WM configuration template
     github.com/lcpz

--]]
pcall(require, "luarocks.loader")
-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
--local menubar       = require("menubar")
-- local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi


-- {{{ Lua/Fennel Workarounds

local chosen_theme = "ottopasuuna"
local terminal     = "alacritty"
awful.util.terminal = terminal
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}

local fennel = require("fennel")
fennel.path = fennel.path .. ";/home/carl/.config/awesome/?.fnl"
fennel.install().dofile("/home/carl/.config/awesome/config.fnl")
-- fennel.install().dofile("config.fnl")
-- }}}

-- vim: set foldmethod=marker:
