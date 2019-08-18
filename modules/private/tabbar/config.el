;;; ui/tabbar/config.el -*- lexical-binding: t; -*-

(def-package! awesome-tab
  :defer 0.5
  :init
  (setq awesome-tab-display-icon nil)
  (setq awesome-tab-height 28)
  (setq awesome-tab-cycle-scope 'tabs)
  (setq awesome-tab-display-sticky-function-name nil)
  :config
  (add-hook! 'awesome-tab-mode-hook
    (defun +tabbar-init-frames-h ()
      (dolist (frame (frame-list))
        (if (not awesome-tab-mode)
            (set-frame-parameter frame 'buffer-predicate (frame-parameter frame 'old-buffer-predicate))
          (set-frame-parameter frame 'old-buffer-predicate (frame-parameter frame 'buffer-predicate))
          (set-frame-parameter frame 'buffer-predicate #'+tabbar-buffer-predicate)))))

  (add-to-list 'window-persistent-parameters '(tabbar-buffers . writable))

  (setq awesome-tab-hide-tab-function #'+tabbar-hide-tab
	; awesome-tab-buffer-list-function #'+tabbar-window-buffer-list
	awesome-tab-buffer-groups-function #'+tabbar-buffer-groups)

  (advice-add #'awesome-tab-buffer-close-tab :override #'+tabbar-kill-tab-maybe-a)
  (advice-add #'bury-buffer :around #'+tabbar-bury-buffer-a)
  (advice-add #'kill-current-buffer :before #'+tabbar-kill-current-buffer-a)
  (add-hook 'doom-switch-buffer-hook #'+tabbar-add-buffer-h)
  (add-hook 'doom-switch-window-hook #'+tabbar-new-window-h)

  (add-hook '+doom-dashboard-mode-hook #'awesome-tab-local-mode)

  (map! (:map awesome-tab-mode-map
	      [remap delete-window] #'+tabbar/close-tab-or-window
	      [remap +workspace/close-window-or-workspace] #'+tabbar/close-tab-or-window)
	(:after persp-mode
		:map persp-mode-map
		[remap delete-window] #'+tabbar/close-tab-or-window
		[remap +workspace/close-window-or-workspace] #'+tabbar/close-tab-or-window))
  (defhydra awesome-fast-switch (:hint nil)
  "
    ^^^^Fast Move             ^^^^Tab                    ^^Search            ^^Misc
   -^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
      ^_k_^   prev group    | _C-a_^^     select first | _b_ search buffer | _C-k_   kill buffer
    _h_   _l_  switch tab   | _C-e_^^     select last  | _g_ search group  | _C-S-k_ kill others in group
      ^_j_^   next group    | _C-j_^^     ace jump     | ^^                | ^^
    ^^0 ~ 9^^ select window | _C-h_/_C-l_ move current | ^^                | ^^
   -^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
  "
  ("h" awesome-tab-backward-tab)
  ("j" awesome-tab-forward-group)
  ("k" awesome-tab-backward-group)
  ("l" awesome-tab-forward-tab)
  ("0" +tabbar/select-window)
  ("1" +tabbar/select-window)
  ("2" +tabbar/select-window)
  ("3" +tabbar/select-window)
  ("4" +tabbar/select-window)
  ("5" +tabbar/select-window)
  ("6" +tabbar/select-window)
  ("7" +tabbar/select-window)
  ("8" +tabbar/select-window)
  ("9" +tabbar/select-window)
  ("C-a" awesome-tab-select-beg-tab)
  ("C-e" awesome-tab-select-end-tab)
  ("C-j" awesome-tab-ace-jump)
  ("C-h" awesome-tab-move-current-tab-to-left)
  ("C-l" awesome-tab-move-current-tab-to-right)
  ("b" ivy-switch-buffer)
  ("g" awesome-tab-counsel-switch-group)
  ("C-k" kill-current-buffer)
  ("C-S-k" awesome-tab-kill-other-buffers-in-current-group)
  ("q" nil "quit"))
  (awesome-tab-mode)
  )
