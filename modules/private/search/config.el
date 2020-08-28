;;; private/search/config.el -*- lexical-binding: t; -*-

(use-package! symbol-overlay
  :commands (symbol-overlay-put symbol-overlay-remove-all))

(use-package! color-rg
  :commands (color-rg-search-input color-rg-search-symbol
              color-rg-search-symbol-in-current-file color-rg-search-project)
  :init
  (define-key! swiper-map "<M-return>" #'+my/swiper-to-color-rg)
  (define-key! counsel-ag-map "<M-return>" #'+my/counsel-to-color-rg)
  (defconst evil-collection-color-rg-maps '(color-rg-mode-map
                                             color-rg-mode-edit-map))
  :config
  (advice-add #'color-rg-update-header-line :override #'ignore)
  (set-popup-rule! "^\\*color-rg\*"
    :height 0.4 :quit nil :select nil :ttl 0)
  (defhydra color-rg-hydra (:hint nil)
    "
    ^^^^Move               ^^^^filter                     ^^toggle            ^^change
   -^^^^-----------------+-^^^^-------------------------+-^^------------------+-^^---------------------------
    _n_   next keyword   | _r_   replace all            | _I_  toggle ignore  | _d_  change dir
    _p_   prev keyword   | _f_   filter match result    | _c_  toggle case    | _z_  change globs
    _N_   next file      | _F_   filter mismatch result | _i_  open edit mode | _Z_  change exclude
    _P_   prev file      | _x_   filter match files     | ^^                  | _t_  return literal
    _D_   remove line    | _X_   filter mismatch files  | _u_  unfilter       | _s_  return regexp
   -^^^^-----------------+-^^^^-------------------------+-^^------------------+-^^---------------------------
  "
    ("n" color-rg-jump-next-keyword)
    ("p" color-rg-jump-prev-keyword)
    ("N" color-rg-jump-next-file)
    ("P" color-rg-jump-prev-file)

    ("r" color-rg-replace-all-matches)
    ("f" color-rg-filter-match-results)
    ("F" color-rg-filter-mismatch-results)
    ("x" color-rg-filter-match-files)
    ("X" color-rg-mismatch-files)
    ("u" color-rg-unfilter)
    ("D" color-rg-remove-line-from-results)

    ("I" color-rg-rerun-toggle-ignore)
    ("t" color-rg-rerun-literal)
    ("c" color-rg-rerun-toggle-case)
    ("s" color-rg-rerun-regexp)
    ("d" color-rg-rerun-change-dir)
    ("z" color-rg-rerun-change-globs)
    ("Z" color-rg-rerun-change-exclude-files)
    ("C" color-rg-customized-search)
    ("i" color-rg-switch-to-edit-mode)
    ("q" nil "quit"))
  (evil-collection-color-rg-setup))

(use-package! snails
  :when (featurep! +snails)
  :commands (snails)
  :config
  (setq snails-default-backends '(snails-backend-buffer snails-backend-projectile  snails-backend-recentf))
  (setq snails-backend-buffer-blacklist (append '( " *snails tips*"  "*" " *") snails-backend-buffer-blacklist))
  (setq snails-prefix-backends
    '(("#" '(snails-backend-buffer))
      (">" '(snails-backend-projectile snails-backend-fd snails-backend-mdfind snails-backend-everything))
      ("?" '(snails-backend-recentf))
      ("@" '(snails-backend-imenu))
      ("$" '(snails-backend-current-buffer))
      ("!" '(snails-backend-rg))
  ))
  (map! :map snails-mode-map
	"C-j"	#'snails-select-next-item
	"C-k"	#'snails-select-prev-item
	"M-n"	#'snails-select-next-backend
	"M-p"	#'snails-select-prev-backend
	"<escape>"	#'snails-quit)
  (evil-set-initial-state 'snails-mode 'emacs))


(after! ivy-rich
  (ivy-rich-mode -1)
  (setq ivy-rich-display-transformers-list
    (plist-put ivy-rich-display-transformers-list
      'snail
      '(:columns
         ((+snail-rich-buffer-tag (:face success))
           (+ivy-rich-buffer-icon)
           (ivy-rich-candidate (:width 0.8))))))
  (ivy-rich-mode 1))
