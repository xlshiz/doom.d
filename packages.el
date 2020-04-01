;; -*- no-byte-compile: t; -*-
;;; packages.el

(package! edit-indirect)
(package! paradox)
(package! imenu-list)
(package! nox :recipe (:host github :repo "manateelazycat/nox") :pin "6e6e799d39")

(disable-packages! doom-snippets)
