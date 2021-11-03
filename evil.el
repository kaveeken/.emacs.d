(use-package evil-snipe
  :ensure t
  :init
  (add-hook 'evil-mode (evil-snipe-mode +1))
  :config
  (evil-snipe-override-mode +1))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode)
  (setq evil-undo-system 'undo-tree)
  (global-undo-tree-mode) ;; evil-undo-system needs to be set to undo-tree
  (define-key evil-insert-state-map (kbd "C-n") nil) ;; interfere with
  (define-key evil-insert-state-map (kbd "C-p") nil) ;; company
  (define-key evil-normal-state-map (kbd "C-b") 'evil-scroll-up))

  
