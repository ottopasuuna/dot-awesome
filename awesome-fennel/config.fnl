(local awful (require :awful))
(local beautiful (require :beautiful))

(local error_handling (require "error_handling"))
(local user_vars (require :user_vars))



(tset awful :util :terminal user_vars.terminal)
(tset awful :util :tagnames ["1" "2" "3" "4" "5" "6" "7" "8" "9"])
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

