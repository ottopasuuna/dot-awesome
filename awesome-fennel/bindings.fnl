(local awful (require :awful))
(local beautiful (require :beautiful))
(local a-table (require :gears.table))
(local hotkeys-popup (require :awful.hotkeys_popup.keys))
(local lain    (require :lain))
(local naughty (require :naughty))

(local user_vars (require :user_vars))

;; Mouse bindings
(root.buttons
  (a-table.join
    (awful.button [] 3 (fn [] (awful.util.mainmenu:toggle)))
    (awful.button [] 4 awful.tag.viewnext)
    (awful.button [] 5 awful.tag.viewprev)))


(var globalkeys
  (a-table.join
    (awful.key [user_vars.altkey] :p (fn [] (os.execute :screenshot))
               {:description "take a screenshot"
                :group :hotkeys})
    ; (awful.key [user_vars.altkey :Control] :l
    ;            (fn [] (os.execute scrlocker))
    ;            {:description "lock screen" :group :hotkeys})
    (awful.key [user_vars.modkey] :F1 hotkeys-popup.show_help
               {:description "show help" :group :awesome})
    (awful.key [user_vars.modkey] :Left awful.tag.viewprev
               {:description "view previous" :group :tag})
    (awful.key [user_vars.modkey] :Right awful.tag.viewnext
               {:description "view next" :group :tag})
    (awful.key [user_vars.modkey :Shift] :Left
               (fn [c]
                 (let [target-client client.focus]
                   (awful.tag.viewprev)
                   (target-client:tags [(. (awful.screen.focused)
                                           :selected_tag)])))
               {:description "move client to previous tag"
                :group :tag})
    (awful.key [user_vars.modkey :Shift] :Right
               (fn [c]
                 (let [target-client client.focus]
                   (awful.tag.viewnext)
                   (target-client:tags [(. (awful.screen.focused)
                                           :selected_tag)])))
               {:description "move client to next tag"
                :group :tag})
    (awful.key [user_vars.modkey] :Escape awful.tag.history.restore
               {:description "go back" :group :tag})
    (awful.key [user_vars.altkey] :j
               (fn [] (awful.client.focus.byidx 1))
               {:description "focus next by index"
                :group :client})
    (awful.key [user_vars.altkey] :k
               (fn [] (awful.client.focus.byidx (- 1)))
               {:description "focus previous by index"
                :group :client})
    (awful.key [user_vars.modkey] :j
               (fn []
                 (awful.client.focus.global_bydirection :down)
                 (when client.focus (client.focus:raise)))
               {:description "focus down" :group :client})
    (awful.key [user_vars.modkey] :k
               (fn []
                 (awful.client.focus.global_bydirection :up)
                 (when client.focus (client.focus:raise)))
               {:description "focus up" :group :client})
    (awful.key [user_vars.modkey] :h
               (fn []
                 (awful.client.focus.global_bydirection :left)
                 (when client.focus (client.focus:raise)))
               {:description "focus left" :group :client})
    (awful.key [user_vars.modkey] :l
               (fn []
                 (awful.client.focus.global_bydirection :right)
                 (when client.focus (client.focus:raise)))
               {:description "focus right" :group :client})
    (awful.key [user_vars.modkey] "`"
               (fn [] (awful.util.mainmenu:show))
               {:description "show main menu"
                :group :awesome})
    (awful.key [user_vars.modkey :Shift] :j
               (fn [] (awful.client.swap.byidx 1))
               {:description "swap with next client by index"
                :group :client})
    (awful.key [user_vars.modkey :Shift] :k
               (fn [] (awful.client.swap.byidx (- 1)))
               {:description "swap with previous client by index"
                :group :client})
    (awful.key [user_vars.modkey :Control] :j
               (fn [] (awful.screen.focus_relative 1))
               {:description "focus the next screen"
                :group :screen})
    (awful.key [user_vars.modkey :Control] :k
               (fn [] (awful.screen.focus_relative (- 1)))
               {:description "focus the previous screen"
                :group :screen})
    (awful.key [user_vars.modkey] :u awful.client.urgent.jumpto
               {:description "jump to urgent client"
                :group :client})
    (awful.key [user_vars.modkey] :Tab
               (fn []
                 (if user_vars.cycle-prev
                   (awful.client.focus.history.previous)
                   (awful.client.focus.byidx (- 1)))
                 (when client.focus (client.focus:raise)))
               {:description "cycle with previous/go back"
                :group :client})
    (awful.key [user_vars.modkey :Shift] :Tab
               (fn []
                 (when user_vars.cycle-prev
                   (awful.client.focus.byidx 1)
                   (when client.focus (client.focus:raise))))
               {:description "go forth" :group :client})
    (awful.key [user_vars.modkey] :b
               (fn []
                 (each [s screen]
                   (set s.mywibox.visible
                        (not s.mywibox.visible))
                   (when s.mybottomwibox
                     (set s.mybottomwibox.visible
                          (not s.mybottomwibox.visible)))))
               {:description "toggle wibox" :group :awesome})
(awful.key [user_vars.altkey :Control] "+"
           (fn [] (lain.util.useless_gaps_resize 1))
           {:description "increment useless gaps"
            :group :tag})
(awful.key [user_vars.altkey :Control] "-"
           (fn [] (lain.util.useless_gaps_resize (- 1)))
           {:description "decrement useless gaps"
            :group :tag})
(awful.key [user_vars.modkey :Shift] :n
           (fn [] (lain.util.add_tag))
           {:description "add new tag" :group :tag})
(awful.key [user_vars.modkey :Shift] :r
           (fn [] (lain.util.rename_tag))
           {:description "rename tag" :group :tag})
(awful.key [user_vars.modkey :Shift] :d
           (fn [] (lain.util.delete_tag))
           {:description "delete tag" :group :tag})
(awful.key [user_vars.modkey] :Return
           (fn []
             (awful.spawn.with_shell (.. user_vars.terminal
                                         " -e /home/carl/bin/join_tmux.sh")))
           {:description "open a terminal"
            :group :launcher})
(awful.key [user_vars.modkey :Control] :r awesome.restart
           {:description "reload awesome"
            :group :awesome})
(awful.key [user_vars.modkey :Shift] :q awesome.quit
           {:description "quit awesome" :group :awesome})
(awful.key [user_vars.altkey :Shift] :l
           (fn [] (awful.tag.incmwfact 0.05))
           {:description "increase master width factor"
            :group :layout})
(awful.key [user_vars.altkey :Shift] :h
           (fn [] (awful.tag.incmwfact (- 0.05)))
           {:description "decrease master width factor"
            :group :layout})
(awful.key [user_vars.modkey :Shift] :h
           (fn [] (awful.tag.incnmaster 1 nil true))
           {:description "increase the number of master clients"
            :group :layout})
(awful.key [user_vars.modkey :Shift] :l
           (fn [] (awful.tag.incnmaster (- 1) nil true))
           {:description "decrease the number of master clients"
            :group :layout})
(awful.key [user_vars.modkey :Control] :h
           (fn [] (awful.tag.incncol 1 nil true))
           {:description "increase the number of columns"
            :group :layout})
(awful.key [user_vars.modkey :Control] :l
           (fn [] (awful.tag.incncol (- 1) nil true))
           {:description "decrease the number of columns"
            :group :layout})
(awful.key [user_vars.modkey] :space (fn [] (awful.layout.inc 1))
           {:description "select next" :group :layout})
(awful.key [user_vars.modkey :Shift] :space
           (fn [] (awful.layout.inc (- 1)))
           {:description "select previous"
            :group :layout})
(awful.key [user_vars.modkey :Control] :n
           (fn []
             (let [c (awful.client.restore)]
               (when c (set client.focus c) (c:raise))))
           {:description "restore minimized"
            :group :client})
(awful.key [user_vars.modkey] :z
           (fn []
             (: (. (awful.screen.focused) :quake)
                :toggle))
           {:description "dropdown application"
            :group :launcher})
(awful.key [user_vars.altkey] :c
           (fn []
             (when beautiful.cal (beautiful.cal.show 7)))
           {:description "show calendar"
            :group :widgets})
(awful.key [user_vars.altkey] :h
           (fn []
             (when beautiful.fs (beautiful.fs.show 7)))
           {:description "show filesystem"
            :group :widgets})
(awful.key [user_vars.altkey] :w
           (fn []
             (when beautiful.weather
               (beautiful.weather.show 7)))
           {:description "show weather" :group :widgets})
(awful.key {} :XF86MonBrightnessUp
           (fn [] (os.execute "xbacklight -inc 10"))
           {:description "+10%" :group :hotkeys})
(awful.key {} :XF86MonBrightnessDown
           (fn [] (os.execute "xbacklight -dec 10"))
           {:description "-10%" :group :hotkeys})
(awful.key {} :XF86AudioRaiseVolume
           (fn []
             (os.execute (string.format "amixer -q set %s 1%%+"
                                        beautiful.volume.channel))
             (beautiful.volume.update)
             (beautiful.volume.notify))
           {:description "volume up" :group :hotkeys})
(awful.key {} :XF86AudioLowerVolume
           (fn []
             (os.execute (string.format "amixer -q set %s 1%%-"
                                        beautiful.volume.channel))
             (beautiful.volume.update)
             (beautiful.volume.notify))
           {:description "volume down" :group :hotkeys})
(awful.key {} :XF86AudioMute
           (fn []
             (os.execute (string.format "amixer -q set %s toggle"
                                        (or beautiful.volume.togglechannel
                                            beautiful.volume.channel)))
             (beautiful.volume.update)
             (beautiful.volume.notify))
           {:description "toggle mute" :group :hotkeys})
(awful.key {} :XF86AudioPlay
           (fn [] (os.execute "mpc toggle")
             (beautiful.mpd.update))
           {:description "mpc toggle" :group :widgets})
(awful.key {} :XF86AudioStop
           (fn [] (os.execute "mpc stop")
             (beautiful.mpd.update))
           {:description "mpc stop" :group :widgets})
(awful.key {} :XF86AudioPrev
           (fn [] (os.execute "mpc prev")
             (beautiful.mpd.update))
           {:description "mpc prev" :group :widgets})
(awful.key {} :XF86AudioNext
           (fn [] (os.execute "mpc next")
             (beautiful.mpd.update))
           {:description "mpc next" :group :widgets})
(awful.key [user_vars.altkey] :0
           (fn []
             (let [common {:position :top_middle
                           :text "MPD widget "
                           :timeout 2}]
               (if beautiful.mpd.timer.started
                 (do
                   (beautiful.mpd.timer:stop)
                   (set common.text
                        (.. common.text
                            (lain.util.markup.bold :OFF))))
                 (do
                   (beautiful.mpd.timer:start)
                   (set common.text
                        (.. common.text
                            (lain.util.markup.bold :ON)))))
               (naughty.notify common)))
           {:description "mpc on/off" :group :widgets})
(awful.key [user_vars.modkey] :i (fn [] (awful.spawn user_vars.browser))
           {:description "run browser" :group :launcher})
(awful.key [user_vars.modkey :Shift] :c
           (fn [] (awful.spawn :catia))
           {:description "launch catia"
            :group :launcher})
(awful.key [user_vars.modkey] :e
           (fn [] (awful.spawn :thunderbird))
           {:description "launch email"
            :group :launcher})
(awful.key [user_vars.modkey] :f
           (fn []
             (awful.spawn (.. user_vars.terminal " -e ranger")))
           {:description "launch email"
            :group :launcher})
(awful.key [user_vars.modkey] :y
           (fn []
             (awful.spawn (.. user_vars.terminal
                              " -e \"ytfzf -t\"")
                          {:floating true
                           :placement awful.placement.centered}))
           {:description "Launch youtube-fzf"
            :group :launcher})
(awful.key [user_vars.modkey] :p
           (fn []
             (awful.spawn (.. user_vars.terminal
                              " -e \"fzflaunch pass\"")
                          {:floating true
                           :placement awful.placement.centered}))
           {:description "Password manager"
            :group :launcher})
(awful.key [user_vars.modkey] :r
           (fn []
             (awful.spawn (.. user_vars.terminal
                              " -e \"fzflaunch run\"")
                          {:floating true
                           :placement awful.placement.centered}))
           {:description "Application launcher"
            :group :launcher})
(awful.key [user_vars.modkey] :x
           (fn []
             (awful.prompt.run {:exe_callback awful.util.eval
                                :history_path (.. (awful.util.get_cache_dir)
                                                  :/history_eval)
                                :prompt "Run Lua code: "
                                :textbox (. (. (awful.screen.focused)
                                               :mypromptbox)
                                            :widget)}))
           {:description "lua execute prompt"
            :group :awesome})))

(for [i 1 9]
  (var (descr-view descr-toggle descr-move descr-toggle-focus) nil)
  (when (or (= i 1) (= i 9))
    (set descr-view {:description "view tag #" :group :tag})
    (set descr-toggle {:description "toggle tag #" :group :tag})
    (set descr-move {:description "move focused client to tag #" :group :tag})
    (set descr-toggle-focus {:description "toggle focused client on tag #"
                             :group :tag}))
  (set globalkeys
       (a-table.join
         globalkeys
         (awful.key [user_vars.modkey] (.. "#" (+ i 9))
                    (fn []
                      (let [screen (awful.screen.focused)
                            tag (. screen.tags i)]
                        (when tag (tag:view_only))))
                    descr-view)
         (awful.key [user_vars.modkey :Control] (.. "#" (+ i 9))
                    (fn []
                      (let [screen (awful.screen.focused)
                            tag (. screen.tags i)]
                        (when tag (awful.tag.viewtoggle tag))))
                    descr-toggle)
         (awful.key [user_vars.modkey :Shift] (.. "#" (+ i 9))
                    (fn []
                      (when client.focus
                        (local tag
                          (. client.focus.screen.tags i))
                        (when tag
                          (client.focus:move_to_tag tag))))
                    descr-move)
         (awful.key [user_vars.modkey :Control :Shift] (.. "#" (+ i 9))
                    (fn []
                      (when client.focus
                        (local tag
                          (. client.focus.screen.tags i))
                        (when tag (client.focus:toggle_tag tag))))
                    descr-toggle-focus))))
;; Set global keys
(root.keys globalkeys)


;; client bindings:
(local clientkeys
  (a-table.join
    (awful.key [user_vars.altkey :Shift] :m lain.util.magnify_client
               {:description "magnify client"
                :group :client})
    (awful.key [user_vars.modkey :Shift] :f
               (fn [c] (set c.fullscreen (not c.fullscreen))
                 (c:raise))
               {:description "toggle fullscreen"
                :group :client})
    (awful.key [user_vars.modkey] :w (fn [c] (c:kill))
               {:description :close :group :client})
    (awful.key [user_vars.modkey :Control] :space
               awful.client.floating.toggle
               {:description "toggle floating"
                :group :client})
    (awful.key [user_vars.modkey :Control] :Return
               (fn [c] (c:swap (awful.client.getmaster)))
               {:description "move to master"
                :group :client})
    (awful.key [user_vars.modkey] :o (fn [c] (c:move_to_screen))
               {:description "move to screen"
                :group :client})
    (awful.key [user_vars.modkey] :t
               (fn [c] (set c.ontop (not c.ontop)))
               {:description "toggle keep on top"
                :group :client})
    (awful.key [user_vars.modkey] :n (fn [c] (set c.minimized true))
               {:description :minimize :group :client})
    (awful.key [user_vars.modkey] :m
               (fn [c] (set c.maximized (not c.maximized))
                 (c:raise))
               {:description :maximize :group :client})))

(local clientbuttons
  (a-table.join
    (awful.button {} 1
                  (fn [c]
                    (c:emit_signal "request::activate"
                                   :mouse_click
                                   {:raise true})))
    (awful.button [user_vars.modkey] 1
                  (fn [c]
                    (c:emit_signal "request::activate"
                                   :mouse_click
                                   {:raise true})
                    (awful.mouse.client.move c)))
    (awful.button [user_vars.modkey] 3
                  (fn [c]
                    (c:emit_signal "request::activate"
                                   :mouse_click
                                   {:raise true})
                    (awful.mouse.client.resize c)))))

{: globalkeys
 : clientkeys
 : clientbuttons}
