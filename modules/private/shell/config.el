;;; private/shell/config.el -*- lexical-binding: t; -*-

(use-package! aweshell
  :commands (aweshell-new aweshell-next aweshell-prev)
  :config
  (setq eshell-highlight-prompt nil))

(defadvice evil-collection-term-setup (after +evil-collection-term-setup-h activate)
  (evil-collection-define-key 'insert 'term-raw-map
    (kbd "C-j") 'ace-window)
  (evil-collection-define-key 'normal 'term-mode-map
    (kbd "C-j") 'ace-window))
