;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/my/config.el


;;; set
(setq doom-theme 'doom-nord-light)

; (setq doom-font (font-spec :family "Fira Code" :size 18))
; (setq doom-unicode-font (font-spec :family "文泉驿等宽正黑"))

(setq doom-font (font-spec :family "Iosevka SS05" :size 18))
(setq doom-unicode-font (font-spec :family "Sarasa Mono SC"))

; (setq doom-font (font-spec :family "Source Code Pro" :size 18))
; (setq doom-unicode-font (font-spec :family "思源黑体"))
(setq display-line-numbers-type nil)

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
  :commands (color-rg-search-input color-rg-search-symbol color-rg-search-project)
  :config
  (evil-set-initial-state 'color-rg-mode 'emacs))

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
  (setq awesome-tab-hide-tab-function #'+my|awesome-tab-hide-tab)
  (setq awesome-tab-display-sticky-function-name nil)
  (awesome-tab-mode)
  )

(def-package! edit-indiect
  :defer t
  :init
  (set-popup-rules! '(("^\\*edit-indirect " :size 0.3 :quit nil :select t :ttl nil))))

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
	company-idle-delay 0.2
        company-show-numbers t
        company-global-modes '(not org-mode eshell-mode comint-mode erc-mode message-mode help-mode gud-mode)
        ))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  )

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))

(after! lsp-ui
  (setq lsp-enable-completion-at-point t
	lsp-ui-sideline-enable nil
	lsp-ui-sideline-ignore-duplicate t
        lsp-ui-doc-enable nil
        lsp-ui-doc-header nil
        lsp-ui-doc-include-signature nil
	lsp-ui-doc-background (doom-color 'base4)
        lsp-ui-doc-border (doom-color 'fg)
	lsp-ui-flycheck-enable t
	lsp-ui-peek-force-fontify nil
	lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs)))
   (map! :after lsp-ui-peek
         :map lsp-ui-peek-mode-map
         "h" #'lsp-ui-peek--select-prev-file
         "j" #'lsp-ui-peek--select-next
         "k" #'lsp-ui-peek--select-prev
         "l" #'lsp-ui-peek--select-next-file
         )
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
