;;; private/search/autoload/color-rg.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +my/color-rg-jump-next-keyword ()
  (interactive)
  (let* ((next-position (color-rg-find-next-position color-rg-regexp-position)))
    (if next-position
        (progn
          (goto-char next-position)
          (beginning-of-line)
          (forward-char (+ 1 (color-rg-get-match-column))))
      (message "Reach to last line."))))

;;;###autoload
(defun +my/color-rg-jump-prev-keyword ()
  (interactive)
  (let ((prev-match-pos
         (if (save-excursion (search-backward-regexp color-rg-regexp-position nil t))
             (let* ((first-search-line
                     (save-excursion
                       (search-backward-regexp color-rg-regexp-position nil t)
                       (line-number-at-pos))))
               (if (equal first-search-line (line-number-at-pos))
                   ;; Search previous again if first search is same line of point.
                   (save-excursion
                     (beginning-of-line)
                     (search-backward-regexp color-rg-regexp-position nil t))
                 (save-excursion (search-backward-regexp color-rg-regexp-position nil t)))
               )
           nil)))
    (if prev-match-pos
        (progn
          (goto-char prev-match-pos)
          (forward-char (+ 1 (color-rg-get-match-column))))
      (message "Reach to first line."))))

;;;###autoload
(defun evil-collection-color-rg-setup ()
  "Set up `evil' bindings for `color-rg'."
  (evil-collection-define-key 'normal 'color-rg-mode-map
    (kbd "M-o") 'color-rg-hydra/body
    (kbd "RET") 'color-rg-open-file
    "j" 'evil-next-line
    "k" 'evil-previous-line
    "h" 'evil-backward-char
    "l" 'evil-forward-char

    "n" '+my/color-rg-jump-next-keyword
    "p" '+my/color-rg-jump-prev-keyword
    "N" 'color-rg-jump-next-keyword
    "P" 'color-rg-jump-prev-keyword
    "H" 'color-rg-jump-next-file
    "L" 'color-rg-jump-prev-file

    "r" 'color-rg-replace-all-matches
    "f" 'color-rg-filter-match-results
    "F" 'color-rg-filter-mismatch-results

    "x" 'color-rg-filter-match-files
    "X" 'color-rg-filter-mismatch-files
    "u" 'color-rg-unfilter

    "D" 'color-rg-remove-line-from-results

    "I" 'color-rg-rerun-toggle-ignore
    "t" 'color-rg-rerun-literal
    "c" 'color-rg-rerun-toggle-case
    "s" 'color-rg-rerun-regexp
    "d" 'color-rg-rerun-change-dir
    "z" 'color-rg-rerun-change-globs
    "Z" 'color-rg-rerun-change-exclude-files
    "C" 'color-rg-customized-search

    "i" 'color-rg-switch-to-edit-mode
    "q" 'color-rg-quit)

  (evil-collection-define-key 'normal 'color-rg-mode-edit-map
    "j" 'evil-next-line
    "k" 'evil-previous-line
    "h" 'evil-backward-char
    "l" 'evil-forward-char

    "n" 'color-rg-jump-next-keyword
    "p" 'color-rg-jump-prev-keyword
    "N" 'color-rg-jump-next-file
    "P" 'color-rg-jump-prev-file)

  (evil-collection-define-key nil 'color-rg-mode-edit-map
    [remap evil-write] 'color-rg-apply-changed
    [remap evil-quit] 'color-rg-quit)

  (evil-set-initial-state 'color-rg-mode 'normal))
