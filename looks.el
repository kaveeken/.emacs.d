(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(load-theme 'doom-one t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(set-fringe-mode 0)
(scroll-bar-mode -1)
(tool-bar-mode -1)
