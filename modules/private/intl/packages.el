;; -*- no-byte-compile: t; -*-
;;; private/intl/packages.el

(package! fcitx)
(package! ace-pinyin)
(package! evil-find-char-pinyin)
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
(package! pinyinlib.el :recipe (:host github :repo "xlshiz/pinyinlib.el"))
(package! pangu-spacing)
(package! pyim :pin "1bd2b354d14860dceda54b02c080f42bf1db8c1c")
(when (featurep! +rime)
  (package! liberime
    :pin "8c84d5daa2fb1d73f7e71c3ae498bd528c2d280e"
    :recipe (:host github :repo "merrickluo/liberime" :files ("CMakeLists.txt" "Makefile" "src" "liberime*.el" "liberime.el"))))
