;; -*- no-byte-compile: t; -*-
;;; private/intl/packages.el

(package! fcitx)
(package! ace-pinyin)
(package! evil-find-char-pinyin)
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
(package! pinyinlib.el :recipe (:host github :repo "xlshiz/pinyinlib.el"))
(package! pangu-spacing)
(package! pyim :pin "eb8c346731")
(when (featurep! +rime)
  (package! liberime :pin "e081f4bfaf" :recipe (:host github :repo "merrickluo/liberime" :files ("CMakeLists.txt" "Makefile" "src" "liberime*.el" "liberime.el"))))
