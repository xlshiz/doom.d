;;; private/gitlab/config.el -*- lexical-binding: t; -*-

(use-package! forge
  :init
  (push (expand-file-name "forge/authinfo" doom-etc-dir) auth-sources)
  :config
  (custom-set-variables '(forge-post-mode-hook '(visual-line-mode)))
  (setq forge-alist
    '(("gitlab.com" "gitlab.com/api/v4"
     "gitlab.com" forge-gitlab-repository)))
  :after magit)

(after! ghub
  (setq ghub-insecure-hosts '("gitlab.com/api/v4")))
