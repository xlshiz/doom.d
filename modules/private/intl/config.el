;;; private/intl/config.el -*- lexical-binding: t; -*-

(use-package! fcitx
  :config (fcitx-evil-turn-on)
)

(use-package! pinyinlib
  :init
  (setq pinyinlib--simplified-char-table 'pinyinlib--simplified-xiaohe)
)

(use-package! ace-pinyin
  :config
  (progn
    (setq ace-pinyin-use-avy t)
    (ace-pinyin-global-mode t))
)

(use-package! evil-find-char-pinyin
  :config
  (evil-find-char-pinyin-mode +1)
  (evil-find-char-pinyin-toggle-snipe-integration t)
)

(use-package! company-english-helper
  :commands (toggle-company-english-helper company-english-helper-search))

(use-package! insert-translated-name
  :commands (insert-translated-name-insert insert-translated-name-insert-with-underline
                                           insert-translated-name-insert-with-line insert-translated-name-insert-with-camel))

(use-package! pangu-spacing
  :config (progn (global-pangu-spacing-mode 1))
)

(use-package! pyim
  :defer t
  :commands (pyim-forward-word pyim-backward-word)
  :config
  (setq default-input-method "pyim")
  ;; 使用小鹤双拼
  (setq pyim-default-scheme 'xiaohe-shuangpin)
  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-evil-normal-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))
  ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)
  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)
  (setq pyim-dicts
	`((:name "be" :file ,(concat doom-etc-dir "pyim/be.pyim"))))
  (setq pyim-dcache-directory (concat doom-cache-dir "pyim/dcache/"))
  ;; 设置以词定字的函数，使用 [  ]
  (setq pyim-magic-converter #'+my|pyim-converter)
  ;; 绑定 pyim 输入时的快捷键，esc删除输入，.下一页，,上一页
  (map! :map pyim-mode-map
   	[escape] #'pyim-quit-clear
	"."      #'pyim-page-next-page
	","      #'pyim-page-previous-page)
)

(use-package! liberime-config
  :when (featurep! +rime)
  :after pyim
  :init
  (setq liberime-user-data-dir (expand-file-name (concat doom-etc-dir "pyim/rime")))
  :config
  (liberime-select-schema "double_pinyin_flypy")
  (setq pyim-default-scheme 'rime))

(after! ivy
  (setq ivy-re-builders-alist
        '(
          (t . +intel/re-builder-pinyin)
          ))
)

