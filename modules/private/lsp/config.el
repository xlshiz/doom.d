;;; private/tabs/config.el -*- lexical-binding: t; -*-

(use-package! nox
  :init
  (defalias 'lsp! #'nox-ensure)
  (defalias 'lsp-rename #'nox-rename)
  (setq nox-optimization-p nil)
  :config
  (delete '((js-mode typescript-mode) . ("javascript-typescript-stdio")) nox-server-programs)
  (add-to-list 'nox-server-programs '((js-mode typescript-mode) . ("typescript-language-server" "--stdio")))
  (set-lookup-handlers! 'nox--managed-mode :async t
    :documentation #'nox-show-doc
    :definition #'xref-find-definitions
    :references #'xref-find-references)
  (setq nox-python-server-dir (concat doom-etc-dir "lsp/mspyls/")))
