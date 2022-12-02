;; -*- no-byte-compile: t; -*-
;;; tools/eaf/packages.el

(package! eaf
  :recipe (:local-repo "~/.doom.d/eaf"
           :files (:defaults "*")
           :build (:not compile)))
