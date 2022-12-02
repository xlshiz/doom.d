;;; tools/eaf/config.el -*- lexical-binding: t; -*-

(use-package! eaf)

(use-package! eaf-browser)
(use-package! eaf-pdf-viewer)
(use-package! eaf-markdown-previewer)
(use-package! eaf-org-previewer)
(use-package! eaf-git)
(use-package! eaf-file-manager)
(use-package! eaf-mindmap)
(use-package! eaf-evil
  :config
  (setq eaf-evil-leader-keymap doom-leader-map)
  (setq eaf-evil-leader-key "SPC"))
