;; -*- no-byte-compile: t; -*-
;;; private/intl/packages.el

(package! fcitx)
(package! ace-pinyin)
(package! evil-find-char-pinyin)
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
(package! pangu-spacing)
(package! pyim)
(when (featurep! +rime)
  (package! liberime :recipe (:host gitlab :repo "liberime/liberime" :files ("CMakeLists.txt" "Makefile" "src" "liberime-config.el"))))
