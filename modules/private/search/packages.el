;; -*- no-byte-compile: t; -*-
;;; private/search/packages.el

(package! symbol-overlay)
(package! color-rg :recipe (:host github :repo "manateelazycat/color-rg" :build (autoloads)))
(when (featurep! +snails)
  (package! fuz.el :recipe (:host github :repo "cireu/fuz.el" ))
  (package! snails :recipe (:host github :repo "xlshiz/snails" :files ("*.el" "*.sh") :build (autoloads))))
