(require 'evil)
(define-key evil-normal-state-map (kbd "C-b") 'evil-scroll-up)
(evil-mode 1)
(require 'evil-snipe)
(evil-snipe-mode +1)
(evil-snipe-override-mode +1)

;; these interfere with my company-mode binds
(define-key evil-insert-state-map (kbd "C-n") nil)
(define-key evil-insert-state-map (kbd "C-p") nil)
