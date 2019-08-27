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

(use-package! snails
  :commands (snails snails-search-point)
  :config
  (map! :map snails-mode-map
	[escape]	#'snails-quit
	)
  (evil-set-initial-state 'snails-mode 'emacs))

