;; -*- no-byte-compile: t; -*-
;;; packages.el

(package! symbol-overlay)
(package! color-rg :recipe (:fetcher github :repo "manateelazycat/color-rg"))
(package! company-english-helper :recipe (:fetcher github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:fetcher github :repo "manateelazycat/insert-translated-name"))
(package! edit-indirect)
(package! paradox)
(package! imenu-list)
(package! company-tabnine)


(disable-packages! doom-snippets)
