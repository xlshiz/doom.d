;;; private/cc/config.el -*- lexical-binding: t; -*-

(def-package! ccls
  :commands (lsp-ccls-enable)
  :init
  ;; (add-to-list 'projectile-globally-ignored-directories ".ccls-cache")
  :config
  (setq ccls-executable "/usr/local/bin/ccls"
        ccls-cache-dir (concat doom-cache-dir ".ccls_cached_index")
        ccls-sem-highlight-method 'font-lock)
  ;; (ccls-use-default-rainbow-sem-highlight)
  (set-lookup-handlers! '(c-mode c++-mode)
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)

  (setq ccls-extra-init-params
        '(:completion (:detailedLabel t) :xref (:container t)
                      :diagnostics (:frequencyMs 5000))))
  ;; (evil-set-initial-state 'ccls-tree-mode 'emacs)

(def-package! clang-format
  :commands (clang-format-region))

(def-package! ggtags
  :commands (ggtags-mode ggtags-find-tag-dwim))
(def-package! counsel-gtags
  :commands (counsel-gtags-dwim))

(after!  cc-mode
  (setq-default c-basic-offset 8)
  ;; Custom style, based off of linux
  (unless (assoc "dooc" c-style-alist)
    (push '("dooc"
            (c-comment-only-line-offset . 0)
            (c-hanging-braces-alist (brace-list-open)
                                    (brace-entry-open)
                                    (substatement-open after)
                                    (block-close . c-snug-do-while)
                                    (arglist-cont-nonempty))
            (c-cleanup-list brace-else-brace)
            (c-offsets-alist
             (statement-block-intro . +)
             (knr-argdecl-intro . 0)
             (substatement-open . 0)
             (substatement-label . 0)
             (statement-cont . +)
             (case-label . +)
             ;; align args with open brace OR don't indent at all (if open
             ;; brace is at eolp and close brace is after arg with no trailing
             ;; comma)
             (arglist-intro . +)
             (arglist-close +cc-lineup-arglist-close 0)
             ;; don't over-indent lambda blocks
             (inline-open . 0)
             (inlambda . 0)
             ;; indent access keywords +1 level, and properties beneath them
             ;; another level
             (access-label . -)
             (inclass +cc-c++-lineup-inclass +)
             (label . 0)))
          c-style-alist))
  (setq-default c-default-style "dooc")
  (add-hook 'c-mode-common-hook #'+cc-private-setup)
  (set-company-backend!  '(c-mode c++-mode objc-mode) '(company-lsp)))
