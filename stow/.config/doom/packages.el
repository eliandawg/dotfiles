;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; Emacs
(package! flash)
(disable-packages! evil-snipe avy)

;;; Org
(unpin! (:lang org))
(unpin! :emacs :tools)
(package! org-download)
(package! org-appear)
(package! git-auto-commit-mode)
(package! websocket)
(package! org-roam-ui)
(package! org-super-agenda)
(package! org-repeat-by-cron)
(package! verb)
(package! vundo)

;; (package! org-supertag
;;   :recipe (:host github :repo "yibie/org-supertag"))

;;; TRAMP
(package! tramp-hlo)

;; Code
(package! just-mode)
(package! fish-mode)
(package! flymake-ruff)
(package! ssh-config-mode)
(package! kdl-mode)
(package! uv
  :recipe (:host github :repo "johannes-mueller/uv.el"))
(package! flyover
  :recipe (:host github :repo "konrad1977/flyover"))
(package! mason)

;; Themes
(package! ef-themes
  :recipe (:host github :repo "protesilaos/ef-themes"))
(package! standard-themes)
(package! kaolin-themes)

;; Shells
(package! eat
  :recipe (:host codeberg
           :repo "akib/emacs-eat"
           :files ("*.el" ("term" "term/*.el") "*.texi"
                   "*.ti" ("terminfo/e" "terminfo/e/*")
                   ("terminfo/65" "terminfo/65/*")
                   ("integration" "integration/*")
                   (:exclude ".dir-locals.el" "*-tests.el"))))
