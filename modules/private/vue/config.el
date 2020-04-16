;;; private/tabs/config.el -*- lexical-binding: t; -*-

(after! web-mode
  (define-derived-mode vue-mode web-mode "Vue")
  (delete '("\\.vue\\" . web-mode) auto-mode-alist)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode)))
