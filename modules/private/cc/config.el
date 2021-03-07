;;; private/cc/config.el -*- lexical-binding: t; -*-

(use-package! ggtags
  :commands (ggtags-mode ggtags-find-tag-dwim))
(use-package! counsel-gtags
  :commands (counsel-gtags-dwim))

(after!  cc-mode
  (setq-default c-basic-offset 8)
  (set-pretty-symbols! '(c-mode c++-mode) nil)
  (add-hook! (c-mode c++-mode) #'+cc-private-setup)
  (defvar +font-lock-call-function '+font-lock-call-function)
  (font-lock-add-keywords 'c-mode
			  '(("\\(\\w+\\)\\s-*\(" . +font-lock-call-function))
			  t))


(after! ccls
  (setq ccls-executable "/usr/local/bin/ccls"
        ccls-sem-highlight-method nil)
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
  (evil-set-initial-state 'ccls-tree-mode 'emacs))


(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 1)) ; ccls has priority 0
