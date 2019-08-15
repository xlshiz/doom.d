;; -*- no-byte-compile: t; -*-
;;; packages.el

(package! symbol-overlay)
(package! color-rg :recipe (:host github :repo "manateelazycat/color-rg"))
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
(package! edit-indirect)
(package! paradox)
(package! imenu-list)
(package! company-tabnine)


(disable-packages! doom-snippets)
