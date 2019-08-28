;;; private/search/config.el -*- lexical-binding: t; -*-

(use-package! symbol-overlay
  :commands (symbol-overlay-put symbol-overlay-remove-all))

(use-package! color-rg
  :commands (color-rg-search-input color-rg-search-symbol
             color-rg-search-symbol-in-current-file color-rg-search-project)
  :init
  (define-key! swiper-map "<M-return>" #'+my/swiper-to-color-rg)
  (define-key! counsel-ag-map "<M-return>" #'+my/counsel-to-color-rg)
  :config
  (set-popup-rule! "^\\*color-rg\*"
    :height 0.4 :quit nil :select nil :ttl 0)
  (evil-set-initial-state 'color-rg-mode 'emacs))

(after! ivy-rich
  (setq ivy-rich-display-transformers-list
        (plist-put ivy-rich-display-transformers-list
                   'snail
                   '(:columns
                     ((+snail-rich-buffer-tag (:face success))
                      (+ivy-rich-buffer-icon)
                      (ivy-rich-candidate (:width 0.8)))))))

;; (use-package! snails
;;   :commands (snails snails-search-point)
;;   :config
;;   (map! :map snails-mode-map
;;         [escape]        #'snails-quit
;;         )
;;   (evil-set-initial-state 'snails-mode 'emacs))
