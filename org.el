(setq org-default-notes-file "~/org/notes.org")
(setq org-adapt-indentation nil)

;; --- literate programming --- 
;; pretty code blocks with latex minted
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (clojure . t)
   (R . t)
   (C . t)
   (scheme . t)
   (python . t)))

(setq org-confirm-babel-evaluate nil)

(add-to-list 'org-structure-template-alist '("rg" . "src R :results graphics file :file"))


;; --- org-roam ---
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/org/roam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))
(setq org-roam-node-display-template "${title}")

;; for some mysterious reason, tab stopped working in org.
;; I'm explicitly binding it here
;; something to do with evil, but worked before.
(define-key org-mode-map (kbd "<tab>") 'org-cycle)

;; adapted functions
(defun org-insert-structure-template (type)
  "Insert a block structure of the type #+begin_foo/#+end_foo.
Select a block from `org-structure-template-alist' then type
either RET, TAB or SPC to write the block type.  With an active
region, wrap the region in the block.  Otherwise, insert an empty
block.
This version of the function is adapted to extend the behavior
of placing the cursor at the end of the first line of the
template (like for the src default template) to a specific R
code block template, whose options end in :file. This version
also immediately goes to evil-insert state."
  (interactive
   (list (pcase (org--insert-structure-template-mks)
	   (`("\t" . ,_) (read-string "Structure type: "))
	   (`(,_ ,choice . ,_) choice))))
  (let* ((region? (use-region-p))
	 (region-start (and region? (region-beginning)))
	 (region-end (and region? (copy-marker (region-end))))
	 ;(extended? (string-match-p "\\`\\(src\\|export\\)\\'" type))
	 ;(extended? (string-match-p "\\(src\\|export\\)" type))
	 (extended? (string-match-p "\\`\\(src\\|export\\|\.\+:file\\)\\'" type))
	 (verbatim? (string-match-p
		     (concat "\\`" (regexp-opt '("example" "export" "src")))
		     type)))
    (when region? (goto-char region-start))
    (let ((column (current-indentation)))
      (if (save-excursion (skip-chars-backward " \t") (bolp))
	  (beginning-of-line)
	(insert "\n"))
      (save-excursion
	(indent-to column)
	(insert (format "#+begin_%s%s\n" type (if extended? " " "")))
	(when region?
	  (when verbatim? (org-escape-code-in-region (point) region-end))
	  (goto-char region-end)
	  ;; Ignore empty lines at the end of the region.
	  (skip-chars-backward " \r\t\n")
	  (end-of-line))
	(unless (bolp) (insert "\n"))
	(indent-to column)
	(insert (format "#+end_%s" (car (split-string type))))
	(if (looking-at "[ \t]*$") (replace-match "")
	  (insert "\n"))
	(when (and (eobp) (not (bolp))) (insert "\n")))
      ;(if extended? (end-of-line)
      (if extended? (progn
		      (end-of-line)
		      (evil-insert 1))
	(forward-line)
	(skip-chars-forward " \t")))))

(defun org-edit-src-exit-bad ()
  "Kill current sub-editing buffer and return to source buffer.
   This version retains the source buffer's window.
   Original in org-src.el"
  (interactive)
  (unless (org-src-edit-buffer-p) (error "Not in a sub-editing buffer"))
  (let* ((beg org-src--beg-marker)
	 (end org-src--end-marker)
	 (write-back org-src--allow-write-back)
	 (remote org-src--remote)
	 (coordinates (and (not remote)
			   (org-src--coordinates (point) 1 (point-max))))
	 (code (and write-back (org-src--contents-for-write-back))))
    (set-buffer-modified-p nil)
    ;; Switch to source buffer.  Kill sub-editing buffer.
    (let ((edit-buffer (current-buffer))
	  (source-buffer (marker-buffer beg)))
      (unless source-buffer (error "Source buffer disappeared.  Aborting"))
      (org-src-switch-to-buffer source-buffer 'save) ;; 'exit => 'save
      (kill-buffer edit-buffer))
    ;; Insert modified code.  Ensure it ends with a newline character.
    (org-with-wide-buffer
     (when (and write-back (not (equal (buffer-substring beg end) code)))
       (undo-boundary)
       (goto-char beg)
       (delete-region beg end)
       (let ((expecting-bol (bolp)))
	 (insert code)
	 (when (and expecting-bol (not (bolp))) (insert "\n")))))
    ;; If we are to return to source buffer, put point at an
    ;; appropriate location.  In particular, if block is hidden, move
    ;; to the beginning of the block opening line.
    (unless remote
      (goto-char beg)
      (cond
       ;; Block is hidden; move at start of block.
       ((cl-some (lambda (o) (eq (overlay-get o 'invisible) 'org-hide-block))
		 (overlays-at (point)))
	(beginning-of-line 0))
       (write-back (org-src--goto-coordinates coordinates beg end))))
    ;; Clean up left-over markers and restore window configuration.
    (set-marker beg nil)
    (set-marker end nil)))
