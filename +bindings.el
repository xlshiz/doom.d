;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; private/my/+bindings.el

(define-inline +my/prefix-M-x (prefix)
  (inline-quote
   (lambda () (interactive)
     (setq unread-command-events (string-to-list ,prefix))
     (call-interactively #'execute-extended-command))))

(map! :nmvo ","         nil
      :g  "M-s"         #'save-buffer
      :n  "ga"          #'ff-find-other-file
      ;; :n  "gd"          #'+my/find-definitions
      ;; :n  "gD"          #'+my/find-references
      :n  "go"          (λ! (message "%S" (text-properties-at (point))))
      :i [C-tab]        #'+company/complete
      :g  "C-j"         #'ace-window
      :i  "C-f"         #'forward-char
      :i  "C-b"         #'backward-char
      (:when (featurep! :private intl)
        :g  "M-f"       #'pyim-forward-word
        :g  "M-b"       #'pyim-backward-word
        :ni "C-;"       #'pyim-convert-string-at-point)
      ;; shell-pop
      (:when (featurep! :private shell)
        :ni  "M-n"      #'+term/toggle
        :ni  [f5]       #'+term/toggle)
      (:after awesome-tab
        :ni "M-h"       #'awesome-tab-backward
        :ni "M-l"       #'awesome-tab-forward)
      (:after org
        :map evil-org-mode-map
        :ni "M-h"       #'awesome-tab-backward
        :ni "M-l"       #'awesome-tab-forward
        :ni "C-j"       #'ace-window
        :localleader
        "t"             #'org-todo
        "T"             #'org-show-todo-tree
        "A"             #'org-archive-subtree
        "a"             #'org-agenda)
      (:when (featurep! :completion company)
        (:prefix "C-x"
          :i "C-@"      #'company-ispell
          :i "C-l"      #'+company/whole-lines
          :i "C-k"      #'+company/dict-or-keywords
          :i "C-f"      #'company-files
          :i "C-]"      #'company-etags
          :i "s"        #'company-english-helper-search
          :i "C-s"      #'company-yasnippet
          :i "C-o"      #'company-capf
          :i "C-n"      #'+company/dabbrev
          :i "C-p"      #'+company/dabbrev-code-previous)))

(map! :leader
      :desc "M-x"                          "SPC" #'execute-extended-command
      :desc "Org Capture"                  "x"   #'org-capture
      :desc "Run terminal"                 "'"   #'+term/here
      :desc "NULL"                         [tab] nil
      :desc "Alternate buffer"             "TAB" #'+my/alternate-buffer-in-persp
      :desc "Switch workspace buffer"      "e"   #'awesome-fast-switch/body
      :desc "Find project file"            "a"   #'snail

      (:prefix-map ("b" . "buffer")
        :desc "Switch buffer"              "b"   #'switch-to-buffer
        :desc "Kill buffer"                "d"   #'kill-this-buffer)

      (:prefix-map ("f" . "file")
        :desc "Save files"                 "s"   #'save-buffer)

      (:prefix-map ("j" . "jump")
        :desc "avy goto char timer"        "j"   #'evil-avy-goto-char-timer
        :desc "avy goto 2 char"            "c"   #'evil-avy-goto-char-2
        :desc "avy goto char"              "C"   #'evil-avy-goto-char
        :desc "avy goto line"              "l"   #'evil-avy-goto-line
        :desc "avy goto word"              "w"   #'evil-avy-goto-word-1)

      (:prefix-map ("m" . "mark")
        :desc "Mark symbol highlight"      "m"   #'symbol-overlay-put
        :desc "Clear all highlight"        "c"   #'symbol-overlay-remove-all)

      (:prefix-map ("o" . "open")
        :desc "Imenu sidebar"              "i"   #'imenu-list-smart-toggle)

      (:prefix-map ("p" . "project")
        :desc "Browse project"             "."   #'+default/browse-project
        :desc "Find file in project"       "f"   #'projectile-find-file
        :desc "Search project"             "n"   #'+my/evil-search-to-project
        :desc "Run shell in project"       "'"   #'+my/projectile-shell-pop
        (:when (featurep! :completion ivy)
          :desc "Switch project buffer"    "b"   #'counsel-projectile-switch-to-buffer)
        (:when (featurep! :completion helm)
          :desc "Switch project buffer"    "b"   #'helm-projectile-switch-to-buffer))

      (:prefix-map ("s" . "workspace")
        :desc "Display tab bar"            "TAB" #'+workspace/display
        :desc "Switch workspace"           "."   #'+workspace/switch-to
        :desc "New workspace"              "n"   #'+workspace/new
        :desc "Load workspace from file"   "l"   #'+workspace/load
        :desc "Save workspace to file"     "s"   #'+workspace/save
        :desc "Switch workspace"           "."   #'+workspace/switch-to
        :desc "Delete session"             "x"   #'+workspace/kill-session
        :desc "Delete this workspace"      "d"   #'+workspace/delete
        :desc "Rename workspace"           "r"   #'+workspace/rename
        :desc "Restore last session"       "R"   #'+workspace/restore-last-session
        :desc "Next workspace"             "]"   #'+workspace/switch-right
        :desc "Previous workspace"         "["   #'+workspace/switch-left
        :desc "Switch to 1st workspace"    "1"   (λ! (+workspace/switch-to 0))
        :desc "Switch to 2nd workspace"    "2"   (λ! (+workspace/switch-to 1))
        :desc "Switch to 3rd workspace"    "3"   (λ! (+workspace/switch-to 2))
        :desc "Switch to 4th workspace"    "4"   (λ! (+workspace/switch-to 3))
        :desc "Switch to 5th workspace"    "5"   (λ! (+workspace/switch-to 4))
        :desc "Switch to 6th workspace"    "6"   (λ! (+workspace/switch-to 5))
        :desc "Switch to 7th workspace"    "7"   (λ! (+workspace/switch-to 6))
        :desc "Switch to 8th workspace"    "8"   (λ! (+workspace/switch-to 7))
        :desc "Switch to 9th workspace"    "9"   (λ! (+workspace/switch-to 8))
        :desc "Switch to last workspace"   "0"   #'+workspace/switch-to-last)

      (:prefix-map ("w" . "window")
        :desc "Alternate window"           "TAB" #'+my/alternate-window
        :desc "Other window"               "w"   #'other-window
        :desc "Split window right"         "v"   #'split-window-right
        :desc "Split window right"         "|"   #'split-window-right
        :desc "Split window below"         "s"   #'split-window-below
        :desc "Split window below"         "-"   #'split-window-below
        :desc "Balance window"             "="   #'balance-windows
        :desc "Switch to left"             "h"   #'evil-window-left
        :desc "Switch to right"            "l"   #'evil-window-right
        :desc "Switch to up"               "k"   #'evil-window-up
        :desc "Switch to down"             "j"   #'evil-window-down
        :desc "Kill other window"          "O"   #'ace-delete-other-windows
        :desc "Kill other window"          "o"   #'delete-other-windows
        :desc "Kill window"                "D"   #'ace-delete-window
        :desc "Kill current window"        "d"   #'delete-window)

      )
