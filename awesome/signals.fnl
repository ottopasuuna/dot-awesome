(local awful (require :awful))
(local wibox (require :wibox))
(local beautiful (require :beautiful))
(local a-table (require :gears.table))
(local user_vars (require :user_vars))

;; Signal function to execute when a new client appears.
(client.connect_signal
  "manage"
  (fn [c]
    ;; Set the windows at the slave,
    ;; i.e. put it at the end of others instead of setting it master.
    ;; if not awesome.startup then awful.client.setslave(c) end
    (if (and awesome.startup
             (not c.size_hints.user_position)
             (not c.size_hints.program_position))
      ;; Prevent clients from being unreachable after screen count changes.
      (awful.placement.no_offscreen c))))


;; Add a titlebar if titlebars_enabled is set to true in the rules.
(client.connect_signal
  "request::titlebar"
  (fn [c]
    ;; buttons for the titlebar
    (local buttons
      (a-table.join
        (awful.button [] 1 (fn []
                             (c:emit_signal "request::activate" "titlebar" {:raise true})
                             (awful.mouse.client.move c)))
        (awful.button [] 3 (fn []
                             (c:emit_signal "request::activate" "titlebar" {:raise true})
                             (awful.mouse.client.resize c)))))
    (: (awful.titlebar c) :setup
       {
        1 { ;; Left
         1        (awful.titlebar.widget.iconwidget c)
         :buttons buttons
         :layout  wibox.layout.fixed.horizontal}

        { ;; Middle
         1 {:align  "center"
            :widget (awful.titlebar.widget.titlewidget c)}
         :buttons buttons
         :layout  wibox.layout.flex.horizontal}
        {;; Right
         1 (awful.titlebar.widget.floatingbutton c)
         2 (awful.titlebar.widget.maximizedbutton c)
         3 (awful.titlebar.widget.stickybutton c)
         4 (awful.titlebar.widget.ontopbutton c)
         5 (awful.titlebar.widget.closebutton c)
         :layout (wibox.layout.fixed.horizontal)
         }
        :layout wibox.layout.align.horizontal
        })))

;; Enable sloppy focus, so that focus follows mouse.
(client.connect_signal
  "mouse::enter"
  (fn [c]
    (c:emit_signal "request::activate" "mouse_enter" {:raise false})))

(client.connect_signal
  "focus"
  (fn [c]
    (set c.border_color beautiful.border_focus)))

(client.connect_signal
  "unfocus"
  (fn [c]
    (set c.border_color beautiful.border_normal)))

