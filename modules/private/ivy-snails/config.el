;;; private/ivy-snails/config.el -*- lexical-binding: t; -*-

(after! ivy-rich
  (setq ivy-rich-display-transformers-list
        (plist-put ivy-rich-display-transformers-list
                   'ivy-snails
                   '(:columns
                     ((+ivy-rich-buffer-icon)
		      (ivy-rich-candidate (:width 0.7))
                      (+ivy-snails-rich (:width 0.2 :face success))))))
  )
