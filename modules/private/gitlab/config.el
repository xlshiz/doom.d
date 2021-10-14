;;; private/gitlab/config.el -*- lexical-binding: t; -*-
;;;

(after! auth-source
	(push (expand-file-name "forge/authinfo" doom-etc-dir) auth-sources))

(after! forge
  (setq forge-alist
        '(("gitlab.com" "gitlab.com/api/v4"
           "gitlab.com" forge-gitlab-repository))))

(after! ghub
  (setq ghub-insecure-hosts '("gitlab.com/api/v4")))
