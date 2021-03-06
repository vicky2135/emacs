;;; core.el -- Core Editor features
;;
;;; Commentary:
;; Default global settings for Emacs

;;; Code:

;;;;;;;;;;;;;;;;;;;
;; Look and Feel ;;
;;;;;;;;;;;;;;;;;;;
;; Remove Clutter
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(setq inhibit-startup-screen t
      initial-scratch-message "")
(blink-cursor-mode -1)

;; Font/Themes
;;(set-frame-font "Fira Mono 11")
(load-theme 'spacemacs-light t)
(set-cursor-color "#fb0106")
(set-face-attribute 'default nil
                    :family "monaco"
                    :height 140
                    :weight 'normal
                    :width 'normal)
(use-package all-the-icons :ensure t :defer t)

;; mode line settings
(use-package spaceline-config
  :defer 1
  :init
  (setq powerline-default-separator "wave")
  (setq spaceline-window-numbers-unicode t)
  (setq spaceline-minor-modes-separator " ")
  (setq spaceline-workspace-numbers-unicode t)
  :ensure spaceline
  :config
  (spaceline-spacemacs-theme))
(smartparens-global-mode t)
(use-package spaceline-all-the-icons
  :disabled t
  :init
  (defvar spaceline-all-the-icons-separator-type)
  (setq spaceline-all-the-icons-separator-type 'arrow))

(use-package fancy-battery
  :ensure t
  :init
  (defvar fancy-battery-show-percentage)
  (setq fancy-battery-show-percentage t)
  :config
  (display-time-mode)
  (fancy-battery-mode))

(use-package whitespace
  :init
  (setq whitespace-line -1)
  (setq whitespace-style '(face tabs empty trailing lines-tail))
  :config
  (global-whitespace-mode)
  :diminish global-whitespace-mode)

;; Find my cursor
(use-package beacon
  :ensure t
  :init
  :config
  (beacon-mode)
  :diminish beacon-mode)

(use-package smooth-scroll
  :ensure t
  :config
  (smooth-scroll-mode t)
  (setq smooth-scroll/vscroll-step-size 5)
  :diminish smooth-scroll-mode)

(use-package linum
  :ensure t
  :config
  (defun linum-format-func (line)
    "Defines the format for the linum mode for specific LINE."
    (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
      (propertize (format (format " %%%dd " w) line) 'face 'linum)))
  (setq linum-format 'linum-format-func))

(use-package nlinum
  :ensure nlinum
  :ensure nlinum-relative
  :defer t)

(use-package paren
  :config
  (show-paren-mode))

(use-package volatile-highlights
  :disabled t
  :config
  (volatile-highlights-mode t)
  :diminish volatile-highlights-mode)

(use-package which-key
  :ensure t
  ;; :disabled t
  :config
  (which-key-mode 1)
  :diminish which-key-mode)

(use-package golden-ratio
  :ensure t
  :defer t
  :diminish "Φ")

(use-package indent-guide :ensure t :disabled t)
;;;;;;;;;;;;;;;;
;; Completion ;;
;;;;;;;;;;;;;;;;

(use-package hippie-expand
  :init
  (setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-all-abbrevs
                                           try-expand-line
                                           try-expand-list
                                           try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol))
  :bind ("M-/" . hippie-expand))

(use-package company
  :ensure t
  :ensure company-web
  :ensure company-quickhelp
  ;; :disabled t
  :bind ("C-." . company-complete)
  :init
  (setq company-idle-delay 0.5)
  (setq company-minimum-prefix-length 3)
  (setq company-backends
        (quote
         (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                       (company-dabbrev-code company-keywords)
                       company-oddmuse company-dabbrev)))
  (global-company-mode)
  :config
  ;; (defvar company-mode/enable-yas t
  ;;   "Enable yasnippet for all backends.")
  ;; (defun company-mode/backend-with-yas (backend)
  ;;   (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
  ;;       backend
  ;;     (append (if (consp backend) backend (list backend))
  ;;             '(:with company-yasnippet))))
  ;; (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  :defer t
  :diminish "Ⓒ"
  )

(use-package yasnippet
  ;; :disabled t
  :ensure t
  :defer t
  :config
  (yas-global-mode 1)
  :diminish (yas-minor-mode . "Ⓨ"))

(nyan-mode 1)

;;;;;;;;;;;;;;;;
;; Editing ;;
;;;;;;;;;;;;;;;;

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C-$" . mc/mark-more-like-this-extended)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c m" . mc/mark-all-dwim)
         ("M-<down-mouse-1>" . mc/add-cursor-on-click)))

(use-package string-inflection)
(global-set-key (kbd "C-c i") 'string-inflection-cycle)
(global-set-key (kbd "C-c C") 'string-inflection-camelcase)        ;; Force to CamelCase
(global-set-key (kbd "C-c L") 'string-inflection-lower-camelcase)  ;; Force to lowerCamelCase
(global-set-key (kbd "C-c J") 'string-inflection-java-style-cycle) ;; Cycle through Java styles

(use-package align
  :bind (("C-x a a" . align)
         ("C-x a c" . align-current)))

(use-package origami
  :disabled t
  :config (global-origami-mode 1)
  :bind (("C-c C-c" . origami-toggle-node)))

(use-package er/expand-region
  :ensure expand-region
  :init (setq shift-select-mode nil)
  :bind ("C-=" . er/expand-region))

(use-package evil
  :ensure t
  :disabled t
  :config (evil-mode 1))

;;;;;;;;;;;;;;;;
;; Navigation ;;
;;;;;;;;;;;;;;;;
(use-package avy
  :ensure t
  :init
  (setq avy-background t)
  :bind (("C-\"". avy-goto-word-or-subword-1)
         ("C-'" . avy-goto-char-timer))
  :defer t)

(use-package ace-window
  :bind ("C-:" . ace-window))

(use-package isearch
  :bind (("C-r"   . isearch-backward-regexp)
         ("C-M-s" . isearch-forward)
         ("C-M-r" . isearch-backward)))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

(use-package anzu
  :ensure t
  :bind (("M-%"   . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

(use-package zop-to-char
  :ensure t
  :bind (("M-z" . zop-to-char)
         ("M-Z" . zop-up-to-char)))

(use-package imenu-anywhere :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Multi-file Management ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package neotree
  :ensure t
  :init (setq neo-theme 'icons))

(use-package magit
  :ensure t
  :bind ("C-x m" . magit-status)
  :config
  (setq magit-refresh-status-buffer nil)
  (setq magit-auto-revert-mode nil)
  (magit-auto-revert-mode nil))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :bind (("C-c g d" . git-gutter:popup-hunk)
         ("C-c g r" . git-gutter:revert-hunk))
  :config
  (global-git-gutter-mode t)
  (setq git-gutter:modified-sign " "
        git-gutter:added-sign " "
        git-gutter:deleted-sign " ")
  (set-face-background 'git-gutter:modified "SandyBrown")
  (set-face-background 'git-gutter:added "DarkGreen")
  (set-face-background 'git-gutter:deleted "DarkRed"))

(use-package projectile
  :defer t
  :ensure projectile
  :init
  (defvar projectile-mode-line)
  (setq projectile-enable-caching t)
  :config
  (setq projectile-mode-line '(:eval (format "%s" (projectile-project-name))))
  (projectile-mode 1)
  :bind (("M-p" . projectile-find-file)
         ("C-c s p" . projectile-ripgrep)
         ("C-c p p" . projectile-switch-project)))

(use-package vc
  :init
  ;; Slows down opening large files.
  (setq vc-handled-backends nil)
  (remove-hook 'find-file-hooks 'vc-find-file-hook)
  (remove-hook 'find-file-hook 'vc-refresh-state)
  (remove-hook 'after-save-hook 'vc-find-file-hook))

(use-package recentf
  :config
  (recentf-mode 1))
(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))
(use-package ibuffer-projectile
  :ensure t
  :defer t
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-projectile-set-filter-groups)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

(use-package recentf
  :disabled t
  :config (recentf-mode))
(use-package desktop
  :disabled t
  :config (desktop-save-mode 1))

(use-package dumb-jump
  :ensure t
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g h" . dumb-jump-back)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
  (setq dumb-jump-force-searcher 'rg))

(use-package rg
  :ensure rg
  :ensure wgrep-ag
  :config
  (add-hook 'ripgrep-search-mode-hook 'wgrep-ag-setup)
  :defer t)

(use-package saveplace
  :init
  (save-place-mode 1)
  (setq-default save-place t))

(use-package savehist
  :init (setq savehist-additional-variables
      ;; search entries
      '(search-ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file (concat () user-emacs-directory "savehist" ))
  :config
  (savehist-mode 1))

(use-package paradox
  :ensure t
  :defer t
  :init
  (defvar paradox-automatically-star)
  (defvar paradox-execute-asynchronously)
  (setq paradox-automatically-star t)
  (setq paradox-execute-asynchronously t))

(use-package simple-http
  :config (setq httpd-root "~/Development/testing")
  :defer t)

(use-package zeal-at-point
  :defer t
  :config (setq zeal-at-point-zeal-version "0.3.1"))

(use-package dashboard
  :ensure t
  :init (setq dashboard-items '((recents  . 7)
                                (projects . 8)
                                (bookmarks . 5)
                                (agenda . 5)))
  :config
  (dashboard-setup-startup-hook))

(use-package page-break-lines :defer t :diminish page-break-lines-mode)
(use-package howdoi :disabled t)
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :diminish undo-tree-mode)

(use-package vlf :defer t)

(use-package autorevert
  :config
  (global-auto-revert-mode 1)
  :diminish (auto-revert-mode . "Ⓐ"))

(use-package eshell
  :ensure eshell-git-prompt
  :defer t
  ;;   https://github.com/ekaschalk/dotspacemacs/blob/master/.spacemacs
  :init (eshell-git-prompt-use-theme 'robbyrussell))

(use-package alert
  :defer t
  :ensure t
  :init
  (defvar alert-default-style)
  (setq alert-default-style 'libnotify))

(use-package markdown-mode
  :ensure t
  :defer t
  :init
  (defvar markdown-command)
  (setq markdown-command "/usr/bin/pandoc"))

(use-package restclient
  :ensure t
  :mode ("\\.rest\\'" . restclient-mode)
  :defer t)
(use-package company-restclient
  :ensure t
  :after company
  :after restclient
  :config (add-to-list 'company-backends 'company-restclient))
;; Org mode settings
(use-package org-crypt
  :defer 4
  :init
  (setq org-tags-exclude-from-inheritance (quote ("crypt")))
  (setq org-crypt-key nil)
  ;; GPG key to use for encryption
  ;; Either the Key ID or set to nil to use symmetric encryption.
  :config (org-crypt-use-before-save-magic))

;; To turn it off auto-save only locally, you can insert this:
;; # -*- buffer-auto-save-file-name: nil; -*-

(use-package org-bullets
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (use-package org-wunderlist
;;   :init (setq org-wunderlist-file  "~/.emacs.d/Wunderlist.org"
;;                 org-wunderlist-dir "~/.emacs.d/org-wunderlist/"))

(use-package org-alert
  :defer t
  :config (org-alert-enable))

(use-package org
  :init
  (setq org-ellipsis "…"
        ;; org-agenda-files '("~/Dropbox/org-files")
        org-log-done 'time
        org-startup-with-inline-images t
        ;; org-fontify-whole-heading-line t
        ;; org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA"))


;; Loading functions and variables

(set-default 'imenu-auto-rescan t)
(setq-default frame-title-format '(buffer-file-name "%b"))
(setq-default line-spacing 0)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq select-enable-clipboard t ;; Enabled emacs to use system clipboard
      select-enable-primary nil ;; Disable Copy on selection
      display-time-default-load-average nil
      save-interprogram-paste-before-kill t
      kill-ring-max 200
      kill-do-not-save-duplicates t
      apropos-do-all t
      use-dialog-box nil
      ring-bell-function 'ignore
      mouse-yank-at-point t
      require-final-newline t
      ns-use-srgb-colorspace 'nil
      ediff-window-setup-function 'ediff-setup-windows-plain)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)
(setq tab-always-indent 'complete)
(put 'narrow-to-region 'disabled nil)
(setq ido-enable-flex-matching t)
(ido-mode 1)
(global-set-key (kbd "M-x") 'smex)
(ido-everywhere 1)
(flx-ido-mode 1)
(provide 'core)
