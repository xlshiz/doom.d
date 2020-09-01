;;; private/editor/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +avy-copy-thing-at-point ()
  "Copy thing at point."
  (interactive)
  (save-excursion
    (avy-goto-char-timer)
    (cl-case (read-char
               (format
                 "Copy thing at point (%s:word %s:symbol %s:sexp %s:line %s:parentheses %s:paragrap %s:number %s:defun %s:email %s:filename %s: list %s: url): "
                 (propertize "w" 'face 'error)
                 (propertize "s" 'face 'error)
                 (propertize "x" 'face 'error)
                 (propertize "l" 'face 'error)
                 (propertize "(" 'face 'error)
                 (propertize "{" 'face 'error)
                 (propertize "n" 'face 'error)
                 (propertize "d" 'face 'error)
                 (propertize "e" 'face 'error)
                 (propertize "f" 'face 'error)
                 (propertize "t" 'face 'error)
                 (propertize "u" 'face 'error)))
      (?w  (thing-copy-word nil))
      (?s  (thing-copy-symbol nil))
      (?x  (thing-copy-sexp nil))
      (?l  (thing-copy-line nil))
      (?(  (thing-copy-parentheses nil))
      (?{  (thing-copy-paragraph nil))
      (?n  (thing-copy-number nil))
      (?d  (thing-copy-defun nil))
      (?e  (thing-copy-email nil))
      (?f  (thing-copy-filename nil))
      (?t  (thing-copy-list nil))
      (?u  (thing-copy-url nil)))))

;;;###autoload
(defun +avy-cut-thing-at-point ()
  "Copy thing at point."
  (interactive)
  (save-excursion
    (avy-goto-char-timer)
    (cl-case (read-char
               (format
                 "Cut thing at point (%s:word %s:symbol %s:sexp %s:line %s:parentheses %s:paragrap %s:number %s:defun %s:email %s:filename %s: list %s: url): "
                 (propertize "w" 'face 'error)
                 (propertize "s" 'face 'error)
                 (propertize "x" 'face 'error)
                 (propertize "l" 'face 'error)
                 (propertize "(" 'face 'error)
                 (propertize "{" 'face 'error)
                 (propertize "n" 'face 'error)
                 (propertize "d" 'face 'error)
                 (propertize "e" 'face 'error)
                 (propertize "f" 'face 'error)
                 (propertize "t" 'face 'error)
                 (propertize "u" 'face 'error)))
      (?w  (thing-copy-word t))
      (?s  (thing-copy-symbol t))
      (?x  (thing-copy-sexp t))
      (?l  (thing-copy-line t))
      (?(  (thing-copy-parentheses t))
      (?{  (thing-copy-paragraph t))
      (?n  (thing-copy-number t))
      (?d  (thing-copy-defun t))
      (?e  (thing-copy-email t))
      (?f  (thing-copy-filename t))
      (?t  (thing-copy-list t))
      (?u  (thing-copy-url t)))))

;;;###autoload
(defun +avy-replace-thing-at-point ()
  "Copy thing at point."
  (interactive)
  (save-excursion
    (avy-goto-char-timer)
    (cl-case (read-char
               (format
                 "Replace thing at point (%s:word %s:symbol %s:sexp %s:line %s:parentheses %s:paragrap %s:number %s:defun %s:email %s:filename %s: list %s: url): "
                 (propertize "w" 'face 'error)
                 (propertize "s" 'face 'error)
                 (propertize "x" 'face 'error)
                 (propertize "l" 'face 'error)
                 (propertize "(" 'face 'error)
                 (propertize "{" 'face 'error)
                 (propertize "n" 'face 'error)
                 (propertize "d" 'face 'error)
                 (propertize "e" 'face 'error)
                 (propertize "f" 'face 'error)
                 (propertize "t" 'face 'error)
                 (propertize "u" 'face 'error)))
      (?w  (thing-replace-word))
      (?s  (thing-replace-symbol))
      (?x  (thing-replace-sexp))
      (?l  (thing-replace-line))
      (?(  (thing-replace-parentheses))
      (?{  (thing-replace-paragraph))
      (?n  (thing-replace-number))
      (?d  (thing-replace-defun))
      (?e  (thing-replace-email))
      (?f  (thing-replace-filename))
      (?t  (thing-replace-list))
      (?u  (thing-replace-url)))))

;;;###autoload
(defun +avy-yank-thing-at-point ()
  "Copy thing at point."
  (interactive)
  (save-excursion
    (avy-goto-char-timer)
    (cl-case (read-char
               (format
                 "Yank thing at point (%s:word %s:symbol %s:sexp %s:line %s:parentheses %s:paragrap %s:number %s:defun %s:email %s:filename %s: list %s: url): "
                 (propertize "w" 'face 'error)
                 (propertize "s" 'face 'error)
                 (propertize "x" 'face 'error)
                 (propertize "l" 'face 'error)
                 (propertize "(" 'face 'error)
                 (propertize "{" 'face 'error)
                 (propertize "n" 'face 'error)
                 (propertize "d" 'face 'error)
                 (propertize "e" 'face 'error)
                 (propertize "f" 'face 'error)
                 (propertize "t" 'face 'error)
                 (propertize "u" 'face 'error)))
      (?w  (thing-copy-word nil))
      (?s  (thing-copy-symbol nil))
      (?x  (thing-copy-sexp nil))
      (?l  (thing-copy-line nil))
      (?(  (thing-copy-parentheses nil))
      (?{  (thing-copy-paragraph nil))
      (?n  (thing-copy-number nil))
      (?d  (thing-copy-defun nil))
      (?e  (thing-copy-email nil))
      (?f  (thing-copy-filename nil))
      (?t  (thing-copy-list nil))
      (?u  (thing-copy-url nil)))))
