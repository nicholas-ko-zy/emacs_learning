;; -*- mode: elisp -*-

;; --- 1. PERFORMANCE BOOSTER ---
;; Increase garbage collection threshold during startup and active use
(setq gc-cons-threshold 100000000) ;; 100MB
(setq read-process-output-max (* 1024 1024)) ;; 1MB; helps with LSP and heavy buffers

;; Restore GC to a reasonable level after startup to keep typing smooth
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold 800000)))

;; --- 2. CORE UI SETTINGS ---
(setq initial-major-mode 'org-mode)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq visible-bell nil) ;; Bells can cause UI stuttering
(setq ring-bell-function 'ignore)

(transient-mark-mode 1)
(global-font-lock-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(icomplete-mode 99)
(setq browse-url-browser-function #'browse-url-firefox)

;; Better scrolling to prevent "jumping" lag
(setq scroll-conservatively 101)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

;; --- 3. PACKAGE MANAGEMENT (Straight.el) ---
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

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; --- 4. ORG MODE OPTIMIZATION ---
;; Note: Removed the massive function redefinitions. 
;; Modern Emacs (27+) handles rotation/scaling via variables below.

(use-package org
  :defer t
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  (setq org-startup-numerated t
        org-startup-indented t
        org-startup-with-inline-images t
        org-image-actual-width nil ;; Allows #+ATTR_ORG: :width 300
        org-log-into-drawer t))

(use-package org-roam
  :defer t
  :init
  (setq org-roam-v2-ack t)
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

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; --- 5. THIRD PARTY TOOLS ---
(use-package which-key
  :config (which-key-mode))

(use-package try :defer t)

(use-package insert-esv
  :straight (insert-esv :type git :host github :repo "sam030820/insert-esv")
  :config
  (setq insert-esv-crossway-api-key "b7f04c2ca7b9ff8a512eaf4b6db25c9937a0c33a"
        insert-esv-line-length 50))

;; --- 6. SPELLING & THEME ---
(setq ispell-dictionary "british")
(load-theme 'modus-operandi-tinted t)

;; --- 7. AUTOMATIC CUSTOM SETTINGS ---
(custom-set-variables
 '(org-agenda-files '("~/RoamNotes/20240708171318-org_mode.org")))
(custom-set-faces)
