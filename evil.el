(use-package evil-snipe
  :ensure t
  :init
  (add-hook 'evil-mode (evil-snipe-mode +1))
  :config
  (evil-snipe-override-mode +1))

(use-package evil
  :ensure t
  :init (evil-mode 1)
  :config
  (define-key evil-insert-state-map (kbd "C-n") nil) ;; interfere with
  (define-key evil-insert-state-map (kbd "C-p") nil) ;; company
  (define-key evil-normal-state-map (kbd "C-b") 'evil-scroll-up))
  
