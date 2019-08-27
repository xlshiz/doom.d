;;; private/ivy-snails/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun ivy-snails--project-files (&rest _)
  (require 'projectile)
  (mapc (lambda (x)
          (put-text-property 0 (length x)
                             'snails-type 'project x)
          x)
        (mapcar #'substring-no-properties (projectile-current-project-files))))

;;;###autoload
(defun ivy-snails--buffer-list (&rest _)
  (mapc (lambda (x)
          (put-text-property 0 (length x)
                             'snails-type 'buffer x)
          x)
        (mapcar #'substring-no-properties (ivy--buffer-list ""))))

;;;###autoload
(defun ivy-snails--recentf-list (&rest _)
  (require 'recentf)
  (recentf-mode 1)
  (mapc (lambda (x)
          (put-text-property 0 (length x)
                             'snails-type 'recent x)
          x)
        (mapcar #'substring-no-properties recentf-list)))

;;;###autoload
(defun ivy-snails-make-collection ()
  "Mix the `recentf' and current directory's files"
  (let* ((snails-files (ivy-snails--project-files))
         (snails-buffers (ivy-snails--buffer-list))
         (snails-recent (ivy-snails--recentf-list))
         (root (projectile-project-root))
         file)
    (append snails-buffers snails-files snails-recent)))

;; (defun ivy-snails-make-collection ()
;;   "Mix the `recentf' and current directory's files"
;;   (let* ((snails-files (ivy-snails--project-files))
;;          (snails-buffers (ivy-snails--buffer-list))
;;          (snails-recent (ivy-snails--recentf-list))
;;          (root (projectile-project-root))
;;          file)
;;     (dolist (snails-filter snails-buffers)
;;       (when (setq file (buffer-file-name (get-buffer snails-filter)))
;;         (setq snails-files (remove (file-relative-name file root) snails-files))
;;         (setq snails-recent (remove (file-relative-name file root) snails-recent))))
;;     (dolist (snails-filter snails-files)
;;       (setq snails-recent (remove (projectile-expand-root snails-filter) snails-recent)))
;;     (append snails-buffers snails-files snails-recent)))

;;;###autoload
(defun ivy-snails-action (name)
  "Mix action"
  (let ((snails-type (get-text-property 0 'snails-type name)))
    (cond ((eq snails-type 'recent)
           (find-file name))
          ((eq snails-type 'buffer)
           (switch-to-buffer name nil 'force-same-window))
          ((eq snails-type 'project)
           (find-file (projectile-expand-root name)))
          (t (message "nnnnnnn %s" snails-type)))))

;;;###autoload
(defun ivy-snails ()
  "Mix the `recentf' and `file`"
  (interactive)
  (ivy-read "Mix: "
            (ivy-snails-make-collection)
            :require-match t
            :action #'ivy-snails-action
            :caller 'ivy-snails))

;;;###autoload
(defun +ivy-snails-rich (candidate)
  "Mix the `recentf' and `file`"
  (let ((snails-type (get-text-property 0 'snails-type candidate)))
    (if (eq snails-type 'buffer)
        (if (string= (ivy-rich-switch-buffer-project candidate) "")
            (format "%s" "B ")
          (format "%s[%s]" "B " (ivy-rich-switch-buffer-project candidate))
          )
      "")))
