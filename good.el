;;; non-evil bindings

(define-prefix-command 'eval-map)

(global-set-key (kbd "C-x C-x") 'eval-map)
(global-set-key (kbd "C-x C-x e") 'eval-defun)
(global-set-key (kbd "C-x C-x r") 'eval-and-replace)

; this one does not work but I dont care
;(global-set-key (kbd "C-M-x") 'exchange-point-and-mark)

(defun eval-and-replace ()
  "Replace the sexp surrounding the cursor with its value.
  Does not work when cursor is on opening paren."
  (interactive)
  (evil-jump-item)  ;; go to open paren
  (evil-jump-item)  ;; go to close paren
  (forward-char)    ;; move past close paren
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

