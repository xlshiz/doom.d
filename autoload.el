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
      (string-prefix-p "*helpful " name)

      (and (string-prefix-p "magit" name)
		(not (file-name-extension name)))
      )))

;;;###autoload
(defun +my/default-search-project (&optional arg symbol)
  "Conduct a text search in the current project for symbol at point.
If prefix ARG is set, prompt for a known project to search from."
  (interactive
   (list current-prefix-arg
         (replace-regexp-in-string
          "\n" ""
          (replace-regexp-in-string
           "\\\\_<" ""
           (replace-regexp-in-string
            "\\\\_>" ""
            (car evil-ex-search-history))))))
  (let ((default-directory
          (if arg
              (if-let* ((projects (projectile-relevant-known-projects)))
                  (completing-read "Switch to project: " projects
                                   nil t nil nil (doom-project-root))
                (user-error "There are no known projects"))
            default-directory)))
    (cond ((featurep! :completion ivy)
           (+ivy/project-search nil (rxt-quote-pcre symbol)))
          ((featurep! :completion helm)
           (+helm/project-search nil (rxt-quote-pcre symbol)))
          ((rgrep (regexp-quote symbol))))))

;;;###autoload
(defun +my/swiper-to-color-rg ()
  (interactive)
  (let ((search-text
         (replace-regexp-in-string
          "\n" ""
          (replace-regexp-in-string
           "\\\\_<" ""
           (replace-regexp-in-string
            "\\\\_>" ""
            (replace-regexp-in-string "^.*Swiper: " "" (thing-at-point 'line)))))))
    (ivy-quit-and-run (color-rg-search-input search-text (expand-file-name (buffer-file-name))))))

;;;###autoload
(defun +my/counsel-to-color-rg ()
  (interactive)
  (let ((search-text
         (replace-regexp-in-string
          "\n" ""
          (replace-regexp-in-string "^.*rg ./" "" (thing-at-point 'line)))))
    (ivy-quit-and-run (color-rg-search-input search-text default-directory))))
