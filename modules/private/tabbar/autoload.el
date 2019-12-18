;;; private/tabs/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +tabs-buffer-predicate (buffer)
  "TODO"
  (or (memq buffer (window-parameter nil 'tab-buffers))
      (eq buffer (doom-fallback-buffer))))

;;;###autoload
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

      (and (string-prefix-p "magit" name)
		(not (file-name-extension name)))
      )))



;;
;;; Commands

;;;###autoload
(defun +tabs/close-tab-or-window ()
  "TODO"
  (interactive)
  (call-interactively
   (cond ((cdr (window-parameter nil 'tab-buffers))
          #'kill-current-buffer)
         ((fboundp '+workspace/close-window-or-workspace)
          #'+workspace/close-window-or-workspace)
         (#'delete-window))))


;;
;;; Advice

;;;###autoload
(defun +tabs-kill-current-buffer-a (&rest _)
  (+tabs-remove-buffer-h))

;;;###autoload
(defun +tabs-bury-buffer-a (orig-fn &rest args)
  (if awesome-tab-mode
      (let ((b (current-buffer)))
        (apply orig-fn args)
        (unless (eq b (current-buffer))
          (with-current-buffer b
            (+tabs-remove-buffer-h))))
    (apply orig-fn args)))

;;;###autoload
(defun +tabs-kill-tab-maybe-a (tab)
  (let ((buffer (awesome-tab-tab-value tab)))
    (with-current-buffer buffer
      ;; `kill-current-buffer' is advised not to kill buffers visible in another
      ;; window, so it behaves better than `kill-buffer'.
      (kill-current-buffer))
    (awesome-tab-display-update)))


;;
;;; Hooks

;;;###autoload
(defun +tabs-add-buffer-h ()
  (when (and awesome-tab-mode
             (doom-real-buffer-p (current-buffer)))
    (let* ((this-buf (current-buffer))
           (buffers (window-parameter nil 'tab-buffers)))
      (cl-pushnew this-buf buffers)
      (add-hook 'kill-buffer-hook #'+tabs-remove-buffer-h nil t)
      (set-window-parameter nil 'tab-buffers buffers))))

;;;###autoload
(defun +tabs-remove-buffer-h ()
  (when awesome-tab-mode
    (set-window-parameter
     nil
     'tab-buffers (delete (current-buffer) (window-parameter nil 'tab-buffers)))))

;;;###autoload
(defun +tabs-new-window-h ()
  (when awesome-tab-mode
    (unless (window-parameter nil 'tab-buffers)
      (+tabs-add-buffer-h))))

;;;###autoload
(defun +tabs/select-window ()
  (interactive)
  (let* ((event last-input-event)
         (key (make-vector 1 event))
         (key-desc (key-description key)))
    (awesome-tab-select-visible-nth-tab
     (string-to-number (car (nreverse (split-string key-desc "-")))))))
