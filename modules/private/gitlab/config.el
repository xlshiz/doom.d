;;; private/gitlab/config.el -*- lexical-binding: t; -*-

;; (setq gitlab-host "http://gitlab.com")
;; (setq gitlab-token-id "xxxxxxxxxxxxxxxxxxx")
(def-package! gitlab
  :defer 2
  :config
  (load! "~/.gitlab.el"))
