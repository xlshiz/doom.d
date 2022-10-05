;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/my/config.el

;;; set
(setq doom-theme 'doom-nord-light)
(setq display-line-numbers-type nil)

(setq doom-font (font-spec :family "Sarasa Fixed SC" :weight 'regular' :size 20))
;; (setq doom-font (font-spec :family "input" :weight 'regular' :size 20))
;; (setq doom-font (font-spec :family "M PLUS Code Latin 50" :weight 'regular' :size 20))
(setq doom-unicode-font (font-spec :family "Sarasa Fixed SC"))

;;; before
(setq org-directory "~/workdir/docs/org/"
      org-noter-notes-search-path org-directory
      org-default-refile-file (concat org-directory "/refile.org")
      +org-capture-todo-file "todo.org"
      +org-capture-notes-file "maybe.org"
      org-agenda-files (list (concat org-directory +org-capture-todo-file)))
(setq org-re-reveal-extra-css (concat "file://" doom-data-dir "present/local.css"))

;;; after
(after! org
  (setq org-bookmark-names-plist '(:last-capture "org-capture-last-stored"
                                   :last-capture-marker "org-capture-last-stored-marker")))
(after! auth-source
  (push (expand-file-name "forge/authinfo" doom-data-dir) auth-sources))
;; (after! forge
;;   (setq forge-alist
;;         '(("gitlab.com" "gitlab.com/api/v4"
;;            "gitlab.com" forge-gitlab-repository))))
;; (after! ghub
;;   (setq ghub-insecure-hosts '("gitlab.com/api/v4")))

;;; hook
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;;; test

(toggle-frame-maximized)
