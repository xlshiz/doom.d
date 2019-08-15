;;; private/shell/config.el -*- lexical-binding: t; -*-

(use-package! aweshell
  :commands (aweshell-new aweshell-next aweshell-prev)
  :config
  (setq eshell-highlight-prompt nil))
