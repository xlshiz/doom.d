;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :completion
       (company           ; the ultimate code completion backend
         +childframe)
       ; (ivy               ; a search engine for love and life
       ;  +icons)
       (vertico           ; a search engine for love and life
        +icons)

       :editor
       (evil +everywhere) ; come to the dark side, we have cookies
       theme              ; what makes DOOM look the way it does
       (modeline +mini)   ; snazzy, Atom-inspired modeline, plus API
       (popup +defaults)  ; tame sudden yet inevitable temporary windows
       window-select      ; visually switch windows
       treemacs           ; a project drawer, like neotree but cooler
       workspaces         ; tab emulation, persistence & separate workspaces
       undo               ; persistent, smarter undo for your inevitable mistakes
       snippets           ; my elves. They type so I don't have to
       (tabs +sort)             ; a tab bar for Emacs
       hl-todo            ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ; ligatures          ; ligatures and symbols to make your code pretty again
       ; ophints            ; highlight the region an operation acts on
       vc-gutter          ; vcs diff in the fringe
       vi-tilde-fringe    ; fringe tildes to mark beyond EOB
       file-templates     ; auto-snippets for empty files
       fold               ; (nigh) universal code folding
       multiple-cursors   ; editing in many places at once
       rotate-text        ; cycle region at point between text candidates
       ; word-wrap          ; soft wrapping with language-aware indent
       electric           ; smarter, keyword-based electric-indent
       vc                 ; version-control and Emacs, sitting in a tree
       (dired +ranger)    ; making dired pretty [functional]
       (search +snails)

       :term
       eshell             ; the elisp shell that works everywhere
       vterm              ; the best terminal emulation in Emacs

       :checkers
       (syntax +childframe) ; tasing you for every semicolon you forget
       ;; (spell +flyspell)  ; tasing you for misspelling mispelling

       :tools
       (checker           ; tasing you for every semicolon you forget
        +childframe)      ; use childframes for error popups (Emacs 26+ only)
       format             ; automated prettiness
       (debugger +lsp)    ; FIXME stepping through code, to help you add bugs
       ;;direnv
       editorconfig       ; let someone else argue about tabs vs spaces
       (eval +overlay)    ; run code, run (also, repls)
       (lookup  +docsets) ; navigate your code and its documentation
       (lsp +peek)
       (magit +forge)     ; a git porcelain for Emacs
       make               ; run make tasks from Emacs
       pdf                ; pdf enhancements
       taskrunner         ; taskrunner for all your projects
       (chinese +rime)
       tags

       :lang
       (cc +lsp)          ; C/C++/Obj-C madness
       data               ; config/data formats
       ;;(dart +flutter)  ; paint ui and not much else
       emacs-lisp         ; drown in parentheses
       ;;erlang           ; an elegant language for a more civilized age
       (go +lsp)          ; the hipster dialect
       json               ; At least it ain't XML
       (java +lsp)        ; the poster child for carpal tunnel syndrome
       (javascript +lsp)  ; all(hope(abandon(ye(who(enter(here))))))
       lua                ; one-based indices? one-based indices
       markdown           ; writing docs for people to ignore
       (org               ; organize your plain life in plain text
        +dragndrop        ; drag & drop files/images into org buffers
        +pandoc           ; export-with-pandoc support
	+noter
        +pomodoro         ; be fruitful with the tomato technique
        +present)         ; using org-mode for presentations
       ;;php              ; perl's insecure younger brother
       plantuml           ; diagrams for confusing people more
      (python             ; beautiful is better than ugly
        +pyenv
        +pyright
        +lsp)
       rest               ; Emacs as a REST client
       rst                ; ReST in peace
       (rust +lsp)        ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scheme           ; a fully conniving family of lisps
       sh                 ; she sells {ba,z,fi}sh shells on the C xor
       (vue +lsp)         ; vue
       (web +lsp)         ; the tubes
       yaml               ; JSON, but readable

       :app
       ;;calendar
       ;;everywhere       ; *leave* Emacs!? You must be joking
       ;;(rss +org)       ; emacs as an RSS reader
       ;;twitter          ; twitter client https://twitter.com/vnought

       :config
       (default +bindings +smartparens)

       :private
       tabnine
       gitlab
)

;; * Leaderkey
(setq doom-localleader-key ",")
(setq doom-leader-alt-key "M-SPC")
(setq doom-localleader-alt-key "M-SPC m")
