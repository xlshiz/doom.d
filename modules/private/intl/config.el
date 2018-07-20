;;; private/intl/config.el -*- lexical-binding: t; -*-

(def-package! pyim
    :init
    (progn
      (setq pyim-page-tooltip t
            pyim-directory (expand-file-name "pyim/" doom-cache-dir)
            pyim-dcache-directory (expand-file-name "dcache/" pyim-directory)
            default-input-method "pyim"))
  )

(def-package! fcitx
  :config (fcitx-evil-turn-on)
  )

(def-package! ace-pinyin
  :config
  (progn
    (setq ace-pinyin-use-avy t)
    (ace-pinyin-global-mode t))
)

(def-package! pangu-spacing
  :config (progn (global-pangu-spacing-mode 1))
)
