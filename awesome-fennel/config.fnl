(local awful (require :awful))
(local beautiful (require :beautiful))
(local a-table (require :gears.table))
(local gears   (require :gears))

(local error_handling (require "error_handling"))
(local user_vars (require :user_vars))
(local menu (require :menu))
(local tags (require :tags))
(local bindings (require :bindings))
(local signals (require :signals))
(local rules   (require :rules))

(local dpi (. (require :beautiful.xresources) :apply_dpi))

(tset awful :util :terminal user_vars.terminal)

(tset awful :layout :layouts
      [awful.layout.suit.tile
       awful.layout.suit.tile.left
       awful.layout.suit.tile.bottom
       awful.layout.suit.tile.top
       awful.layout.suit.floating])

;; TODO: put this somwhere better?
(set awful.util.tasklist_buttons
     (a-table.join
       (awful.button {} 1
                     (fn [c]
                       (if (= c client.focus)
                         (set c.minimized true)
                         (do
                           (set c.minimized false)
                           (when (and (not (c:isvisible))
                                      c.first_tag)
                             (c.first_tag:view_only))
                           (set client.focus c)
                           (c:raise)))))
                    (awful.button {} 2 (fn [c] (c:kill)))
                    (awful.button {} 3
                                  (fn []
                                    (var instance nil)
                                    (fn []
                                      (if (and instance instance.wibox.visible)
                                        (do
                                          (instance:hide)
                                          (set instance nil))
                                        (set instance
                                             (awful.menu.clients {:theme {:width (dpi 250)}}))))))
                    (awful.button {} 4 (fn [] (awful.client.focus.byidx 1)))
                    (awful.button {} 5 (fn [] (awful.client.focus.byidx (- 1))))))

;;  Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
(screen.connect_signal
  "property::geometry"
  (fn [s]
    (when beautiful.wallpaper
      (var wallpaper beautiful.wallpaper)
      (when (= (type wallpaper) :function)
        (set wallpaper (wallpaper s)))
      (gears.wallpaper.maximized wallpaper s true))))

;; No borders when rearranging only 1 non-floating or maximized client
(screen.connect_signal
  "arrange"
  (fn [s]
    (let [only-one (= (length s.tiled_clients) 1)]
      (each [_ c (pairs s.clients)]
        (if (or (and only-one (not c.floating))
                c.maximized)
          (set c.border_width 0)
          (set c.border_width beautiful.border_width))))))



(beautiful.init
  (string.format
    "%s/.config/awesome/themes/%s/theme.lua"
    (os.getenv "HOME")
    user_vars.chosen_theme))

(awful.screen.connect_for_each_screen
  (fn [s] (beautiful.at_screen_connect s)))
