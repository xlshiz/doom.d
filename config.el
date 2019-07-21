;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/my/config.el


;;; set
(setq doom-theme 'doom-nord-light)

(setq doom-font (font-spec :family "Sarasa Mono SC" :size 18))
(setq doom-unicode-font (font-spec :family "Sarasa Mono SC"))
; (setq doom-unicode-font (font-spec :family "文泉驿等宽正黑"))
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
  :commands (color-rg-search-input color-rg-search-symbol
	     color-rg-search-symbol-in-current-file color-rg-search-project)
  :init
  (define-key! swiper-map "<M-return>" #'+my/swiper-to-color-rg)
  (define-key! counsel-ag-map "<M-return>" #'+my/counsel-to-color-rg)
  :config
  (set-popup-rule! "^\\*color-rg\*"
    :height 0.4 :quit nil :select nil :ttl 0)
  (evil-set-initial-state 'color-rg-mode 'emacs))

(def-package! company-english-helper
  :commands (toggle-company-english-helper))

(def-package! insert-translated-name
  :commands (insert-translated-name-insert insert-translated-name-insert-with-underline
	       insert-translated-name-insert-with-line insert-translated-name-insert-with-camel))

(def-package! edit-indiect
  :defer t
  :init
  (set-popup-rules! '(("^\\*edit-indirect " :size 0.3 :quit nil :select t :ttl nil))))

(def-package! paradox
  :commands (paradox-list-packages))

(def-package! imenu-list
  :config
  (setq imenu-list-focus-after-activation t
	imenu-list-idle-update-delay 0.5
	imenu-list-auto-resize t)
  (set-popup-rule! "^\\*Ilist"
    :side 'right :size 35 :quit nil :select nil :ttl 0))

(def-package! company-tabnine
  :defer t
  :config
  (defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
    (let ((company-message-func (ad-get-arg 0)))
      (when (and company-message-func
                 (stringp (funcall company-message-func)))
        (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
          ad-do-it)))))


;;; after
(after! org
  (remove-hook! 'org-tab-first-hook #'+org|cycle-only-current-subtree)
  (setq org-directory "~/workdir/note/org/")
  (setq +org-dir org-directory)
  (setq org-default-notes-file (concat org-directory "/todo.org"))
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

(after! ace-window
  (custom-set-faces!
   '(aw-leading-char-face :inherit font-lock-keyword-face :bold t :height 3.0)
   '(aw-mode-line-face :inherit mode-line-emphasis :bold t)))

(after! evil-escape
  (setq evil-escape-key-sequence "fd"))


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
