(setq org-default-notes-file "~/org/notes.org")
(setq org-adapt-indentation nil)

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
