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
   (python . t)))

(setq org-confirm-babel-evaluate nil)
