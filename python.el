(use-package pyvenv
:ensure t
:defer t
:diminish
:config

	(setenv "WORKON_HOME" "/home/kris/.pyenv/versions/")
	; Show python venv name in modeline
	(setq pyvenv-mode-line-indicator '(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
	(pyvenv-mode t))
(use-package lsp-mode
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
            (python-mode . lsp))
            ;; if you want which-key integration
            ;; (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(add-hook 'python-mode-hook
	  (lambda ()
	    (pyvenv-workon "tweez-3.8.6")
	    ;(make-local-variable 'flycheck-checker)
	    ;(setq-local flycheck-checker 'python-flake8)
	    (make-local-variable 'display-fill-column-indicator-column)
	    (setq-local display-fill-column-indicator-column 80)
	    (display-fill-column-indicator-mode)))

