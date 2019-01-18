;;; private/intl/config.el -*- lexical-binding: t; -*-

(def-package! fcitx
  :config (fcitx-evil-turn-on)
)

(def-package! ace-pinyin
  :config
  (progn
    (setq ace-pinyin-use-avy t)
    (ace-pinyin-global-mode t))
)

(def-package! evil-find-char-pinyin
  :config
  (evil-find-char-pinyin-mode +1)
  (evil-find-char-pinyin-toggle-snipe-integration t)
)

(def-package! pangu-spacing
  :config (progn (global-pangu-spacing-mode 1))
)

(after! ivy
  (setq ivy-re-builders-alist
        '(
          (t . +intel/re-builder-pinyin)
          ))
)
