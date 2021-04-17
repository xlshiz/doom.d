;;; private/intl/config.el -*- lexical-binding: t; -*-

(use-package! sis
  :after evil
  :init
  (setq sis-prefix-override-keys (list doom-leader-alt-key "C-c" "C-x" "C-h"))
  :config
  ;; For Linux
  ;; (sis-ism-lazyman-config "1" "2" 'fcitx)
  (sis-ism-lazyman-config nil "pyim" 'native)
  ;; enable the /cursor color/ mode
  (setq sis-other-cursor-color "red"
        sis-default-cursor-color "#5d86b6")
  (sis-global-cursor-color-mode t)
  ;; enable the /respect/ mode
  (sis-global-respect-mode t)
  ;; enable the /follow context/ mode for all buffers
  (sis-global-context-mode t)
  ;; enable the /inline english/ mode for all buffers
  (sis-global-inline-mode t))

(use-package! pinyinlib
  :commands (pinyinlib-build-regexp-string pinyinlib-build-regexp-char)
  :init
  (setq pinyinlib--simplified-char-table 'pinyinlib--simplified-xiaohe)
  )

(use-package! ace-pinyin
  :defer 1
  :config
  (progn
    (setq ace-pinyin-use-avy t)
    (ace-pinyin-global-mode t))
  )

(use-package! evil-pinyin
  :defer 1
  :init
  (setq evil-pinyin-scheme 'simplified-xiaohe-all)
  (setq evil-pinyin-with-search-rule 'custom)
  (setq evil-pinyin-start-pattern "!")
  :config
  (global-evil-pinyin-mode))

(use-package! company-english-helper
  :commands (toggle-company-english-helper company-english-helper-search))

(use-package! insert-translated-name
  :commands (insert-translated-name-insert insert-translated-name-insert-with-underline
                                           insert-translated-name-insert-with-line insert-translated-name-insert-with-camel))

(use-package! pangu-spacing
  :defer t
  :config (progn (global-pangu-spacing-mode 1))
  )

(use-package! pyim
  :defer t
  :commands (pyim-forward-word pyim-backward-word)
  :init
  (setq default-input-method "pyim")
  :config
  ;; 使用小鹤双拼
  (setq pyim-default-scheme 'xiaohe-shuangpin)
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))
  ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)
  ;; 选词框显示5个候选词
  (setq pyim-page-length 3)
  (setq pyim-dicts
        `((:name "be" :file ,(concat doom-etc-dir "pyim/be.pyim"))))
  (setq pyim-dcache-directory (concat doom-cache-dir "pyim/dcache/"))
  ;; 设置以词定字的函数，使用 [  ]
  (setq pyim-magic-converter #'+my|pyim-converter)
  ;; 绑定 pyim 输入时的快捷键，esc删除输入，.下一页，,上一页
  (map! :map pyim-mode-map
        [escape] #'pyim-quit-clear
        "."      #'pyim-page-next-page
        ","      #'pyim-page-previous-page
        ";"     (lambda ()
                  (interactive)
                  (pyim-page-select-word-by-number 2))
        "'"     (lambda ()
                  (interactive)
                  (pyim-page-select-word-by-number 3))
        )
  )

(use-package! liberime
  :when (featurep! +rime)
  :after pyim
  :init
  (setq liberime-user-data-dir (expand-file-name (concat doom-etc-dir "pyim/rime")))
  (setq liberime-auto-build t)
  :config
  (liberime-select-schema "pinyin_cau_flypy")
  (setq pyim-default-scheme 'rime))

(after! ivy
  (setq ivy-re-builders-alist
        '(
          (t . +intel/re-builder-pinyin)
          ))
  )

(after! org
  (defadvice org-html-paragraph (before org-html-paragraph-advice
                                        (paragraph contents info) activate)
    "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
    (let* ((origin-contents (ad-get-arg 1))
           (fix-regexp "[[:multibyte:]]")
           (fixed-contents
            (replace-regexp-in-string
             (concat
              "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
      (ad-set-arg 1 fixed-contents)))
  ;; 让中文也可以不加空格就使用行内格式
  (setcar (nthcdr 0 org-emphasis-regexp-components) " \t('\"{[:nonascii:]")
  (setcar (nthcdr 1 org-emphasis-regexp-components) "- \t.,:!?;'\")}\\[[:nonascii:]")
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (org-element-update-syntax)
  ;; 规定上下标必须加 {}，否则中文使用下划线时它会以为是两个连着的下标
  (setq org-use-sub-superscripts "{}"))
