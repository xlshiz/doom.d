;; -*- no-byte-compile: t; -*-
;;; private/intl/packages.el

(package! fcitx)
(package! ace-pinyin)
(package! evil-find-char-pinyin)
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
(package! pinyinlib.el :recipe (:host github :repo "xlshiz/pinyinlib.el"))
(package! pangu-spacing)
(package! pyim :pin "a0a4312d715a462922d88737d2dfbcdd8939620f")
(when (featurep! +rime)
  (package! liberime
    :pin "8c84d5daa2fb1d73f7e71c3ae498bd528c2d280e"
    :recipe (:host github :repo "merrickluo/liberime" :files ("CMakeLists.txt" "Makefile" "src" "liberime*.el" "liberime.el"))))
