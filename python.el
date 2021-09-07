(use-package pyvenv
:ensure t
:defer t
:diminish
:config
(setenv "WORKON_HOME" "/home/kris/.pyenv/versions/")
	; Show python venv name in modeline
(setq pyvenv-mode-line-indicator '(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
(pyvenv-mode t))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(defvar python-default-pyenv "tweez-3.8.6")

(add-hook 'python-mode-hook
	  (lambda ()
	    (pyvenv-workon python-default-pyenv)
	    (make-local-variable 'display-fill-column-indicator-column)
	    (setq-local display-fill-column-indicator-column 80)
	    (display-fill-column-indicator-mode)))

