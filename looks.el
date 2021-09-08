(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(load-theme 'doom-one t)
(defun synchronize-theme ()
  (setq hour
    (string-to-number
     (substring (current-time-string) 11 13)))
  (if (member hour (number-sequence 6 17))
      (load-theme 'doom-acario-light t) ;; redundant load-themes
    (load-theme 'doom-one t)))

(run-with-timer 0 3600 (synchronize-theme))


(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(set-fringe-mode 0)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(use-package dashboard
    :ensure t
    :diminish dashboard-mode
    :config
    ;(setq dashboard-banner-logo-title "your custom text")
    ;(setq dashboard-startup-banner "/path/to/image")
    (setq dashboard-items '((recents  . 10)
                            (bookmarks . 10)))
    (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
;(setq initial-buffer-choice "*dashboard*")


(defun set-window-width (n)
  "Set the selected window's width. Only works for windows on the left."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window (on the left side of the frame) to 80 columns."
  (interactive)
  (set-window-width 87)) ;; including line numbers etc

(global-set-key (kbd "<f5>") 'set-80-columns)
