(use-package flyover
  :config
  (setopt flyover-virtual-line-type nil
          flyover-show-at-eol t
          flyover-base-height 1))

(with-eval-after-load 'lsp-mode
  (lsp-register-custom-settings
   '(("gopls.hints" ((assignVariableTypes . t)
                     (compositeLiteralFields . t)
                     (compositeLiteralTypes . t)
                     (constantValues . t)
                     (functionTypeParameters . t)
                     (parameterNames . t)
                     (rangeVariableTypes . t))))))

(use-package just-mode
  :defer t
  :mode ("justfile\\'" . just-mode)
  :config
  (setopt just-indent-offset 4))

(use-package kdl-mode
  :defer t
  :mode ("\\.kdl\\'" . kdl-mode))

(use-package lsp-mode
  :config
  (lsp-register-client   (make-lsp-client
                          :new-connection (lsp-stdio-connection '("fish-lsp" "start"))
                          :activation-fn (lsp-activate-on "fish")
                          :server-id 'fish-lsp))
  (add-to-list 'lsp-language-id-configuration '(fish-mode . "fish")))

(use-package lsp-ui
  :bind (:map lsp-ui-doc-mode-map
              ("M-k" . lsp-ui-doc-glance))
  :config
  (setopt lsp-ui-sideline-show-diagnostics nil))

(use-package flycheck
  :config
  (flycheck-posframe-configure-pretty-defaults)
  (setopt flycheck-posframe-mode t))

(use-package powershell
  :mode ("\\.ps1\\'" . powershell-ts-mode)
  :hook (powershell-mode . lsp-mode)
  :config
  (setopt powershell-location-of-exe "/mnt/c/Program Files/Powershell/7/pwsh.exe"))

(setopt lsp-pyright-langserver-command "basedpyright")

(setopt lsp-rust-analyzer-display-chaining-hints t)
(setopt lsp-rust-analyzer-display-closure-return-type-hints t)
(setopt lsp-rust-analyzer-display-parameter-hints t)

(use-package uv
  :defer t)

(use-package dirvish
  :config
  (setopt dirvish-attributes
          '(nerd-icons collapse file-size file-time))
  (setopt dirvish-default-layout '(0 0.11 0.55))
  (setopt dirvish-time-format-string "%d-%m-%y %I:%S:%p %Z")
  (setopt dired-use-ls-dired 't)
  (setopt dirvish-peek-mode 't)
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setopt insert-directory-program "gls")))

(map! :leader "e" #'dirvish)

(defun Ex ()
  "Literally just opens dirvish. Made because I keep doing `:Ex`."
  (interactive)
  (dirvish))

(setopt doom-font-increment 1)
(setopt doom-theme 'kaolin-galaxy)
(setopt doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 18 :weight 'regular))

(setopt catppuccin-flavor 'mocha
        catppuccin-italic-comments t
        catppuccin-italic-variables t
        catppuccin-highlight-matches t)

(setopt modus-themes-italic-constructs t)
(setopt modus-themes-bold-constructs t)
(setopt modus-themes-headings
        '((1 . (1.25))
          (2 . (1.15))
          (3 . (1.12))
          (t . (1.05))))

(setopt ef-themes-headings
        '((1 . (1.25))
          (2 . (1.15))
          (3 . (1.12))
          (t . (1.05))))

(setopt kaolin-themes-italic-comments t
        kaolin-themes-modeline-padded t)

(defun +eshell-default-prompt-fn ()
  "Generate the prompt string for eshell. Use for `eshell-prompt-function'."
  (require 'shrink-path)
  (concat (if (bobp) "" "\n")
          (propertize (eshell-user-login-name) 'face 'nerd-icons-green)
          (propertize " in " 'face '+eshell-prompt-pwd)

          (let ((pwd (eshell/pwd)))
            (propertize (if (equal pwd "~")
                            pwd
                          (abbreviate-file-name pwd))
                        'face 'nerd-icons-green))

          "\n"
          (propertize "$" 'face (if (zerop eshell-last-command-status) 'success 'error))
          " "))

(if (executable-find "eza")
    (set-eshell-alias!
     "ls" "eza -lhaF --color=auto"
     "gst" "git status"
     "gcsm" "git commit --signoff --message")
  (set-eshell-alias!
   "ls" "ls -lhaF --color=auto"
   "gst" "git status"
   "gcsm" "git commit --signoff --message"))

(require 'flash-isearch)
(require 'flash-evil)

(use-package flash
  :commands (flash-jump flash-treesitter)
  :init
  :config
  (flash-isearch-mode 1)
  (flash-evil-setup)
  (setopt flash-rainbow t
          flash-char-multi-line t
          flash-char-jump-labels t)

  (with-eval-after-load 'evil
    (evil-global-set-key 'normal (kbd "s") #'flash-evil-jump)
    (evil-global-set-key 'operator (kbd "s") #'flash-evil-jump)
    (evil-global-set-key 'motion (kbd "s") #'flash-evil-jump)
    (evil-global-set-key 'visual (kbd "s") #'flash-evil-jump)
    (define-key evil-motion-state-map "f" #'flash-char-find)
    (define-key evil-motion-state-map "t" #'flash-char-find-to)
    (define-key evil-motion-state-map "F" #'flash-char-find-backward)
    (define-key evil-motion-state-map "T" #'flash-char-find-to-backward)
    (define-key evil-motion-state-map ";" #'flash-char-repeat)
    (define-key evil-motion-state-map "," #'flash-char-repeat-reverse)))

(use-package indent-bars
  :config
  (setopt indent-bars-pattern "."
        indent-bars-width-frac 0.5
        indent-bars-pad-frac 0.25
        indent-bars-zigzag 0.1
        indent-bars-highlight-current-depth '(:face default :blend 0.4 :zigzag 0.2)
        indent-bars-color-by-depth nil))

(setopt user-full-name "Elian Manzueta")
(setopt user-mail-address "elianmanzueta@protonmail.com")

(setopt undo-limit 80000000
        confirm-kill-emacs nil
        auto-save-default t
        make-backup-files t
        auto-save-default t
        truncate-string-ellipsis "…"
        delete-by-moving-to-trash t
        kill-ring-max 200

        evil-want-fine-undo t
        evil-shift-width 2
        evil-want-C-i-jump t
        +evil-want-move-window-to-wrap-around t
        display-line-numbers-type 'relative
        which-key-idle-delay 0.5
        projectile-project-search-path '(("~/projects/" . 3))
        magit-show-long-lines-warning nil
        +whitespace-guess-in-projects t)

(add-to-list 'exec-path "/home/elian/.local/bin/")
(map! :leader "y" #'consult-yank-from-kill-ring)

;; For .service files
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-mode))

(map! :leader "wa" #'ace-select-window)

(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

(setopt ispell-dictionary "english")
(setopt ispell-personal-dictionary "~/.config/doom/dict/.pws")

(use-package! spell-fu
  :config
  (setopt spell-fu-ignore-modes '(prog-mode
                                  yaml-ts-mode
                                  yaml-mode
                                  json-ts-mode
                                  json-mode)))

(setopt doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setopt initial-scratch-message ";;; scratch-buffer -*- lexical-binding: t; -*-\n")

(setopt +doom-dashboard-pwd-policy "~/")

(setopt evil-split-window-below t
        evil-vsplit-window-right t)

(use-package git-auto-commit-mode
  :config
  (setopt gac-automatically-push-p t
          gac-automatically-add-new-files-p t
          gac-debounce-interval 60
          gac-shell-and " ; and "))

(use-package org-agenda
  :after org
  :config
  (setopt org-agenda-timegrid-use-ampm t
          org-display-custom-times t
          org-time-stamp-custom-formats '("<%m/%d/%y %a>" . "<%m/%d/%y %a %I:%M %p>")))

(use-package org-super-agenda
  :after org
  :config
  (setopt org-agenda-start-on-weekday 0)
  (setopt org-super-agenda-header-map (make-sparse-keymap))
  (setopt org-agenda-skip-scheduled-if-done t)
  (setopt org-agenda-skip-deadline-if-done t)
  (setopt org-agenda-overriding-header "")
  (setopt org-agenda-span 14)

  (setopt org-super-agenda-groups
          '((:name ""
             :time-grid t)
            (:name "Projects"
             :and (:children t :tag "projects"))
            (:name "Inbox - Important"
             :and (:tag "inbox" :priority>= "B"))
            (:name "Inbox - In progress"
             :and (:tag "inbox" :todo "IN-PROGRESS"))
            (:name "Inbox"
             :and (:tag "inbox" :todo "TODO"))
            (:name "Notes"
             :todo "NOTE")
            (:discard (:anything t)))))

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

(use-package org-attach
  :after org
  :config
  (setopt org-attach-auto-tag nil
          org-attach-store-link-p 'file
          org-attach-id-to-path-function-list '(org-attach-id-ts-folder-format
                                                org-attach-id-uuid-folder-format
                                                org-attach-id-fallback-folder-format)))
(setopt org-id-method 'ts)
(setopt org-id-ts-format "%Y-%m-%dT%H%M%S.%6N")

(use-package org-download
  :after org
  :config
  (setopt org-download-image-org-width '450))

(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook (lambda () (hl-line-mode -1)))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

(custom-set-faces!
  '(org-document-title :weight extra-bold :height 1.3)
  '(org-verbatim :inherit bold :weight extra-bold))

(use-package org
  :defer t
  :bind (:map org-mode-map
              ("M-o" . org-appear-mode))
  :config
  (setopt org-hide-emphasis-markers t
          org-fontify-quote-and-verse-blocks t
          org-auto-align-tags nil
          org-tags-column 0
          org-agenda-tags-column 0
          org-ellipsis " ▼"
          org-startup-folded 'show2levels

          org-emphasis-alist '(("*" org-verbatim bold) ("/" italic) ("_" underline) ("=" org-verbatim verbatim)
                               ("~" org-code verbatim) ("+" (:strike-through t)))

          org-appear-autolinks t
          org-appear-autoentities t
          org-appear-autokeywords t

          org-directory "~/org/"
          org-agenda-files '("~/org/roam/daily/" "~/org/roam/professional/" "~/org/inbox.org" "~/org/roam/life/")
          org-log-done 'time
          org-agenda-hide-tags-regexp "todo\\|work\\|workinfo\\|daily"
          org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)"))

  ;; Multi-line emphasis in org-mode
  (setcar (nthcdr 4 org-emphasis-regexp-components) 20)
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components))

(use-package org-modern
  :after org
  :config
  (setopt org-modern-star 'replace
          org-modern-replace-stars "◉○✸✿"
          org-modern-block-name '("‣ " . "‣ ")
          org-modern-timestamp t
          org-modern-keyword "‣ "
          org-modern-table t
          org-modern-todo t))

(use-package org-repeat-by-cron
  :config
  (global-org-repeat-by-cron-mode))

(use-package org-roam
  :after org
  :config
  (setopt org-roam-node-default-sort 'file-mtime
          org-roam-file-exclude-regexp (list "~/org/.attach/")))

(defun my/org-roam-node-find-prof ()
  (interactive)
  (org-roam-node-find nil "@professional " nil))

(map! :leader "nrp" 'my/org-roam-node-find-prof)

(setopt org-roam-capture-templates
        '(("d" "default" plain (file "~/org/roam/templates/default.org")
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n")
           :unnarrowed t)
          ("s" "study" plain (file "~/org/roam/templates/study.org")
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: study:%^{topics}")
           :unarrowed t)

          ("w" "work" plain (file "~/org/roam/templates/default.org")
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: work")
           :unarrowed t)

          ("i" "issue" plain (file "~/org/roam/templates/issue.org")
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: issue")
           :unarrowed t)))

(with-eval-after-load 'org
  (setopt org-roam-dailies-capture-templates
          '(("w" "work-todo" plain (file "~/org/roam/templates/work-todo.org")
             :if-new (file+datetree "work-inbox.org" week)
             :unarrowed t))))

(use-package websocket
  :after org-roam)

(use-package org-roam-ui
  :after org-roam
  :config
  (setopt org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(with-eval-after-load 'org
  (setopt +org-capture-todo-file "inbox.org")

  (setopt org-todo-keywords
          '((sequence "TODO(t)" "IN-PROGRESS(i@/!)" "|" "DONE(d!)" "WONT-DO(w@/!)")
            (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
            (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")
            (sequence "NOTE(N)" "HOLD(h)" "|"))))

(setopt org-todo-keyword-faces
        '(("[-]" . +org-todo-active) ("STRT" . +org-todo-active)
          ("[?]" . +org-todo-onhold) ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold) ("PROJ" . +org-todo-project)
          ("NO" . +org-todo-cancel) ("KILL" . +org-todo-cancel)
          ("NOTE" . flymake-note-echo)))

(setopt org-modern-todo-faces
        '(("KILL" :inverse-video t :inherit +org-todo-cancel)
          ("NO" :inverse-video t :inherit +org-todo-cancel)
          ("PROJ" :inverse-video t :inherit +org-todo-project)
          ("HOLD" :inverse-video t :inherit +org-todo-onhold)
          ("WAIT" :inverse-video t :inherit +org-todo-onhold)
          ("[?]" :inverse-video t :inherit +org-todo-onhold)
          ("STRT" :inverse-video t :inherit +org-todo-active)
          ("NOTE" :inverse-video t :inherit flymake-note-echo)
          ("[-]" :inverse-video t :inherit +org-todo-active)))

(setopt explicit-shell-file-name
        (cond
         ((eq system-type 'darwin) "/opt/homebrew/bin/fish")
         ((eq system-type 'gnu/linux)
          (let ((cmd (shell-command-to-string "uname -a")))
            (if (string-match "NixOS" cmd)
                "/run/current-system/sw/bin/fish"
              "/bin/fish")))
         (t "/bin/sh")))  ; Default to bourne shell for other systems

(use-package vterm
  :defer t
  :init
  (setopt vterm-shell explicit-shell-file-name)
  (setopt vterm-buffer-name-string "vterm: %s"))

(add-load-path! "~/emacs-libvterm")

(use-package eat
  :defer t
  :init
  (setopt process-adaptive-read-buffering nil) ; makes EAT a lot quicker!
  (setopt eat-term-name "xterm-256color") ; https://codeberg.org/akib/emacs-eat/issues/119"
  (setopt eat-shell "/bin/bash"))

(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)
(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

(use-package ssh-config-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("/\\.ssh/config\\(\\.d/.*\\.conf\\)?\\'" . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/sshd?_config\\(\\.d/.*\\.conf\\)?\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode)))

(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

(use-package tramp-hlo
  :defer t
  :config
  (tramp-hlo-setup))

;; Most of this is from *Making TRAMP go Brrrr*
;; https://coredumped.dev/2025/06/18/making-tramp-go-brrrr./
(use-package tramp
  :init
  (with-eval-after-load 'tramp
    (with-eval-after-load 'compile
      (remove-hook 'compilation-mode-hook #'tramp-compile-disable-ssh-controlmaster-options)))

  (connection-local-set-profile-variables
   'remote-direct-async-process
   '((tramp-direct-async-process . t)))

  ;; (connection-local-set-profiles
  ;;  '(:application tramp :protocol "scp")
  ;;  'remote-direct-async-process)

  ;; (connection-local-set-profiles
  ;;  '(:application tramp :protocol "ssh")
  ;;  'remote-direct-async-process)

  (setopt magit-tramp-pipe-stty-settings 'pty)

  (setopt vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))
  (setopt enable-remote-dir-locals t))

(use-package! remember
  :config
  (setopt remember-notes-initial-major-mode 'org-mode))

(use-package verb
  :after org
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((verb . t)))
  :config (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(use-package vundo)

(use-package vertico
  :defer t
  :config
  (setopt vertico-buffer-display-action '(display-buffer-reuse-window))

  (setopt vertico-multiform-categories
          '((symbol (vertico-sort-function . vertico-sort-alpha))
            (file (vertico-sort-function . vertico-sort-history-alpha)
                  ))))

(use-package vertico-directory
  :after vertico
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
