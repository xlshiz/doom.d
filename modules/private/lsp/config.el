;;; private/tabs/config.el -*- lexical-binding: t; -*-

(use-package! nox
  :init
  (defalias 'lsp! #'nox-ensure)
  (defalias 'lsp-rename #'nox-rename)
  :config
  (set-lookup-handlers! 'nox--managed-mode :async t
    :documentation #'nox-show-doc
    :definition #'xref-find-definitions
    :references #'xref-find-references)
  (setq nox-python-server-dir (concat doom-etc-dir "lsp/mspyls/")))
