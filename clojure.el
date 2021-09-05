(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.edn\\'" . clojure-mode))
  :init
  (add-hook 'clojure-mode-hook #'cider-jack-in-clj)) ;; doesnt work

(setq nrepl-use-ssh-fallback-for-remote-hosts t)



;; https://github.com/clojure-emacs/cider/issues/1934#issuecomment-425243546
;; (defun my/truncate-string (string)
;;   (if (< 1000 (length string))
;;       (concat (substring string 0 1000) " ...["  (number-to-string (length string)) "]"  )
;;     string))
;; 
;; 
;; (defun cider-repl-emit-result (buffer string show-prefix &optional bol)
;;   "Emit into BUFFER the result STRING and mark it as an evaluation result.
;; If SHOW-PREFIX is non-nil insert `cider-repl-result-prefix' at the beginning
;; of the line.  If BOL is non-nil insert at the beginning of the line."
;;   (with-current-buffer buffer
;;     (save-excursion
;;       (cider-save-marker cider-repl-output-start
;; 	(cider-save-marker cider-repl-output-end
;; 	  (goto-char cider-repl-input-start-mark)
;; 	  (when (and bol (not (bolp)))
;; 	    (insert-before-markers "\n"))
;; 	  (when show-prefix
;; 	    (insert-before-markers (propertize cider-repl-result-prefix 'font-lock-face 'font-lock-comment-face)))
;; 	  (if cider-repl-use-clojure-font-lock
;; 	      (insert-before-markers (cider-font-lock-as-clojure (my/truncate-string string)))
;; 	    (cider-propertize-region
;; 		'(font-lock-face cider-repl-result-face rear-nonsticky (font-lock-face))
;; 	      (insert-before-markers (my/truncate-string string)))))))
;;     (cider-repl--show-maximum-output)))
;; 
;; 
;; 
;; (defun cider-repl--emit-output-at-pos (buffer string output-face position &optional bol)
;;   "Using BUFFER, insert STRING (applying to it OUTPUT-FACE) at POSITION.
;; If BOL is non-nil insert at the beginning of line.  Run
;; `cider-repl-preoutput-hook' on STRING."
;;   (with-current-buffer buffer
;;     (save-excursion
;;       (cider-save-marker cider-repl-output-start
;; 	(cider-save-marker cider-repl-output-end
;; 	  (goto-char position)
;; 	  ;; TODO: Review the need for bol
;; 	  (when (and bol (not (bolp))) (insert-before-markers "\n"))
;; 	  (setq string (propertize (my/truncate-string string)
;; 				   'font-lock-face output-face
;; 				   'rear-nonsticky '(font-lock-face)))
;; 	  (setq string (cider-run-chained-hook 'cider-repl-preoutput-hook string))
;; 	  (insert-before-markers  string)
;; 	  (cider-repl--flush-ansi-color-context)
;; 	  (when (and (= (point) cider-repl-prompt-start-mark)
;; 		     (not (bolp)))
;; 	    (insert-before-markers "\n")
;; 	    (set-marker cider-repl-output-end (1- (point)))))))
;;     (cider-repl--show-maximum-output)))
;; 
;; 
