;;; ui/tabbar/config.el -*- lexical-binding: t; -*-

(def-package! awesome-tab
  :defer 0.5
  :init
  (setq awesome-tab-display-icon nil)
  :config
  (setq awesome-tab-height 28)
  (setq awesome-tab-cycle-scope 'tabs)
  (setq awesome-tab-display-sticky-function-name nil)

  (defun +tabbar|init-frames ()
    (dolist (frame (frame-list))
      (if (not awesome-tab-mode)
	(set-frame-parameter frame 'buffer-predicate (frame-parameter frame 'old-buffer-predicate))
	(set-frame-parameter frame 'old-buffer-predicate (frame-parameter frame 'buffer-predicate))
	(set-frame-parameter frame 'buffer-predicate #'+tabbar-buffer-predicate))))
  (add-hook 'awesome-tab-mode-hook #'+tabbar|init-frames)

  (setq awesome-tab-hide-tab-function #'+tabbar-hide-tab
	; awesome-tab-buffer-list-function #'+tabbar-window-buffer-list
	awesome-tab-buffer-groups-function #'+tabbar-buffer-groups)

  (advice-add #'awesome-tab-buffer-close-tab :override #'+tabbar*kill-tab-maybe)
  (advice-add #'bury-buffer :around #'+tabbar*bury-buffer)
  (advice-add #'kill-current-buffer :before #'+tabbar*kill-current-buffer)
  (add-hook 'doom-switch-buffer-hook #'+tabbar|add-buffer)
  (add-hook 'doom-switch-window-hook #'+tabbar|new-window)

  (add-hook '+doom-dashboard-mode-hook #'awesome-tab-local-mode)

  (map! (:map awesome-tab-mode-map
	      [remap delete-window] #'+tabbar/close-tab-or-window
	      [remap +workspace/close-window-or-workspace] #'+tabbar/close-tab-or-window)
	(:after persp-mode
		:map persp-mode-map
		[remap delete-window] #'+tabbar/close-tab-or-window
		[remap +workspace/close-window-or-workspace] #'+tabbar/close-tab-or-window))

  (awesome-tab-mode)
  )
