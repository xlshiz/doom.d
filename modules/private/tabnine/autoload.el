;;; private/tabnine/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +my|company-sort-by-tabnine (candidates)
  (if (or (functionp company-backend)
          (not (and (listp company-backend) (memq 'company-tabnine company-backend))))
      candidates
    (let ((candidates-table (make-hash-table :test #'equal))
          (candidates-N-count 0)
          candidates-other
          candidates-tabnine
          candidates-N
          candidates-N-merge
          candidates-tabnine-uni)
      (dolist (candidate candidates)
        (if (eq (get-text-property 0 'company-backend candidate)
                'company-tabnine)
            (if (> candidates-N-count 2)
                (push candidate candidates-tabnine)
              (push candidate candidates-N)
              (setq candidates-N-count (1+ candidates-N-count)))
          (push candidate candidates-other)
          (puthash candidate t candidates-table)))
      ;; (message "tabnine %s" candidates-tabnine)
      ;; (message "other %s" candidates-other)
      ;; (message "3 %s" candidates-N)
      (dolist (candidate candidates-N)
        (if (gethash candidate candidates-table)
            (let ((find-flag nil)
                  new-other)
              (dolist (elt (nreverse candidates-other))
                (if (not (and (eq find-flag nil) (string= candidate elt)))
                    (push elt new-other)
                  (push elt candidates-N-merge)
                  (setq find-flag t)))
              (setq candidates-other new-other))
          (push candidate candidates-N-merge)))
      (dolist (candidate candidates-tabnine)
        (unless (gethash candidate candidates-table)
          (push candidate candidates-tabnine-uni)))
      (setq candidates-other (nreverse candidates-other))
      ;; (message "3-merge %s" candidates-N-merge)
      ;; (message "other %s" candidates-other)
      ;; (message "tabnine-uni %s" candidates-tabnine-uni)
      (nconc candidates-N-merge
             candidates-other
             candidates-tabnine-uni))))

;;;###autoload
(defun +my|add-tabnine-backend ()
  (require 'company-tabnine)
  (add-to-list 'company-transformers '+my|company-sort-by-tabnine t)
  (setq-local company-idle-delay 0.2)
  (if (listp (car company-backends))
      (let ((company-car (car company-backends)))
        (setq-local company-backends `(,(append company-car '(:with company-tabnine :separate)) ,@(cdr company-backends))))
    (setq-local company-backends `((,(car company-backends) :with company-tabnine :separate) ,@(cdr company-backends)))))

;;;###autoload
(defun +my/enable-tabnine ()
  "Enable tabnine."
  (interactive)
  (if (bound-and-true-p lsp-mode)
      (defadvice +lsp-init-company-backends-h (after tabnine-init-company activate)
        (+my|add-tabnine-backend))
    (add-hook! company-mode :append #'+my|add-tabnine-backend))
  (+my|add-tabnine-backend))
