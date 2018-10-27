;;; private/gitlab/config.el -*- lexical-binding: t; -*-

(def-package! gitlab
  :defer 2
  :config
  (setq gitlab-host "http://gitlab.com"
	gitlab-token-id "xxxxxxxxxxxxxxxxxxx"))
