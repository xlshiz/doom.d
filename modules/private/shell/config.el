;;; private/shell/config.el -*- lexical-binding: t; -*-

(def-package! shell-pop
  :commands (shell-pop)
  :config
  (shell/make-shell-pop-type 'multi-term)
  (setq shell-pop-autocd-to-working-dir nil))

(def-package! aweshell
  :commands (aweshell-new aweshell-next aweshell-prev)
  :config
    (custom-set-faces
   '(epe-dir-face ((t (:foreground "#51afef"))))
   '(epe-git-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-delimiter-face ((t (:foreground "#98be65"))))
   '(epe-pipeline-host-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-time-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-user-face ((t (:foreground "#bbc2cf"))))))
