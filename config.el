;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/my/config.el


;;; set
(setq doom-theme 'doom-nord-light)

;; (setq doom-font (font-spec :family "Iosevka Fixed ss04" :size 18))
(setq doom-font (font-spec :family "M+ 1m" :weight 'regular' :size 20))
(setq doom-unicode-font (font-spec :family "思源黑体"))
;; (setq doom-unicode-font (font-spec :family "Sarasa Fixed SC"))

(setq display-line-numbers-type nil)
(push (expand-file-name "forge/authinfo" doom-etc-dir) auth-sources)
(set-popup-rules! '(("^\\*edit-indirect " :size 0.3 :quit nil :select t :ttl nil)))

;;; before
(setq org-directory "~/workdir/docs/org/"
      org-default-refile-file (concat org-directory "/refile.org")
      +org-capture-notes-file "todo.org"
      org-agenda-files (list (concat org-directory +org-capture-notes-file)))
(setq org-re-reveal-extra-css (concat "file://" doom-etc-dir "present/local.css"))

;;; after
(after! org
  (add-hook 'org-mode-hook #'(lambda () (pangu-spacing-mode -1)
                               (setq-local company-idle-delay nil)
                               ;; (custom-set-faces
                               ;;  '(org-table ((t (:family "Sarasa Mono SC")))))
                               ))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-refile-file "Inbox")
           "* TODO %?\n")))
  (setq org-bookmark-names-plist '(:last-capture "org-capture-last-stored"
                                   :last-capture-marker "org-capture-last-stored-marker"))
  (setq org-refile-targets '((org-default-notes-file . (:level . 1))
                             (org-default-refile-file . (:level . 1))))
  (setq org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)")
                            (sequence "⚑(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
        org-todo-keyword-faces '(("HANGUP" . warning)
                                 ("❓" . warning))))

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
        company-global-modes '(not eshell-mode comint-mode erc-mode message-mode help-mode gud-mode)))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        lsp-vetur-validation-template nil
        lsp-eldoc-enable-hover t))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable nil
        lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs))))

(after! ace-window
  (custom-set-faces!
    '(aw-leading-char-face :inherit font-lock-keyword-face :bold t :height 3.0)
    '(aw-mode-line-face :inherit mode-line-emphasis :bold t)))

(after! evil-escape
  (setq evil-escape-key-sequence ",."))

(after! evil
  (advice-remove #'evil-join #'+evil-join-a))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))

(after! vterm
  (add-to-list 'vterm-keymap-exceptions "C-j"))

(after! forge
  (setq forge-alist
        '(("gitlab.com" "gitlab.com/api/v4"
           "gitlab.com" forge-gitlab-repository))))

(after! ghub
  (setq ghub-insecure-hosts '("gitlab.com/api/v4")))


;;; hook
(add-hook! 'git-commit-setup-hook #'yas-git-commit-mode)
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'after-make-frame-functions #'+my|init-font)
(add-hook 'window-setup-hook #'+my|init-font)


;;; advice
(defadvice evil-collection-vterm-setup (after +evil-collection-vterm-setup-h activate)
  (evil-collection-define-key 'insert 'vterm-mode-map
    (kbd "C-j") 'ace-window)
  (evil-collection-define-key 'normal 'vterm-mode-map
    (kbd "C-j") 'ace-window))

(defadvice +org-init-keybinds-h (after +org-change-keybinds-h activate)
  (map! :map org-mode-map
        :localleader
        "T"             #'org-show-todo-tree))

;;; load
(load! "+bindings")

(toggle-frame-maximized)

;; Fix project.el
(defun +my|projectile-project-find-function (dir)
  (let ((root (projectile-project-root dir)))
    (and root (cons 'transient root))))
(after! project
  (add-to-list 'project-find-functions '+my|projectile-project-find-function))
