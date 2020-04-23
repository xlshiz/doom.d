;;; private/shell/config.el -*- lexical-binding: t; -*-

(use-package! aweshell
  :commands (aweshell-new aweshell-next aweshell-prev)
  :config
  (setq eshell-highlight-prompt nil))

(use-package! vterm
  :defer t
  :init
  (setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes")
  :config
  (add-to-list 'vterm-keymap-exceptions "C-j"))

(defadvice evil-collection-term-setup (after +evil-collection-term-setup-h activate)
  (evil-collection-define-key 'insert 'term-raw-map
    (kbd "C-j") 'ace-window)
  (evil-collection-define-key 'normal 'term-mode-map
    (kbd "C-j") 'ace-window))

(defadvice evil-collection-vterm-setup (after +evil-collection-vterm-setup-h activate)
  (evil-collection-define-key 'insert 'vterm-mode-map
    (kbd "C-j") 'ace-window)
  (evil-collection-define-key 'normal 'vterm-mode-map
    (kbd "C-j") 'ace-window))
