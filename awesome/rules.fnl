(local awful (require :awful))
(local beautiful (require :beautiful))

(local user_vars (require :user_vars))
(local bindings (require :bindings))


(local rules
  [
   {:rule {:class "floating-centered"}
    :properties {:floating true
                 :width 800
                 :height 600
                 :placement (+ awful.placement.no_overlap
                               awful.placement.no_offscreen
                               awful.placement.centered)}}
   ;; All clients will match this rule
   {:rule []
    :properties {:border_width beautiful.border_width
                 :border_color beautiful.border_normal
                 :focus awful.client.focus.filter
                 :raise true
                 :keys  bindings.clientkeys
                 :buttons bindings.clientbuttons
                 :screen awful.screen.preferred
                 :placement (+ awful.placement.no_overlap
                               awful.placement.no_offscreen)
                 :size_hints_honor false}}
   {:rule_any {:type {"dialog" "normal"}}
    :properties {:titlebars_enabled user_vars.enable_client_titlebars}}
   ])

(set awful.rules.rules rules)
