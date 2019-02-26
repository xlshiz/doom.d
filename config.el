;;; private/my/config.el -*- lexical-binding: t; -*-


;;; set
(setq doom-theme 'doom-nord-light)
; (setq doom-font (font-spec :family "Fira Code" :size 18))
(setq doom-font (font-spec :family "Inconsolatag" :size 18))
(setq doom-unicode-font (font-spec :family "Sarasa Mono SC"))
; (setq doom-font (font-spec :family "Source Code Pro" :size 18))
; (setq doom-unicode-font (font-spec :family "思源黑体"))

(set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)

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
  :init
  (custom-set-variables '(awesome-tab-background-color (doom-color 'bg)))
  (custom-set-faces
    '(awesome-tab-default ((t (:background "#e5e9f0" :forgeground "white")))))
  :config
  (setq awesome-tab-cycle-scope 'tabs)
  (defun awesome-tab-hide-tab-function (x)
    (let ((name (format "%s" x)))
      (and
	(not (string-prefix-p "*epc" name))
	(not (string-prefix-p "*helm" name))
	(not (string-prefix-p "*Compile-Log*" name))
	(not (string-prefix-p "*lsp" name))
	(not (string-prefix-p "*ccls" name))
	(not (string-prefix-p "*Flycheck" name))
	(not (string-prefix-p "*Org Agenda*" name))
	(not (and (string-prefix-p "magit" name)
		  (not (file-name-extension name))))
	)))
  (awesome-tab-mode)
  )

(def-package! paradox
  :commands (paradox-list-packages))

;;; after
(after! org
  (setq org-directory "~/workdir/note/org/")
  (setq +org-dir org-directory)
  (setq org-default-notes-file (concat org-directory "/work.org"))
  (setq org-default-refile-file (concat org-directory "/refile.org"))
  (setq org-agenda-files (list org-default-notes-file))
  (custom-set-faces
    '(org-table ((t (:family "Sarasa Mono SC")))))
  (setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-default-refile-file "Inbox")
             "* TODO %?\n")))
  (setq org-refile-targets '((org-default-notes-file . (:level . 1))
                             (org-default-refile-file . (:level . 1))))
  (setq org-bookmark-names-plist '(:last-capture "org-capture-last-stored"
                                   :last-capture-marker "org-capture-last-stored-marker"))
  (setq org-todo-keywords (quote ((sequence "TODO(t)" "INPROCESS(p)" "|" "DONE(d)")))))

(after! imenu-list
  (setq imenu-list-focus-after-activation t
	imenu-list-auto-resize t))

(after! company
  (setq company-minimum-prefix-length 2
        company-quickhelp-delay nil
        company-show-numbers t
        company-global-modes '(not eshell-mode comint-mode erc-mode message-mode help-mode gud-mode)
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
(add-hook 'org-mode-hook #'(lambda () (pangu-spacing-mode -1)))
(add-hook 'after-make-frame-functions #'+my|init-font)
(add-hook 'window-setup-hook #'+my|init-font)


;;; load
(load! "+bindings")

(toggle-frame-maximized)
