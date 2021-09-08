(setq org-default-notes-file "~/org/notes.org")
(setq org-adapt-indentation nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (clojure . t)
   (R . t)
   (C . t)
   (python . t)))

(setq org-confirm-babel-evaluate nil)
