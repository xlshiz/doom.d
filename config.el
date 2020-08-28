;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/my/config.el


;;; set
(setq doom-theme 'doom-nord-light)

;; (setq doom-font (font-spec :family "Iosevka Fixed ss04" :size 18))
;; (setq doom-unicode-font (font-spec :family "Sarasa Fixed SC"))
(setq doom-font (font-spec :family "M+ 1m" :size 18))
(setq doom-unicode-font (font-spec :family "思源黑体"))

(setq display-line-numbers-type nil)

(set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)

;;; def-package
(use-package! avy
  :commands (avy-goto-char-timer)
  :init
  (setq avy-timeout-seconds 0.5))

(use-package! edit-indiect
  :defer t
  :init
  (set-popup-rules! '(("^\\*edit-indirect " :size 0.3 :quit nil :select t :ttl nil))))

(use-package! paradox
  :commands (paradox-list-packages))

(use-package! imenu-list
  :defer t
  :config
  (setq imenu-list-focus-after-activation t
        imenu-list-idle-update-delay 0.5
        imenu-list-auto-resize t)
  (set-popup-rule! "^\\*Ilist"
    :side 'right :size 35 :quit nil :select nil :ttl 0))

(use-package! org
  :defer t
  :init
  (setq org-directory "~/workdir/docs/org/"
        org-default-refile-file (concat org-directory "/refile.org")
        +org-capture-notes-file "todo.org"
        org-agenda-files (list (concat org-directory +org-capture-notes-file)))
  (advice-add #'+org-init-keybinds-h :after #'+org-change-keybinds-h)
  :preface
  (advice-add #'+org-init-appearance-h :after #'+org-change-appearance-h))

(use-package! ox-re-reveal
  :after ox
  :config
  (setq org-re-reveal-external-plugins `((chalkboard . ,(concat "{src: '" doom-etc-dir "present/reveal.js-plugins/chalkboard/plugin.js'}"))))
  (setq org-re-reveal-extra-css (concat "file://" doom-etc-dir "present/local.css")))

;;; after
(after! org
  (add-hook 'org-mode-hook #'(lambda () (pangu-spacing-mode -1)))
                                        ; (custom-set-faces
                                        ; '(org-table ((t (:family "Sarasa Mono SC")))))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-refile-file "Inbox")
           "* TODO %?\n")))
  (setq org-bookmark-names-plist '(:last-capture "org-capture-last-stored"
                                                 :last-capture-marker "org-capture-last-stored-marker")))

(after! evil-org
  (remove-hook! 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(after! company
  (map! :map company-active-map
        "TAB"       #'+my/smarter-yas-expand-next-field-complete
        [tab]       #'+my/smarter-yas-expand-next-field-complete
        [C-return]  #'+my/return-cancel-completion)
  (setq company-minimum-prefix-length 2
        company-box-doc-enable nil
        company-idle-delay 0.2
        company-show-numbers t
        company-global-modes '(not org-mode eshell-mode comint-mode erc-mode message-mode help-mode gud-mode)))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
    lsp-vetur-validation-template nil
    lsp-eldoc-enable-hover t))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-doc-enable nil
        lsp-ui-doc-header nil
        lsp-ui-doc-include-signature nil
        lsp-ui-doc-background (doom-color 'base4)
        lsp-ui-doc-border (doom-color 'fg)
        lsp-ui-peek-force-fontify nil
        lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs)))
  (map! :after lsp-ui-peek
        :map lsp-ui-peek-mode-map
        "h" #'lsp-ui-peek--select-prev-file
        "j" #'lsp-ui-peek--select-next
        "k" #'lsp-ui-peek--select-prev
        "l" #'lsp-ui-peek--select-next-file))

(after! ace-window
  (custom-set-faces!
    '(aw-leading-char-face :inherit font-lock-keyword-face :bold t :height 3.0)
    '(aw-mode-line-face :inherit mode-line-emphasis :bold t)))

(after! evil-escape
  (setq evil-escape-key-sequence ",."))

(after! pdf-tools
  (map! :map pdf-annot-list-mode-map
        :n  "q"         #'tablist-quit
        :n  [return]    #'pdf-annot-list-display-annotation-from-id))

(after! dumb-jump
  (setq dumb-jump-prefer-searcher "rg"))


(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))


;;; hook
(add-hook! 'git-commit-setup-hook #'yas-git-commit-mode)
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (setq indent-tabs-mode t c-basic-offset 8)))
(add-hook 'after-make-frame-functions #'+my|init-font)
(add-hook 'window-setup-hook #'+my|init-font)


;;; load
(load! "+bindings")

(toggle-frame-maximized)
