;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/my/config.el


;;; set
(setq doom-theme 'doom-nord-light)

;; (setq doom-font (font-spec :family "Iosevka Fixed ss04" :size 20))
(setq doom-font (font-spec :family "M+ 1m" :weight 'regular' :size 20))
;; (setq doom-unicode-font (font-spec :family "思源黑体"))
(setq doom-unicode-font (font-spec :family "Sarasa Fixed SC"))

(setq display-line-numbers-type nil)

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
                            (sequence "⚐(T)" "⚑(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
        org-todo-keyword-faces '(("DOING" . +org-todo-onhold)
				 ("⚑" . +org-todo-onhold)
				 ("HANGUP" . +org-todo-cancel)
                                 ("❓" . +org-todo-cancel))))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))


;;; hook
(add-hook! 'git-commit-setup-hook #'yas-git-commit-mode)
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
; (add-hook 'after-make-frame-functions #'+my|init-font)
; (add-hook 'window-setup-hook #'+my|init-font)


;;; advice


(toggle-frame-maximized)
