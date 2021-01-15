(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t )
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(load-theme 'wombat)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(set-fringe-mode 0)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(load-file "~/.emacs.d/evil.el")
(load-file "~/.emacs.d/python.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(git-commit magit undo-fu evil-snipe evil-visual-mark-mode pyvenv use-package lsp-jedi lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "UKWN" :family "Monaco")))))
