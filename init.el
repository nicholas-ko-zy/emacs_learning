;; -*- mode: elisp -*-
;; Set scratch to be org-mode on default
(setq initial-major-mode 'org-mode)
;; Disable the splash screen
(setq inhibit-startup-message t)  ; Don't show the GNU splash screen
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Enable syntax highlighting
(global-font-lock-mode t)

;; Enable show paren mode
(show-paren-mode t)

;; Enable visible bell (no beep)
(setq visible-bell 1)

;; Use 'y' and 'n' for confirmation prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable better buffer switching
(icomplete-mode 99)

;; Set the browser function to Firefox
(setq browse-url-browser-function #'browse-url-firefox)

;; Set global key bindings for Org mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Configure package management
;; Initialize package sources
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Use straight.el by default for `use-package`
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Install and configure Org-roam with straight.el
(straight-use-package '(org-roam :type git :flavor melpa :files (:defaults "extensions/*" "org-roam-pkg.el") :host github :repo "org-roam/org-roam"))
(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/RoamNotes"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode))

;; Org mode configuration
(require 'org)
;; Enable numbered headings for all Org files globally
(setq org-startup-numerated t)
(setq org-startup-indented t)
;; Always show in-line images upon startup in org files
(setq org-startup-with-inline-images t)
;; Additional package configurations
(use-package try :ensure t)
(use-package which-key :ensure t :config (which-key-mode))
(use-package org-bullets :ensure t :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Custom-set variables and faces
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("99d1e29934b9e712651d29735dd8dcd431a651dfbe039df158aa973461af003e" "e410458d3e769c33e0865971deb6e8422457fad02bf51f7862fa180ccc42c032" "9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2" default))
 '(ispell-dictionary nil)
 '(org-agenda-files '("~/RoamNotes/20240708171318-org_mode.org"))
 '(org-log-into-drawer t)
 '(package-selected-packages '(org-bullets which-key try use-package)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; insert-esv package
(straight-use-package
 '(insert-esv :type git
              :host github
              :repo "sam030820/insert-esv"
              :files ("*.el")))

;; Configure the package
(setq insert-esv-crossway-api-key "b7f04c2ca7b9ff8a512eaf4b6db25c9937a0c33a")
(setq insert-esv-include-short-copyright t)
(setq insert-esv-include-headings t)
(setq insert-esv-include-passage-horizontal-lines nil)
(setq insert-esv-line-length 50)
(setq insert-esv-include-verse-numbers t)
(setq insert-esv-include-footnotes t)
(setq insert-esv-include-footnote-body t)

;; Set spelling to UK english
(setq ispell-dictionary "british")

;; Set Light modus theme
(load-theme 'modus-operandi-tinted)
