;;; autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +my/proxy()
  (interactive)
  ;; english font
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
          ("http" . "127.0.0.1:8118")
          ("https" . "127.0.0.1:8118"))))

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
(defun yas-git-commit-mode ()
  (yas-activate-extra-mode 'git-commit-mode))

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
(defun +my/smarter-yas-expand-next-field-complete ()
  "Try to `yas-expand' and `yas-next-field' at current cursor position.
If failed try to complete the common part with `company-complete-common'"
  (interactive)
  (if yas-minor-mode
      (let ((old-point (point))
            (old-tick (buffer-chars-modified-tick)))
        (yas-expand)
        (when (and (eq old-point (point))
                   (eq old-tick (buffer-chars-modified-tick)))
          (ignore-errors (yas-next-field))
          (when (and (eq old-point (point))
                     (eq old-tick (buffer-chars-modified-tick)))
            (company-complete-common))))
    (company-complete-common)))

;;;###autoload
(defun +my/return-cancel-completion ()
  "Cancel completion and return."
  (interactive)
  (company-abort)
  (newline nil t))
