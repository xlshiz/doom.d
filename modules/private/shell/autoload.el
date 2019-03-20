;;; private/shell/autoload.el -*- lexical-binding: t; -*-

(defun multiterm (_)
  (interactive)
  (multi-term))

;;;###autoload
(defun shell/make-shell-pop-type (func)
  (let* ((name (symbol-name func))
         (*name (concat "*shell-pop" "*")))
    (if (string-equal name "multi-term")
        (shell-pop--set-shell-type
         'shell-pop-shell-type
         (backquote (,name ,*name (lambda nil (multiterm shell-pop-term-shell)))))
      (shell-pop--set-shell-type
       'shell-pop-shell-type
       (backquote (,name ,*name (lambda nil (,func shell-pop-term-shell))))))))
