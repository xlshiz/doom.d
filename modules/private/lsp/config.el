;;; private/lsp/config.el -*- lexical-binding: t; -*-

(use-package! nox
  :defer t
  :init
  (defalias 'lsp! #'nox-ensure)
  (defalias 'lsp-rename #'nox-rename)
  (setq nox-optimization-p nil)
  :config
  (setq nox-autoshutdown t)

  ;; js-mode
  (delete '((js-mode typescript-mode) . ("javascript-typescript-stdio")) nox-server-programs)
  (add-to-list 'nox-server-programs '((js-mode typescript-mode) . ("typescript-language-server" "--stdio")))

  ;; vue-mode
  (defclass nox-vls (nox-lsp-server) ()
    :documentation "Vue Language Server.")
  (cl-defmethod nox-initialization-options ((server nox-vls))
    "Passes through required vetur initialization options to VLS."
    '(:vetur
      (:completion
       (:autoImport t :useScaffoldSnippets t :tagCasing "kebab")
       :grammar
       (:customBlocks
        (:docs "md" :i18n "json"))
       :validation
       (:template :json-false :style :json-false :script :json-false :interpolation :json-false)
       :format
       (:options
        (:tabSize 2 :useTabs :json-false)
        :defaultFormatter
        (:html "prettyhtml" :css "prettier" :postcss "prettier" :scss "prettier" :less "prettier" :stylus "stylus-supremacy" :js "prettier" :ts "prettier")
        :defaultFormatterOptions
        (:js-beautify-html
         (:wrap_attributes "force-expand-multiline")
         :prettyhtml
         (:printWidth 100 :singleQuote :json-false :wrapAttributes :json-false :sortAttributes :json-false))
         :styleInitialIndent :json-false :scriptInitialIndent :json-false)
       :trace
       (:server "off"))
      :emmet
      (:showExpandedAbbreviation "never" :showAbbreviationSuggestions t :triggerExpansionOnTab :json-false)))

  (add-to-list 'nox-server-programs
    '(vue-mode . (nox-vls . ("vls" "--stdio"))))

  ;; python-mode
  (setq nox-python-server-dir (concat doom-etc-dir "lsp/mspyls/"))
  (setq nox-python-server "pyright")

  ;; doom handler
  (set-lookup-handlers! 'nox--managed-mode :async t
    :documentation #'nox-show-doc
    :implementations #'nox-find-implementation
    :definition #'xref-find-definitions
    :references #'xref-find-references))

