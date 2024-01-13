(local user_vars (require :user_vars))
(local awesome (require :awesome))
(local hotkeys_popup (require :awful.hotkeys_popup))


(local awesome_menu
  {"Hotkeys" (fn []
              (values false hotkeys_popup.show_help))
   "Manual"  (.. user_vars.terminal " -e man awesome")
   "Edit config" (string.format "%s -e %s %s" user_vars.terminal
                                user_vars.editor awesome.conffile)

                     })
