(local awful (require :awful))
(local a-table (require :gears.table))
(local user_vars (require :user_vars))


(set awful.util.tagnames ["1" "2" "3" "4" "5" "6" "7" "8" "9"])

(local taglist_buttons
  (a-table.join
    ;; Switch tags with left click
    (awful.button [] 1 (fn [t] (t:view_only)))
    (awful.button [user_vars.modkey] 1 (fn [t]
                                         (if client.focus
                                           (client.focus:move_to_tag t))))
    ;; Toggle tags with right click
    (awful.button [] 3 awful.tag.viewtoggle)
    (awful.button [user_vars.modkey] 3 (fn [t]
                                         (if client.focus
                                           (client.focus:toggle_tag t))))
    ;; Scroll to next/previous tag with scroll wheel
    (awful.button [] 4 (fn [t] (awful.tag.viewnext t.screen)))
    (awful.button [] 5 (fn [t] (awful.tag.viewprev t.screen)))
    ))

(set awful.util.taglist_buttons taglist_buttons)
