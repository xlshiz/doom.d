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
(defun +my/projectile-shell-pop ()
  "Open a term buffer at projectile project root."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (call-interactively '+term/here)))

;;;###autoload
(defun +my|realtime-elisp-doc-function ()
  (-when-let* ((w (selected-window))
               (s (intern-soft (current-word))))
    (describe-symbol s)
    (select-window w)))

;;;###autoload
(defun +my/realtime-elisp-doc ()
  (interactive)
  (when (eq major-mode 'emacs-lisp-mode)
    (if (advice-function-member-p #'+my|realtime-elisp-doc-function eldoc-documentation-function)
        (remove-function (local 'eldoc-documentation-function) #'+my|realtime-elisp-doc-function)
      (add-function :after-while (local 'eldoc-documentation-function) #'+my|realtime-elisp-doc-function))))


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
(defun +org-change-appearance-h ()
  (set-pretty-symbols! 'org-mode
    :alist
    '(("[ ]" . ?☐)
      ("[X]" . ?☑)
      ("#+BEGIN_SRC" . ?✎)
      ("#+END_SRC" . ?✐)
      ("#+BEGIN_QUOTE" . ?»)
      ("#+END_QUOTE" . ?«)))
  (setq org-refile-targets '((org-default-notes-file . (:level . 1))
                             (org-default-refile-file . (:level . 1))))
  (setq org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)")
                            (sequence "⚑(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
        org-todo-keyword-faces '(("HANGUP" . warning)
                                 ("❓" . warning))))

;;;###autoload
(defun +org-change-keybinds-h ()
  (map! :map org-mode-map
	:localleader
        "T"             #'org-show-todo-tree))
