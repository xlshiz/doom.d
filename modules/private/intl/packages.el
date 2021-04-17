;; -*- no-byte-compile: t; -*-
;;; private/intl/packages.el

(package! pinyinlib.el :recipe (:host github :repo "xlshiz/pinyinlib.el"))
(package! ace-pinyin :recipe (:host github :repo "xlshiz/ace-pinyin"))
(package! evil-pinyin :recipe (:host github :repo "laishulu/evil-pinyin"))
(package! pyim :pin "1344bc16f2b5ff38655b94f5678c7e5f0cd09de0")
(when (featurep! +rime)
  (package! liberime :pin "8d4d1d4f2924dc560bce1d79680df36dcc086d49" :recipe (:host github :repo "merrickluo/liberime" :files ("CMakeLists.txt" "Makefile" "src" "liberime*.el" "liberime.el"))))
(package! pangu-spacing)
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
(package! sis :recipe (:host github :repo "laishulu/emacs-smart-input-source"))
