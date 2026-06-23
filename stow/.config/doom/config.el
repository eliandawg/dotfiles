;;; -*- lexical-binding: t; -*-

(use-package just-mode
  :defer t
  :mode ("justfile\\'" . just-mode)
  :custom
  (just-indent-offset 4))

(use-package kdl-mode
  :defer t
  :mode ("\\.kdl\\'" . kdl-mode))

(use-package lsp-mode
  :defer t
  :custom
  (lsp-inlay-hint-enable t)
  (lsp-eldoc-render-all t)
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)
  :config
  (lsp-register-custom-settings
   ;; Enable inlay hints in Go
   '(("gopls.hints" ((assignVariableTypes . t)
                     (compositeLiteralFields . t)
                     (compositeLiteralTypes . t)
                     (constantValues . t)
                     (functionTypeParameters . t)
                     (parameterNames . t)
                     (rangeVariableTypes . t)))))

  (lsp-register-client
   ;; Fish-LSP
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("fish-lsp" "start"))
    :activation-fn (lsp-activate-on "fish")
    :server-id 'fish-lsp))
  (add-to-list 'lsp-language-id-configuration '(fish-mode . "fish"))
  (setopt lsp-semantic-tokens-enable t
          lsp-log-io nil))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-ui-doc-mode-map
              ("M-k" . lsp-ui-doc-glance))
  :config
  (setopt lsp-ui-sideline-show-diagnostics nil))

(use-package flycheck
  :defer t
  :config
  (flycheck-posframe-configure-pretty-defaults)
  (setopt flycheck-posframe-mode t))

(use-package powershell
  :mode ("\\.ps1\\'" . powershell-mode)
  :hook (powershell-mode . lsp-mode)
  :config
  (setopt powershell-location-of-exe "/mnt/c/Program Files/Powershell/7/pwsh.exe")
  (setopt lsp-pwsh-exe "/mnt/c/Program Files/Powershell/7/pwsh.exe"))

(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp)))
  :custom (lsp-pyright-langserver-command "basedpyright"))

(use-package uv :defer t)

(use-package dirvish
  :defer t
  :custom
  (dirvish-attributes '(nerd-icons collapse file-size file-time))
  (dirvish-default-layout '(0 0.11 0.55))
  (dirvish-time-format-string "%d-%m-%y %I:%S:%p %Z")
  (dired-use-ls-dired 't)
  (dirvish-peek-mode 't)
  :config
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setopt insert-directory-program "gls")))

(map! :leader "e" #'dirvish)

(defun Ex ()
  "Literally just opens dirvish. Made because I keep doing `:Ex`."
  (interactive)
  (dirvish))

(setopt doom-font-increment 1)
(setopt doom-theme 'kaolin-bubblegum)
(setopt doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 18 :weight 'regular))

(use-package modus-themes
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  (modus-themes-headings
   '((1 . (1.25))
     (2 . (1.15))
     (3 . (1.12))
     (t . (1.05)))))

(use-package ef-themes)

(use-package kaolin-themes
  :custom
  (kaolin-themes-italic-comments t)
  (kaolin-themes-modeline-padded t))

(use-package buffer-to-pdf
  :defer t
  :ensure nil
  :config
  (setq buffer-to-pdf-directory (expand-file-name "~/")))

(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

(require 'flash-isearch)
(require 'flash-evil)

(use-package flash
  :defer t
  :commands (flash-jump flash-treesitter)
  :init
  (flash-isearch-mode 1)
  :custom
  (flash-rainbow t)
  (flash-char-multi-line t)
  (flash-char-jump-labels t)
  (flash-labels ";asdfjklghqwertyuiopzxcvbnm"))

(with-eval-after-load 'evil
  (evil-global-set-key 'normal (kbd "s") #'flash-evil-jump)
  (evil-global-set-key 'operator (kbd "s") #'flash-evil-jump)
  (evil-global-set-key 'motion (kbd "s") #'flash-evil-jump)
  (evil-global-set-key 'visual (kbd "s") #'flash-evil-jump))

(use-package indent-bars
  :defer t
  :custom
  (indent-bars-pattern ".")
  (indent-bars-width-frac 0.5)
  (indent-bars-pad-frac 0.25)
  (indent-bars-color-by-depth nil))

(setopt user-full-name "Elian Manzueta")
(setopt user-mail-address "elianmanzueta@protonmail.com")

(setopt confirm-kill-emacs nil
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
        which-key-idle-secondary-delay 0.05
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

(use-package ispell
  :custom
  (ispell-dictionary "english")
  (ispell-personal-dictionary "~/.config/doom/dict/.pws"))

(with-eval-after-load 'spell-fu
  (add-hook 'ansible-mode-hook (lambda () (spell-fu-mode -1)))
  (add-hook 'yaml-mode-hook (lambda () (spell-fu-mode -1)))
  (add-hook 'yaml-ts-mode-hook (lambda () (spell-fu-mode -1)))
  (add-hook 'json-mode-hook (lambda () (spell-fu-mode -1)))
  (add-hook 'prog-mode-hook (lambda () (spell-fu-mode -1))))

(setopt doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setopt initial-scratch-message ";;; scratch-buffer -*- lexical-binding: t; -*-\n")

(setopt +dashboard-pwd-policy "~/")

(setopt evil-split-window-below t
        evil-vsplit-window-right t)

(use-package git-auto-commit-mode
  :defer t
  :custom
  (gac-automatically-push-p t)
  (gac-automatically-add-new-files-p t)
  (gac-debounce-interval 60)
  (gac-shell-and " ; and "))

(use-package org-agenda
  :after org
  :custom
  (org-agenda-timegrid-use-ampm t)
  (org-display-custom-times t)
  (org-time-stamp-custom-formats '("<%m/%d/%y %a>" . "<%m/%d/%y %a %I:%M %p>")))

(use-package org-super-agenda
  :hook (org-agenda . org-super-agenda-mode)
  :config
  (setopt org-agenda-start-on-weekday 0)
  (setopt org-super-agenda-header-map (make-sparse-keymap))
  (setopt org-agenda-skip-scheduled-if-done t)
  (setopt org-agenda-skip-deadline-if-done t)
  (setopt org-agenda-overriding-header "")
  (setopt org-agenda-span 14)

  (setq org-super-agenda-groups
        '((:name ""
           :time-grid t)
          (:name "Inbox - Important"
           :and (:tag "inbox" :priority>= "B"))
          (:name "Inbox - In progress"
           :and (:tag "inbox" :todo "IN-PROGRESS"))
          (:name "Inbox"
           :and (:tag "inbox" :todo "TODO"))
          (:name "Projects"
           :ancestor-with-todo "PROJECT")
          (:name "Notes"
           :todo "NOTE")
          (:discard (:anything t)))))

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

(use-package org-attach
  :after org
  :custom
  (org-attach-auto-tag nil)
  (org-attach-store-link-p 'file)
  (org-attach-id-to-path-function-list '(org-attach-id-ts-folder-format
                                         org-attach-id-uuid-folder-format
                                         org-attach-id-fallback-folder-format))
  (org-id-method 'ts)
  (org-id-ts-format "%Y-%m-%dT%H%M%S.%6N"))

(use-package org-download
  :after org
  :custom
  (org-download-image-org-width '450))

(custom-set-faces!
  '(org-document-title :weight extra-bold :height 1.3)
  '(org-verbatim :inherit bold :weight extra-bold))

(use-package org
  :defer t
  :config
  (setopt org-hide-emphasis-markers t
          org-fontify-quote-and-verse-blocks t
          org-auto-align-tags nil
          org-tags-column 0
          org-agenda-tags-column 0
          org-startup-folded 'show2levels
          org-directory "~/org/"
          org-agenda-files '("~/org/roam/daily/" "~/org/roam/professional/" "~/org/inbox.org" "~/org/roam/life/")
          org-log-done 'time
          org-agenda-hide-tags-regexp "todo\\|work\\|workinfo\\|daily"
          org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)")
          org-ellipsis " ▼")

  ;; Supresses warning I get with setopt
  (setq org-emphasis-alist '(("*" org-verbatim bold)
                             ("/" italic)
                             ("_" underline)
                             ("=" org-verbatim verbatim)
                             ("~" org-code verbatim)
                             ("+" (:strike-through t))))

  ;; Multi-line emphasis in org-mode
  (setcar (nthcdr 4 org-emphasis-regexp-components) 20)
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components))

(with-eval-after-load 'org
  (add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1))))

;; org-yas-expand-maybe-h lags the absolute fuck out of Org.
;; disable it.
(with-eval-after-load 'evil-org
  (remove-hook 'org-tab-first-hook #'+org-yas-expand-maybe-h))

(use-package org-repeat-by-cron)

(use-package org-modern
  :after org
  :custom
  (org-modern-star 'replace)
  (org-modern-replace-stars "◉○✸✿")
  (org-modern-block-name '("‣ " . "‣ "))
  (org-modern-timestamp t)
  (org-modern-keyword "‣ ")
  (org-modern-table t)
  (org-modern-todo t))

(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :custom
  (org-appear-autolinks t)
  (org-appear-autoentities t)
  (org-appear-autokeywords t)
  (org-appear-trigger 'on-change))

(use-package org-roam
  :after org
  :custom
  (org-roam-node-default-sort 'file-mtime)
  (org-roam-file-exclude-regexp (list "~/org/.attach/"))

  (org-roam-capture-templates
   '(("d" "default" plain (file "~/org/roam/templates/default.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n")
      :unnarrowed t)
     ("s" "study" plain (file "~/org/roam/templates/study.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: study:%^{topics}")
      :unarrowed t)
     ("w" "work" plain (file "~/org/roam/templates/default.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: work")
      :unarrowed t)))

  (org-roam-dailies-capture-templates
   '(("w" "work-todo" plain (file "~/org/roam/templates/work-todo.org")
      :if-new (file+datetree "work-inbox.org" week)
      :unarrowed t))))

(use-package websocket :after org-roam)
(use-package org-roam-ui
  :after org-roam
  :custom
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t))

(defun my/org-roam-node-find-prof ()
  (interactive)
  (org-roam-node-find nil "@professional " nil))

(map! :leader "nrp" 'my/org-roam-node-find-prof)

(use-package org-tidy
  :after org
  :bind (:map org-mode-map
              ("C-c t" . org-tidy-mode))
  :custom
  (org-tidy-properties-style 'invisible))

(with-eval-after-load 'org
  (setopt +org-capture-todo-file "inbox.org")

  (setopt org-todo-keywords
          '((sequence "TODO(t)" "PROJECT(p)" "IN-PROGRESS(i@/!)" "|" "DONE(d!)" "WONT-DO(w@/!)")
            (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
            (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")
            (sequence "NOTE(N)" "HOLD(h)" "|")))

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
            ("[-]" :inverse-video t :inherit +org-todo-active))))

(use-package olivetti)

;; (setopt explicit-shell-file-name
;;         (cond
;;          ((eq system-type 'darwin) "/opt/homebrew/bin/fish")
;;          ((eq system-type 'gnu/linux)
;;           (let ((cmd (shell-command-to-string "uname -a")))
;;             (if (string-match "NixOS" cmd)
;;                 "/run/current-system/sw/bin/fish"
;;               "/bin/fish")))
;;          (t "/bin/sh")))  ; Default to bourne shell for other systems

(use-package vterm
  :defer t
  :custom
  (vterm-shell explicit-shell-file-name)
  (vterm-buffer-name-string "vterm: %s"))

(add-load-path! "~/emacs-libvterm")

(use-package ghostel
  :defer t
  :custom
  (ghostel-enable-osc52 t)
  (ghostel-tramp-shell-integration t))

(use-package evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))

(add-hook 'eshell-load-book #'ghostel-eshell-visual-command-mode)

(map! :leader "ot" #'ghostel)
(map! :leader "oT" #'ghostel-project)

(use-package ssh-config-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("/\\.ssh/config\\(\\.d/.*\\.conf\\)?\\'" . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/sshd?_config\\(\\.d/.*\\.conf\\)?\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode)))

(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

(use-package tramp-hlo
  :after tramp
  :custom
  (tramp-hlo-setup))

;; Most of this is from *Making TRAMP go Brrrr*
;; https://coredumped.dev/2025/06/18/making-tramp-go-brrrr./
(use-package tramp
  :defer t
  :init
  (with-eval-after-load 'tramp
    (with-eval-after-load 'compile
      (remove-hook 'compilation-mode-hook #'tramp-compile-disable-ssh-controlmaster-options)))

  (connection-local-set-profile-variables
   'remote-direct-async-process
   '((tramp-direct-async-process . t)))

  (connection-local-set-profiles
   '(:application tramp :protocol "scp")
   'remote-direct-async-process)

  (connection-local-set-profiles
   '(:application tramp :protocol "ssh")
   'remote-direct-async-process)

  (setopt magit-tramp-pipe-stty-settings 'pty)

  (setopt vc-ignore-dir-regexp
          (format "\\(%s\\)\\|\\(%s\\)"
                  vc-ignore-dir-regexp
                  tramp-file-name-regexp))
  (setopt enable-remote-dir-locals t))

(with-eval-after-load 'tramp
  (setenv "SHELL" "/bin/bash"))

(use-package verb
  :after org
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((verb . t)))
  :config (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(use-package vertico
  :defer t
  :custom
  (vertico-buffer-display-action '(display-buffer-reuse-window))

  (vertico-multiform-categories
   '((symbol (vertico-sort-function . vertico-sort-alpha))
     (file (vertico-sort-function . vertico-sort-history-alpha)))))

(use-package vertico-directory
  :after vertico
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package vertico-posframe-preview
  :after vertico
  :config
  (vertico-posframe-preview-mode 1))

(use-package undo-fu
  :custom
  (undo-limit 80000000))
