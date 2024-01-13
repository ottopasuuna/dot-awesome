(local user_vars (require :user_vars))
; (local awesome (require :awesome))
(local hotkeys_popup (require :awful.hotkeys_popup))
(local awful (require :awful))


(local awesome_menu
  [["Hotkeys" (fn []
                (values false hotkeys_popup.show_help))]
   ["Manual"  (.. user_vars.terminal " -e man awesome")]
   ["Edit config" (string.format "%s -e %s %s" user_vars.terminal
                                 user_vars.editor awesome.conffile)]
   ["Restart" awesome.restart]
   ["Quit"    (fn [] (awesome.quit))]])

(local system_menu
  [["Suspend"   "systemctl suspend"]
   ["Reboot"    "reboot"]
   ["Shut down" "systemctl poweroff"]])


(local main_menu
  [["Awesome" awesome_menu]
   ["System"  system_menu]
   ["Sleep"   "systemctl suspend"]])


(set awful.util.mainmenu (awful.menu.new {:items main_menu}))
