;;; private/tabs/config.el -*- lexical-binding: t; -*-

(use-package! awesome-tab
  :defer 0.5
  :init
  (setq awesome-tab-display-icon t)
  (setq awesome-tab-height 140)
  (setq awesome-tab-cycle-scope 'tabs)
  (setq awesome-tab-display-sticky-function-name nil)
  (setq awesome-tab-ace-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq awesome-tab-dark-unselected-blend 0.9
	awesome-tab-dark-selected-foreground-color "#55ced1"
	awesome-tab-dark-unselected-foreground-color "#AAAAAA")
  (setq awesome-tab-light-unselected-blend 0.9
	awesome-tab-light-selected-foreground-color "#44AD8E"
	awesome-tab-light-unselected-foreground-color "#555555")
  :config
  (defun +tabs-buffer-groups-fn ()
    (list
      (cond ((or (string-equal "*" (substring (buffer-name) 0 1))
               (memq major-mode '(magit-process-mode
                                   magit-status-mode
                                   magit-diff-mode
                                   magit-log-mode
                                   magit-file-mode
                                   magit-blob-mode
                                   magit-blame-mode
                                   )))
              "Emacs")
        ((derived-mode-p 'eshell-mode)
          "EShell")
        ((derived-mode-p 'emacs-lisp-mode)
          "Elisp")
        ((derived-mode-p 'dired-mode)
          "Dired")
        ((awesome-tab-get-group-name (current-buffer))))))

  (defun +tabs-hide-tab (x)
    (let ((name (format "%s" x)))
      (or
        ;; Current window is not dedicated window.
        (window-dedicated-p (selected-window))

        ;; Buffer name not match below blacklist.
        (string-prefix-p "*epc" name)
        (string-prefix-p "*helm" name)
        (string-prefix-p "*Compile-Log*" name)
        (string-prefix-p "*lsp" name)

        (string-prefix-p "*ccls" name)
        (string-prefix-p "*Flycheck" name)
        (string-prefix-p "*flycheck" name)
        (string-prefix-p "*anaconda-mode*" name)
        (string-prefix-p "*Org Agenda*" name)
        (string-prefix-p "*edit-indirect" name)
        (string-prefix-p "*shell-pop" name)
        (string-prefix-p "*MULTI-TERM-DEDICATED*" name)
        (string-prefix-p "*Ilist*" name)
        (string-prefix-p " *transient*" name)
        (string-prefix-p "*helpful " name)
        (string-prefix-p "*Outline " name)
        (string-prefix-p "*NOX (" name)

        (and (string-prefix-p "magit" name)
          (not (file-name-extension name)))
        )))

  (setq awesome-tab-buffer-groups-function #'+tabs-buffer-groups-fn
    awesome-tab-hide-tab-function #'+tabs-hide-tab)

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
  (awesome-tab-mode))
