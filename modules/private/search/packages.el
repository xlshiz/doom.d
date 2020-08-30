;; -*- no-byte-compile: t; -*-
;;; private/search/packages.el

(package! symbol-overlay)
(package! color-rg :recipe (:host github :repo "manateelazycat/color-rg" :no-byte-compile t))
(when (featurep! +snails)
  (package! snails :recipe (:host github :repo "xlshiz/snails" :files ("*.el" "*.sh") :no-byte-compile t)))
