;;; private/cc/config.el -*- lexical-binding: t; -*-

(def-package! ccls
  :defer t
  :init
  (add-hook! (c-mode c++-mode) #'+cc-private-setup)
  :config
  (add-to-list 'projectile-globally-ignored-directories ".ccls-cache")
  (setq ccls-executable "/usr/local/bin/ccls"
        ccls-cache-dir (concat doom-cache-dir ".ccls_cached_index")
        ccls-sem-highlight-method nil)
        ; ccls-sem-highlight-method 'font-lock)
  ; (ccls-use-default-rainbow-sem-highlight)
  (setq ccls-initialization-options
   `(:clang
     (:excludeArgs
      ;; Linux's gcc options. See ccls/wiki
      ["-falign-jumps=1" "-falign-loops=1" "-fconserve-stack" "-fmerge-constants" "-fno-code-hoisting" "-fno-schedule-insns" "-fno-var-tracking-assignments" "-fsched-pressure"
       "-mhard-float" "-mindirect-branch-register" "-mindirect-branch=thunk-inline" "-mpreferred-stack-boundary=2" "-mpreferred-stack-boundary=3" "-mpreferred-stack-boundary=4" "-mrecord-mcount" "-mindirect-branch=thunk-extern" "-mno-fp-ret-in-387" "-mskip-rax-setup"
       "--param=allow-store-data-races=0" "-Wa arch/x86/kernel/macros.s" "-Wa -"]
      :extraArgs ["--gcc-toolchain=/usr"]
      :pathMappings ,+ccls-path-mappings)
     :completion
     (:include
      (:blacklist
       ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
        "^/usr/(local/)?include/c\\+\\+/v1/"
        ]))
     :index (:initialBlacklist ,+ccls-initial-blacklist :trackDependency 1)))
  (set-lookup-handlers! '(c-mode c++-mode)
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (evil-set-initial-state 'ccls-tree-mode 'emacs))

(def-package! ggtags
  :commands (ggtags-mode ggtags-find-tag-dwim))
(def-package! counsel-gtags
  :commands (counsel-gtags-dwim))

(after!  cc-mode
  (setq-default c-basic-offset 8)
  (set-pretty-symbols! '(c-mode c++-mode)
    ;; Functional
    ;; :def "void "
    ;; Types
    ;; :null "NULL"
    ;; Flow
    :not "!"
    :and "&&" :or "||"
    :return "return")
  (defvar +font-lock-call-function '+font-lock-call-function)
  (font-lock-add-keywords 'c-mode
			  '(("\\(\\w+\\)\\s-*\(" . +font-lock-call-function))
			  t)
  (set-company-backend!  '(c-mode c++-mode objc-mode) '(company-lsp)))
