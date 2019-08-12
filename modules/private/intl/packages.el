;; -*- no-byte-compile: t; -*-
;;; private/intl/packages.el

(package! fcitx)
(package! ace-pinyin)
(package! evil-find-char-pinyin)
(package! pangu-spacing)
(package! pyim)
(when (featurep! +rime)
  (package! liberime :recipe (:fetcher git :url "https://gitlab.com/liberime/liberime" :files ("CMakeLists.txt" "Makefile" "src" "liberime-config.el"))))
