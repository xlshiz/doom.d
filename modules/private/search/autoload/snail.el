;;; private/search/autoload/snail.el -*- lexical-binding: t; -*-

;;;###autoload
(defun snail--project-files (&rest _)
  (require 'projectile)
  (unless (file-equal-p default-directory "~")
    (mapc (lambda (x)
            (put-text-property 0 (length x)
                               'snail-type 'project x))
          (mapcar #'substring-no-properties (if (doom-project-root)
                                                (projectile-current-project-files)
                                              (counsel--find-return-list counsel-file-jump-args))))))

;;;###autoload
(defun snail--buffer-list (&rest _)
  (let ((filter-func
         (if (featurep! :ui workspaces)
             #'+workspace-contains-buffer-p
           (lambda (x) (not (string= (substring x 0 1) "*"))))))
    (mapc (lambda (x)
            (put-text-property 0 (length x)
                               'snail-type 'buffer x))
          (mapcar #'substring-no-properties
                  (cl-remove-if-not filter-func (ivy--buffer-list ""))))))

;;;###autoload
(defun snail--recentf-list (&rest _)
  (require 'recentf)
  (recentf-mode 1)
  (mapc (lambda (x)
          (put-text-property 0 (length x)
                             'snail-type 'recent x))
        (mapcar #'substring-no-properties recentf-list)))

;;;###autoload
(defun snail-make-collection ()
  (let* ((snail-files (snail--project-files))
         (snail-buffers (snail--buffer-list))
         (snail-recent (snail--recentf-list)))
    (append snail-buffers snail-files snail-recent)))

;;;###autoload
(defun snail-action (name)
  (let ((snail-type (get-text-property 0 'snail-type name)))
    (cond ((eq snail-type 'recent)
           (find-file name))
          ((eq snail-type 'buffer)
           (switch-to-buffer name nil 'force-same-window))
          ((eq snail-type 'project)
           (find-file (projectile-expand-root name)))
          (t (message "snail type error %s" snail-type)))))

;;;###autoload
(defun snail-type-filter (type candidates)
  (if (equal type nil)
      candidates
    (ignore-errors
      (setq candidates
            (cl-remove-if-not
             (lambda (x) (eq (get-text-property 0 'snail-type x) type))
             candidates))
      candidates)))

;;;###autoload
(defun snail-matcher (regexp candidates)
  "snail matcher. ? for recentf, > for projectifle, # for buffer"
  (let (real-regexp
        snail-type)
    (cond ((= (length regexp) 0)
           (setq real-regexp regexp
                 snail-type nil))
          ((equal (substring regexp 0 1) "#")
           (setq real-regexp (substring regexp 1)
                 snail-type 'buffer))
          ((and (> (length regexp) 8) (equal (substring regexp 0 8) "\\(#\\).*?"))
           (setq real-regexp (substring regexp 8)
                 snail-type 'buffer))
          ((equal (substring regexp 0 1) ">")
           (setq real-regexp (substring regexp 1)
                 snail-type 'project))
          ((and (> (length regexp) 8) (equal (substring regexp 0 8) "\\(>\\).*?"))
           (setq real-regexp (substring regexp 8)
                 snail-type 'project))
          ((equal (substring regexp 0 1) "?")
           (setq real-regexp (substring regexp 1)
                 snail-type 'recent))
          ((and (> (length regexp) 8) (equal (substring regexp 0 8) "\\(?\\).*?"))
           (setq real-regexp (substring regexp 8)
                 snail-type 'recent))
          ((and (> (length regexp) 2) (string-match "\\\\[#?>]" (substring regexp 0 2)))
           (setq real-regexp (substring regexp 1)
                 snail-type nil))
          (t (setq real-regexp regexp
                   snail-type nil)))
    (ivy--re-filter real-regexp (snail-type-filter snail-type candidates))))

;;;###autoload
(defun snail ()
  "Mix the `buffer' `projectile' and `recentf'"
  (interactive)
  (ivy-read "snail: "
            (snail-make-collection)
            :require-match t
            :matcher #'snail-matcher
            :action #'snail-action
            :caller 'snail))

;;;###autoload
(defun +snail-colorfull-candidate (var)
  "Propertize VAR if it's a buffer visiting a file."
  (let ((snail-type (get-text-property 0 'snail-type var)))
    (cond ((eq snail-type 'buffer)
           (ivy-append-face var '+snail-buffer-face))
          ((eq snail-type 'project)
           (ivy-append-face var '+snail-project-face))
          ((eq snail-type 'recent)
           (ivy-append-face var '+snail-recent-face)))))

;;;###autoload
(defun +snail-rich-buffer-tag (candidate)
  "Mix the `recentf' and `file`"
  (let ((snail-type (get-text-property 0 'snail-type candidate)))
    (cond ((eq snail-type 'buffer)
           "#")
          ((eq snail-type 'project)
           ">")
          ((eq snail-type 'recent)
           "?"))))
