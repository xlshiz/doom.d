;;; private/my/config.el -*- lexical-binding: t; -*-


;;; set
(setq
  doom-theme 'doom-nord-light
  doom-font (font-spec :family "Source Code Pro Medium" :size 16))

(set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)
;;(set-lookup-handlers! 'c-mode :definition #'rtags-find-symbol-at-point)


;;; def-package
(def-package! avy
  :commands (avy-goto-char-timer)
  :init
  (setq avy-timeout-seconds 0.5)
  )

(def-package! symbol-overlay
  :commands (symbol-overlay-put symbol-overlay-remove-all))

(def-package! color-rg
  :commands (color-rg-search-input color-rg-search-symbol color-rg-search-project))

(def-package! company-english-helper
  :commands (toggle-company-english-helper))

(def-package! insert-translated-name
  :commands (insert-translated-name-insert insert-translated-name-insert-with-underline
	       insert-translated-name-insert-with-line insert-translated-name-insert-with-camel))

(def-package! awesome-tab
  :defer 0.5
  :config
  (custom-set-faces
   '(awesome-tab-default ((t (:inherit default :height 1.0)))))
  (awesome-tab-mode)
  )


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

(after! imenu-list
  (setq imenu-list-focus-after-activation t
	imenu-list-auto-resize t))

(after! company
  (setq company-minimum-prefix-length 2
        company-quickhelp-delay nil
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        ))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  )


;;; hook
(add-hook! 'git-commit-setup-hook #'yas-git-commit-mode)
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (setq indent-tabs-mode t c-basic-offset 8)))


;;; load
(load! "+bindings")

(toggle-frame-maximized)
