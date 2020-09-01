;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/editer/config.el

(use-package! edit-indiect
  :defer t
  :init
  (set-popup-rules! '(("^\\*edit-indirect " :size 0.3 :quit nil :select t :ttl nil))))

(use-package! imenu-list
  :defer t
  :config
  (setq imenu-list-focus-after-activation t
        imenu-list-idle-update-delay 0.5
        imenu-list-auto-resize t)
  (set-popup-rule! "^\\*Ilist"
    :side 'right :size 35 :quit nil :select nil :ttl 0))

(use-package! thing-edit
  :commands (thing-cut-parentheses thing-copy-parentheses thing-replace-parentheses thing-copy-region-or-line thing-cut-region-or-line thing-replace-region-or-line)
  :defer t)
