;;; autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +my/alternate-buffer-in-persp ()
  "Switch back and forth between current and last buffer in the
current perspective."
  (interactive)
  (with-persp-buffer-list ()
                          (switch-to-buffer (other-buffer (current-buffer) t))))

;;;###autoload
(defun +my/alternate-window ()
  "Switch back and forth between current and last window in the
current frame."
  (interactive)
  (let (;; switch to first window previously shown in this frame
        (prev-window (get-mru-window nil t t)))
    ;; Check window was not found successfully
    (unless prev-window (user-error "Last window not found."))
    (select-window prev-window)))

;;;###autoload
(defun +my/projectile-shell-pop ()
  "Open a term buffer at projectile project root."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (call-interactively '+term/open)))

;;;###autoload
(defun +my/ivy-eshell-history ()
  (interactive)
  (require 'em-hist)
  (let* ((start-pos (save-excursion (eshell-bol) (point)))
         (end-pos (point))
         (input (buffer-substring-no-properties start-pos end-pos))
         (command (ivy-read "Command: "
                            (delete-dups
                             (when (> (ring-size eshell-history-ring) 0)
                               (ring-elements eshell-history-ring)))
                            :initial-input input)))
    (setf (buffer-substring start-pos end-pos) command)
    (end-of-line)))

;;;###autoload
(defun +my/realgud-eval-nth-name-forward (n)
  (interactive "p")
  (save-excursion
    (let (name)
      (while (and (> n 0) (< (point) (point-max)))
        (let ((p (point)))
          (if (not (c-forward-name))
              (progn
                (c-forward-token-2)
                (when (= (point) p) (forward-char 1)))
            (setq name (buffer-substring-no-properties p (point)))
            (cl-decf n 1))))
      (when name
        (realgud:cmd-eval name)
        nil))))

;;;###autoload
(defun +my/realgud-eval-nth-name-backward (n)
  (interactive "p")
  (save-excursion
    (let (name)
      (while (and (> n 0) (> (point) (point-min)))
        (let ((p (point)))
          (c-backward-token-2)
          (when (= (point) p) (backward-char 1))
          (setq p (point))
          (when (c-forward-name)
            (setq name (buffer-substring-no-properties p (point)))
            (goto-char p)
            (cl-decf n 1))))
      (when name
        (realgud:cmd-eval name)
        nil))))

;;;###autoload
(defun +my/realgud-eval-region-or-word-at-point ()
  (interactive)
  (when-let*
      ((cmdbuf (realgud-get-cmdbuf))
       (process (get-buffer-process cmdbuf))
       (expr
        (if (evil-visual-state-p)
            (let ((range (evil-visual-range)))
              (buffer-substring-no-properties (evil-range-beginning range)
                                              (evil-range-end range)))
          (word-at-point)
          )))
    (with-current-buffer cmdbuf
	    (setq realgud:process-filter-save (process-filter process))
	    (set-process-filter process 'realgud:eval-process-output))
    (realgud:cmd-eval expr)
    ))

;;;###autoload
(defun +my//realtime-elisp-doc-function ()
  (-when-let* ((w (selected-window))
               (s (intern-soft (current-word))))
    (describe-symbol s)
    (select-window w)))

;;;###autoload
(defun +my/realtime-elisp-doc ()
  (interactive)
  (when (eq major-mode 'emacs-lisp-mode)
    (if (advice-function-member-p #'+my//realtime-elisp-doc-function eldoc-documentation-function)
        (remove-function (local 'eldoc-documentation-function) #'+my//realtime-elisp-doc-function)
      (add-function :after-while (local 'eldoc-documentation-function) #'+my//realtime-elisp-doc-function))))


;;;###autoload
(defun yas-git-commit-mode ()
  (yas-activate-extra-mode 'git-commit-mode))

;;;###autoload
(defun +my/find-definitions ()
  (interactive)
  (if lsp-mode (lsp-ui-peek-find-definitions) (call-interactively #'+lookup/definition)))

;;;###autoload
(defun +my/find-references (&optional extra)
  (interactive)
  (if lsp-mode (lsp-ui-peek-find-references nil extra) (call-interactively #'+lookup/references)))

;;;###autoload
(defun +my/better-font()
  (interactive)
  ;; english font
  (when (display-graphic-p)
    (progn
      (set-face-attribute 'default nil :font doom-font) ;; 11 13 17 19 23
      ;; chinese font
      (dolist (charset '(kana han cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font)
			  charset
			   doom-unicode-font))) ;; 14 16 20 22 28
    ))

;;;###autoload
(defun +my|init-font(&optional frame)
  (if frame
    (with-selected-frame frame
		       (when (display-graphic-p)
			 (+my/better-font)))
    (when (display-graphic-p)
      (+my/better-font))))

;;;###autoload
(defun +my|awesome-tab-hide-tab (x)
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
      (string-prefix-p "*Ilist*" name)
      (string-prefix-p " *transient*" name)

      (and (string-prefix-p "magit" name)
		(not (file-name-extension name)))
      )))
