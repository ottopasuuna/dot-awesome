(local awful (require :awful))
(local beautiful (require :beautiful))

(local error_handling (require "error_handling"))
(local user_vars (require :user_vars))
(local menu (require :menu))
(local tags (require :tags))


(tset awful :util :terminal user_vars.terminal)

(tset awful :layout :layouts
      [awful.layout.suit.tile
       awful.layout.suit.tile.left
       awful.layout.suit.tile.bottom
       awful.layout.suit.tile.top
       awful.layout.suit.floating])

(beautiful.init
  (string.format "%s/.config/awesome/themes/%s/theme.lua"
                 (os.getenv "HOME")
                 user_vars.chosen_theme))

