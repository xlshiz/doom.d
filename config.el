;;; private/my/config.el -*- lexical-binding: t; -*-


;;; set
(setq
  doom-theme 'doom-nord-light
  doom-font (font-spec :family "Source Code Pro Medium" :size 16))


;;; def-package
(def-package! avy
  :commands (avy-goto-char-timer)
  :init
  (setq avy-timeout-seconds 0.5)
  )

(def-package! symbol-overlay
  :commands (symbol-overlay-put symbol-overlay-remove-all))

;;; after
(after! org
  (setq org-directory "~/workdir/note/org/")
  (setq +org-dir org-directory)
  (setq org-default-notes-file (concat org-directory "/work.org"))
  (setq org-default-refile-file (concat org-directory "/refile.org"))
  (setq org-agenda-files (list org-default-notes-file))
  (setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-default-refile-file "Inbox")
             "* TODO %?\n")))
  (setq org-refile-targets '((org-default-notes-file . (:level . 1))
                             (org-default-refile-file . (:level . 1))))
  (setq org-todo-keywords (quote ((sequence "TODO(t)" "INPROCESS(p)" "|" "DONE(d)")))))

(set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)
;;(set-lookup-handlers! 'c-mode :definition #'rtags-find-symbol-at-point)

(after! imenu-list
  (setq imenu-list-focus-after-activation t
	imenu-list-auto-resize t))

(after! company
  (setq company-idle-delay 0.5))

;;; hook
(add-hook! 'git-commit-setup-hook #'yas-git-commit-mode)
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (setq indent-tabs-mode t c-basic-offset 8)))

(load! "+bindings")

(toggle-frame-maximized)
