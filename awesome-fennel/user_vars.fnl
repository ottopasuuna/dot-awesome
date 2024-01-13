
(local terminal "termite")
(local editor (or (os.getenv "EDITOR") "nano"))
(local editor_cmd (.. terminal " -e " editor))
(local modkey "Mod4")
(local chosen_theme "ottopasuuna")

{: terminal
 : editor
 : editor_cmd
 : modkey
 : chosen_theme}
