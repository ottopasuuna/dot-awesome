(local awful (require :awful))
(local beautiful (require :beautiful))
(local a-table (require :gears.table))

(local user_vars (require :user_vars))

;; Mouse bindings
(root.buttons
  (a-table.join
    (awful.button [] 3 (fn [] (awful.util.mainmenu:toggle)))
    (awful.button [] 4 awful.tag.viewnext)
    (awful.button [] 5 awful.tag.viewprev)))
