
(local terminal "termite")
(local editor (or (os.getenv "EDITOR") "nano"))
(local editor_cmd (.. terminal " -e " editor))
(local modkey "Mod4")
(local altkey "Mod1")
(local chosen_theme "ottopasuuna")
(local cycle-prev true)
(local enable_client_titlebars false)

{: terminal
 : editor
 : editor_cmd
 : modkey
 : altkey
 : chosen_theme
 : cycle-prev
 : enable_client_titlebars}
