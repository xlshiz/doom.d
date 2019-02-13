;;; private/my/+bindings.el -*- lexical-binding: t; -*-

(define-inline +my/prefix-M-x (prefix)
  (inline-quote
   (lambda () (interactive)
     (setq unread-command-events (string-to-list ,prefix))
     (call-interactively #'execute-extended-command))))

(setq doom-localleader-key ",")
(setq doom-leader-alt-key "S-SPC")

(map! :nmvo ","         nil
      :ni "M-s"         #'save-buffer
      :n  "ga"          #'ff-find-other-file
      :n  "gd"          #'+my/find-definitions
      :n  "gD"          #'+my/find-references
      :n  "go"          (λ! (message "%S" (text-properties-at (point))))
      :i [C-tab]        #'+company/complete
      :ni "C-j"         #'ace-window
      :gi "C-f"		#'forward-char
      :gi "C-b"		#'backward-char
      (:when (featurep! :private intl)
        :ni "C-;"         #'pyim-convert-code-at-point)
      ;; shell-pop
      (:when (featurep! :private shell)
        :ni  [f5]         #'shell-pop)
      (:after awesome-tab
        :ni "M-h"       #'awesome-tab-backward
	:ni "M-l"       #'awesome-tab-forward)
      (:after org
	:map evil-org-mode-map
	:ni "M-h"       #'awesome-tab-backward
	:ni "M-l"       #'awesome-tab-forward
	:localleader
	:n "t"          #'org-todo
	:n "T"          #'org-show-todo-tree
	:n "A"          #'org-archive-subtree
	:n "a"          #'org-agenda))
(map! :leader
      :desc "M-x"                      :nv "SPC" #'execute-extended-command
      :desc "Org Capture"              :nv "x"   #'org-capture
      :desc "Run terminal"             :n  "'"   #'+term/open
      :desc "NULL"                     :n  [tab] nil
      :desc "Alternate buffer"         :nv "TAB" #'+my/alternate-buffer-in-persp

      :desc "Switch workspace buffer"  :nv "a"   #'persp-switch-to-buffer
      (:desc "buffer" :prefix "b"
        :desc "Switch workspace buffer" :n "."   #'persp-switch-to-buffer
        :desc "Switch buffer"           :n "b"   #'switch-to-buffer
        :desc "Kill buffer"             :n "d"   #'kill-this-buffer)

      (:desc "code" :prefix "c"
        :desc "commentaryr"             :n "c"   #'evil-commentary-line)

      (:desc "Error" :prefix "e"
        :desc "Next error"              :n "n"   #'flycheck-next-error
        :desc "Previous error"          :n "p"   #'flycheck-previous-error)

      (:desc "File" :prefix "f"
	:desc "Find file"               :n "."   #'find-file
        :desc "Save files"              :n "s"   #'save-buffer
	(:when (featurep! :completion ivy)
          :desc "Find file from here"     :n "f"   #'counsel-file-jump)
	(:when (featurep! :completion helm)
          :desc "Find file from here"     :n "f"   #'helm-find))

      (:desc "Jump" :prefix "j"
        :n "j" #'evil-avy-goto-char-timer
        :n "c" #'evil-avy-goto-char-2
        :n "C" #'evil-avy-goto-char
        :n "l" #'evil-avy-goto-line
        :n "w" #'evil-avy-goto-word-1)

      (:desc "Mark" :prefix "m"
        :n "m" #'symbol-overlay-put
        :n "c" #'symbol-overlay-remove-all)

      (:desc "project" :prefix "p"
        :desc "Browse project"           :n  "." #'+default/browse-project
        :desc "Find file in project"     :n  "f" #'projectile-find-file
        :desc "Run shell in project"     :nv "'" #'+my/projectile-shell-pop
	(:when (featurep! :completion ivy)
	  :desc "Switch project buffer"  :n  "b" #'counsel-projectile-switch-to-buffer)
	(:when (featurep! :completion helm)
          :desc "Switch project buffer"  :n  "b" #'helm-projectile-switch-to-buffer))

      (:desc "workspace" :prefix "s"
        :desc "Display tab bar"          :n "TAB" #'+workspace/display
        :desc "New workspace"            :n "n"   #'+workspace/new
        :desc "Load workspace from file" :n "l"   #'+workspace/load
        :desc "Load a past session"      :n "L"   #'+workspace/load-session
        :desc "Save workspace to file"   :n "s"   #'+workspace/save
        :desc "Autosave current session" :n "S"   #'+workspace/save-session
        :desc "Switch workspace"         :n "."   #'+workspace/switch-to
        :desc "Kill all buffers"         :n "x"   #'doom/kill-all-buffers
        :desc "Delete session"           :n "X"   #'+workspace/kill-session
        :desc "Delete this workspace"    :n "d"   #'+workspace/delete
        :desc "Rename workspace"         :n "r"   #'+workspace/rename
        :desc "Restore last session"     :n "R"   #'+workspace/load-last-session
        :desc "Next workspace"           :n "]"   #'+workspace/switch-right
        :desc "Previous workspace"       :n "["   #'+workspace/switch-left
        :desc "Switch to 1st workspace"  :n "1"   (λ! (+workspace/switch-to 0))
        :desc "Switch to 2nd workspace"  :n "2"   (λ! (+workspace/switch-to 1))
        :desc "Switch to 3rd workspace"  :n "3"   (λ! (+workspace/switch-to 2))
        :desc "Switch to 4th workspace"  :n "4"   (λ! (+workspace/switch-to 3))
        :desc "Switch to 5th workspace"  :n "5"   (λ! (+workspace/switch-to 4))
        :desc "Switch to 6th workspace"  :n "6"   (λ! (+workspace/switch-to 5))
        :desc "Switch to 7th workspace"  :n "7"   (λ! (+workspace/switch-to 6))
        :desc "Switch to 8th workspace"  :n "8"   (λ! (+workspace/switch-to 7))
        :desc "Switch to 9th workspace"  :n "9"   (λ! (+workspace/switch-to 8))
        :desc "Switch to last workspace" :n "0"   #'+workspace/switch-to-last)

      (:desc "window" :prefix "w"
        :desc "Alternate window"       :n "TAB" #'+my/alternate-window
        :desc "Other window"           :n "w"   #'other-window
        :desc "Split window right"     :n "v"   #'split-window-right
        :desc "Split window right"     :n "|"   #'split-window-right
        :desc "Split window below"     :n "s"   #'split-window-below
        :desc "Split window below"     :n "-"   #'split-window-below
        :desc "Balance window"         :n "="   #'balance-windows
        :desc "Switch to left"         :n "h"   #'evil-window-left
        :desc "Switch to right"        :n "l"   #'evil-window-right
        :desc "Switch to up"           :n "k"   #'evil-window-up
        :desc "Switch to down"         :n "j"   #'evil-window-down
        :desc "Kill other window"      :n "O"   #'ace-delete-other-windows
        :desc "Kill other window"      :n "o"   #'delete-other-windows
        :desc "Kill window"            :n "D"   #'ace-delete-windows
        :desc "Kill current window"    :n "d"   #'delete-window)

 )
