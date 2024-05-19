
(local awesome awesome)
(local naughty (require :naughty))

;; Check if awesome encountered an error during startup and fell back to
;; another config (This code will only ever execute for the fallback config)
(if awesome.startup_errors
  (naughty.notify {:preset naughty.config.presets.critical
                   :title  "Oops, there were errors during startup!"
                   :text   awesome.startup_errors}))

;; Handle runtime errors after startup

(do
  (var in-error false)
  (awesome.connect_signal
    "debug::error"
    (fn [err]
      (when (not in-error)
        (set in-error true)
        (naughty.notify {:preset naughty.config.presets.critical
                         :title  "Oops, an error happened!"
                         :text   (tostring err)})
        (set in-error false)))))
