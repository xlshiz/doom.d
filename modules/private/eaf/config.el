;;; tools/eaf/config.el -*- lexical-binding: t; -*-

(use-package! eaf
  :commands (eaf-open eaf-open-git eaf-open-browser eaf-open-office
                      eaf-open-file-manager eaf-open-in-file-manager
                      eaf-create-mindmap eaf-open-mindmap)
  :init
  (when (modulep! :completion vertico)
    (map! (:map embark-file-map
           :desc "Open with eaf"     "e"    #'eaf-open))))

(use-package! eaf-browser
  :after eaf)
(use-package! eaf-pdf-viewer
  :after eaf
  :config
  (set-popup-rule!
    '(("^\\*Outline: " :side right :size 40 :select nil)
      ("^\\*Outline Edit: " :side right :size 40 :select nil)))
  (map! :map eaf-pdf-outline-mode-map
        :gn "RET"      #'eaf-pdf-outline-jump))
(use-package! eaf-markdown-previewer
  :after eaf)
(use-package! eaf-org-previewer
  :after eaf)
(use-package! eaf-git
  :after eaf)
(use-package! eaf-file-manager
  :after eaf)
(use-package! eaf-mindmap
  :after eaf)
(use-package! eaf-image-viewer
  :after eaf)
(use-package! eaf-evil
  :after eaf
  :config
  (add-hook! 'evil-normal-state-entry-hook
    (defun my-eaf-map()
      (map! :map eaf-mode-map
            :gn "C-d"      #'eaf-py-proxy-scroll_down_page
            :gn "C-u"      #'eaf-py-proxy-scroll_up_page
            :gn "<next>"   #'eaf-py-proxy-scroll_up_page
            :gn "<prior>"  #'eaf-py-proxy-scroll_down_page
            :gn "C-j"        #'ace-window
            :gn "M-j"
            (cond ((modulep! :editor tabs +sort)    nil)
                  ((modulep! :editor tabs)          #'awesome-tab-ace-jump))
            :gn "M-h"
            (cond ((modulep! :editor tabs +sort)    #'sort-tab-select-prev-tab)
                  ((modulep! :editor tabs)          #'awesome-tab-backward-tab))
            :gn "M-l"
            (cond ((modulep! :editor tabs +sort)    #'sort-tab-select-next-tab)
                  ((modulep! :editor tabs)          #'awesome-tab-forward-tab)))))
  (setq eaf-evil-leader-keymap doom-leader-map)
  (setq eaf-evil-leader-key "SPC"))
