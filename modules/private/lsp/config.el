;;; lang/lsp/config.el -*- lexical-binding: t; -*-
;; * General
(def-package! lsp-mode
  :commands (lsp)
  :config
  (setq lsp-eldoc-hook '(lsp-hover)
	lsp-auto-guess-root t
	lsp-prefer-flymake nil
	lsp-session-file (expand-file-name ".lsp-session-v1" doom-cache-dir)))

(def-package! lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-enable-completion-at-point t
	lsp-ui-sideline-enable nil
	lsp-ui-sideline-ignore-duplicate t
        lsp-ui-doc-enable nil
        lsp-ui-doc-header nil
        lsp-ui-doc-include-signature nil
	lsp-ui-doc-background (doom-color 'base4)
        lsp-ui-doc-border (doom-color 'fg)
	lsp-ui-flycheck-enable t
	lsp-ui-peek-force-fontify nil
	lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs)))
   (map! :after lsp-ui-peek
         :map lsp-ui-peek-mode-map
         "h" #'lsp-ui-peek--select-prev-file
         "j" #'lsp-ui-peek--select-next
         "k" #'lsp-ui-peek--select-prev
         "l" #'lsp-ui-peek--select-next-file
         )
  )


(def-package! company-lsp
  :after lsp-mode
  :commands company-lsp
  :init
  (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil))
