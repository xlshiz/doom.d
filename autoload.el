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

;;;###autoload
(defun +my|company-sort-by-tabnine (candidates)
  (if (or (functionp company-backend)
          (not (and (listp company-backend) (memq 'company-tabnine company-backend))))
      candidates
    (let ((candidates-table (make-hash-table :test #'equal))
          candidates-1
          candidates-2)
      (dolist (candidate candidates)
        (if (eq (get-text-property 0 'company-backend candidate)
                'company-tabnine)
            (unless (gethash candidate candidates-table)
              (push candidate candidates-2))
          (push candidate candidates-1)
          (puthash candidate t candidates-table)))
      (setq candidates-1 (nreverse candidates-1))
      (setq candidates-2 (nreverse candidates-2))
      (nconc (seq-take candidates-1 2)
             (seq-take candidates-2 2)
             (seq-drop candidates-1 2)
             (seq-drop candidates-2 2)))))

;;;###autoload
(defun +my/enable-tabnine ()
  "Enable tabnine."
  (interactive)
  (require 'company-tabnine)
  (add-to-list 'company-transformers '+my|company-sort-by-tabnine t)
  (setq company-idle-delay 0.2)
  (if (listp (car company-backends))
      (setq-local company-backends `((,(car (car company-backends)) company-tabnine :separate) ,@(cdr company-backends)))
    (setq-local company-backends `((,(car company-backends) company-tabnine :separate) ,@(cdr company-backends)))
    ))
