;;; ui/tabbar/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +tabbar-buffer-predicate (buffer)
  "TODO"
  (or (memq buffer (window-parameter nil 'tabbar-buffers))
      (eq buffer (doom-fallback-buffer))))

;;;###autoload
(defun +tabbar-window-buffer-list ()
  (cl-delete-if-not #'buffer-live-p (window-parameter nil 'tabbar-buffers)))

;;;###autoload
(defun +tabbar-buffer-groups ()
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

;;;###autoload
(defun +tabbar-hide-tab (x)
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

      (and (string-prefix-p "magit" name)
		(not (file-name-extension name)))
      )))



;;
;;; Commands

;;;###autoload
(defun +tabbar/close-tab-or-window ()
  "TODO"
  (interactive)
  (call-interactively
   (cond ((cdr (window-parameter nil 'tabbar-buffers))
          #'kill-current-buffer)
         ((fboundp '+workspace/close-window-or-workspace)
          #'+workspace/close-window-or-workspace)
         (#'delete-window))))


;;
;;; Advice

;;;###autoload
(defun +tabbar-kill-current-buffer-a (&rest _)
  (+tabbar|remove-buffer))

;;;###autoload
(defun +tabbar-bury-buffer-a (orig-fn &rest args)
  (if awesome-tab-mode
      (let ((b (current-buffer)))
        (apply orig-fn args)
        (unless (eq b (current-buffer))
          (with-current-buffer b
            (+tabbar|remove-buffer))))
    (apply orig-fn args)))

;;;###autoload
(defun +tabbar-kill-tab-maybe-a (tab)
  (let ((buffer (awesome-tab-tab-value tab)))
    (with-current-buffer buffer
      ;; `kill-current-buffer' is advised not to kill buffers visible in another
      ;; window, so it behaves better than `kill-buffer'.
      (kill-current-buffer))
    (awesome-tab-display-update)))


;;
;;; Hooks

;;;###autoload
(defun +tabbar-add-buffer-h ()
  (when (and awesome-tab-mode
             (doom-real-buffer-p (current-buffer)))
    (let* ((this-buf (current-buffer))
           (buffers (window-parameter nil 'tabbar-buffers)))
      (cl-pushnew this-buf buffers)
      (add-hook 'kill-buffer-hook #'+tabbar|remove-buffer nil t)
      (set-window-parameter nil 'tabbar-buffers buffers))))

;;;###autoload
(defun +tabbar|remove-buffer ()
  (when awesome-tab-mode
    (set-window-parameter
     nil
     'tabbar-buffers (delete (current-buffer) (window-parameter nil 'tabbar-buffers)))))

;;;###autoload
(defun +tabbar-new-window-h ()
  (when awesome-tab-mode
    (unless (window-parameter nil 'tabbar-buffers)
      (+tabbar-add-buffer-h))))

;;;###autoload
(defun +tabbar/select-window ()
  (interactive)
  (let* ((event last-input-event)
         (key (make-vector 1 event))
         (key-desc (key-description key)))
    (awesome-tab-select-visible-nth-tab
     (string-to-number (car (nreverse (split-string key-desc "-")))))))
