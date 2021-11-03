(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t )
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq ring-bell-function 'ignore)
(setq column-number-mode t)

(load-file "~/.emacs.d/looks.el")
(load-file "~/.emacs.d/evil.el")
(load-file "~/.emacs.d/good.el")
(load-file "~/.emacs.d/python.el")
(load-file "~/.emacs.d/clojure.el")
;(load-file "~/.emacs.d/spell.el")
(load-file "~/.emacs.d/org.el")
(load-file "~/.emacs.d/fullscreen.el")

(use-package poly-R
  :ensure t)
(use-package ess
  :ensure t)
(setenv "R_LIBS_USER" "/home/kris/.local/lib/R")

(use-package undo-tree
  :ensure t)

(use-package async
  :ensure t
  :init
  (dired-async-mode 1))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode))

(use-package company-quickhelp
  :ensure t
  :defer t
  :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode)
  :config
  (setq company-quickhelp-delay 0.4))

(use-package company
  :ensure t
  :init (global-company-mode)
  :bind (:map company-active-map
     ("C-n" . company-select-next-or-abort)
     ("C-p" . company-select-previous-or-abort)
     :map company-search-map
     ("C-n" . company-select-next-or-abort)
     ("C-p" . company-select-previous-or-abort))
  :config
  (setq company-idle-delay 0.1))

;; couldn't insert spaces in minibuffer. this fixes it.
;(define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f91395598d4cb3e2ae6a2db8527ceb83fed79dbaf007f435de3e91e5bda485fb" "cf922a7a5c514fad79c483048257c5d8f242b21987af0db813d3f0b138dfaf53" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "95d0ed21bb0e919be7687a25ad59a1c2c8df78cbe98c9e369d44e65bfd65b167" "3c2f28c6ba2ad7373ea4c43f28fcf2eed14818ec9f0659b1c97d4e89c99e091e" "fce3524887a0994f8b9b047aef9cc4cc017c5a93a5fb1f84d300391fba313743" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" default))
 '(evil-undo-system 'undo-tree)
 '(nil nil t)
 '(objed-cursor-color "#ff6c6b")
 '(org-babel-clojure-backend 'cider)
 '(package-selected-packages
   '(org-roam org-babel-eval-in-repl undo-tree geiser-mit geiser company-quickhelp edit-indirect dashboard pandoc-mode which-key async-await poly-R ess-r-insert-obj ess ein doom-themes doom-modeline gruvbox-theme company flycheck cider clojure-mode git-commit magit undo-fu evil-snipe evil-visual-mark-mode pyvenv use-package))
 '(pdf-view-midnight-colors (cons "#bbc2cf" "#282c34"))
 '(rustic-ansi-faces
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "UKWN" :family "JuliaMono")))))
