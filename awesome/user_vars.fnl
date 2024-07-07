
(local terminal "kitty")
(local editor (or (os.getenv "EDITOR") "vi"))
(local editor_cmd (.. terminal " -e " editor))
(local modkey "Mod4")
(local altkey "Mod1")
(local chosen_theme "ottopasuuna")
(local cycle-prev true)
(local browser "firefox")
(local enable_client_titlebars false)

{: terminal
 : editor
 : editor_cmd
 : browser
 : modkey
 : altkey
 : chosen_theme
 : cycle-prev
 : enable_client_titlebars}
