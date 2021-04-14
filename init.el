(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t )
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq ring-bell-function 'ignore) 

(load-file "~/.emacs.d/looks.el")
(load-file "~/.emacs.d/evil.el")
(load-file "~/.emacs.d/python.el")
(load-file "~/.emacs.d/clojure.el")

;; R
(use-package poly-R
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("95d0ed21bb0e919be7687a25ad59a1c2c8df78cbe98c9e369d44e65bfd65b167" "3c2f28c6ba2ad7373ea4c43f28fcf2eed14818ec9f0659b1c97d4e89c99e091e" "fce3524887a0994f8b9b047aef9cc4cc017c5a93a5fb1f84d300391fba313743" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" default))
 '(lsp-ui-doc-position 'at-point)
 '(lsp-ui-sideline-show-code-actions nil)
 '(package-selected-packages
   '(which-key async-await poly-R ess-r-insert-obj ess ein doom-themes doom-modeline gruvbox-theme company company-lsp flycheck lsp-ui cider clojure-mode git-commit magit undo-fu evil-snipe evil-visual-mark-mode pyvenv use-package lsp-jedi lsp-mode))
 '(safe-local-variable-values
   '((lsp-ui-sideline-show-code-actions)
     (lsp-ui-sideline-enable . f))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "UKWN" :family "Monaco")))))
