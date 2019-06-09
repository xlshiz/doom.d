;;; private/gitlab/config.el -*- lexical-binding: t; -*-

(def-package! forge
  :init
  (push (expand-file-name "forge/authinfo" doom-etc-dir) auth-sources)
  :config
  (custom-set-variables '(forge-post-mode-hook '(visual-line-mode)))
  (setq forge-alist
    '(("gitlab.com" "gitlab.com/api/v4"
     "gitlab.com" forge-gitlab-repository)))
  :after magit)
