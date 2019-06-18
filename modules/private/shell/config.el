;;; private/shell/config.el -*- lexical-binding: t; -*-

(def-package! aweshell
  :commands (aweshell-new aweshell-next aweshell-prev)
  :config
  (setq eshell-highlight-prompt nil))
