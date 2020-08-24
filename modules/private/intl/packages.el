;; -*- no-byte-compile: t; -*-
;;; private/intl/packages.el

(package! pinyinlib.el :recipe (:host github :repo "xlshiz/pinyinlib.el"))
(package! ace-pinyin :recipe (:host github :repo "xlshiz/ace-pinyin"))
(package! evil-pinyin :recipe (:host github :repo "laishulu/evil-pinyin"))
(package! pyim :pin "aabf7965bc1fdc4cfe9ff2aa86b75f521dee6c42")
(when (featurep! +rime)
  (package! liberime :pin "2a6f1bca1aff64a9136368c4afa15c0ea1042893" :recipe (:host github :repo "merrickluo/liberime" :files ("CMakeLists.txt" "Makefile" "src" "liberime*.el" "liberime.el"))))
(package! fcitx)
(package! pangu-spacing)
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
