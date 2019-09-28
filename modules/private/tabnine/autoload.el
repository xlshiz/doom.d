;;; private/tabnine/autoload.el -*- lexical-binding: t; -*-

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
      (nconc (seq-take candidates-2 3)
             candidates-1
             (seq-drop candidates-2 3)))))

;;;###autoload
(defun +my|add-tabnine-backend ()
  (require 'company-tabnine)
  (add-to-list 'company-transformers '+my|company-sort-by-tabnine t)
  (setq company-idle-delay 0.2)
  (if (listp (car company-backends))
      (let ((company-car (car company-backends)))
        (setq-local company-backends `(,(append company-car '(:with company-tabnine :separate)) ,@(cdr company-backends))))
    (setq-local company-backends `((,(car company-backends) :with company-tabnine :separate) ,@(cdr company-backends)))))

;;;###autoload
(defun +my/enable-tabnine ()
  "Enable tabnine."
  (interactive)
  (if (bound-and-true-p lsp-mode)
      (defadvice +lsp-init-company-h (after tabnine-init-company activate)
        (+my|add-tabnine-backend))
    (add-hook! company-mode :append #'+my|add-tabnine-backend))
  (+my|add-tabnine-backend))
