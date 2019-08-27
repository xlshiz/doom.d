;;; private/tabnine/config.el -*- lexical-binding: t; -*-

(use-package! company-tabnine
  :defer t
  :init
  (setq company-tabnine-binaries-folder (concat doom-etc-dir "TabNine"))
; (setq company-tabnine-log-file-path "/tmp/tabnine.log")
  :config
  (defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
    (let ((company-message-func (ad-get-arg 0)))
      (when (and company-message-func
                 (stringp (funcall company-message-func)))
        (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
          ad-do-it)))))

