;;; private/shell/config.el -*- lexical-binding: t; -*-

(def-package! shell-pop
  :commands (shell-pop)
  :init
  (set-popup-rules! '(("^\\*shell-pop-" :size 0.3 :quit nil :select t :ttl nil)))
  :config
  (shell/make-shell-pop-type 'multi-term)
  (setq shell-pop-autocd-to-working-dir nil))

(def-package! aweshell
  :commands (aweshell-new aweshell-next aweshell-prev)
  :config
  (setq eshell-highlight-prompt nil))
