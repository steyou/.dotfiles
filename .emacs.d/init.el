;; Basic setup
(setq-default inhibit-startup-message t)
(setq-default indent-tabs-mode nil) ; always spaces
(setq-default tab-width 4)
(setq-default standard-indent 4)
(menu-bar-mode -1)  ; Disable the menu bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)

; Make window actually fit when mono view
(setq frame-resize-pixelwise t)

; 80 margin
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setopt display-fill-column-indicator-column 85)
;; (setq display-fill-column-indicator-column 80)

;(setq backup-directory-alist `(("." . "~/.emacs.d/tildefiles/")))
(setq backup-directory-alist nil)
(setq backup-by-copying t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; forcibly escape prompts on Escape

;; Package management setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; evil mode and undo-tree
(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode 1))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
  (setq evil-undo-system 'undo-tree) ; undo tree
  :config
  (evil-mode 1))
(define-key evil-normal-state-map (kbd "gf") 'next-buffer)
(define-key evil-normal-state-map (kbd "gb") 'previous-buffer)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package tree-sitter
  :ensure t
  :config
  (add-hook 'c-mode-hook #'tree-sitter-mode)
  (add-hook 'c++-mode-hook #'tree-sitter-mode))

;; Set the default indentation level for C/C++
(setq c-basic-offset 4)
(c-set-offset 'innamespace 0)

;;; For the built-in themes which cannot use `require'.
(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  (setq modus-themes-mode-line nil)

  ;; Load the theme of your choice.
  (load-theme 'modus-vivendi t))

;; Display line numbers
(use-package display-line-numbers
  :config
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; which-key
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook
  ((lsp-mode . my-lsp)
   (c++-mode . lsp)
   (c-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (defun my-lsp()
    (flycheck-mode)
    (lsp-ui-mode))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Helm is a completion framework for interface navigation
(use-package helm
  :ensure t
  :demand t
  ;:hook (after-init-startup . open-helm-find-startup)
  :bind (("M-x" . helm-M-x) ; SC
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         ("C-x c o" . helm-occur)) ;SC
         ("M-y" . helm-show-kill-ring) ;SC
         ("C-x r b" . helm-filtered-bookmarks) ;SC
  :config
    ;; (require 'helm-config)
    (helm-mode 1)
    (setq helm-ff-skip-boring-files t)
    (setq helm-ff-file-name-history-use-recentf))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)

(use-package treemacs
  :ensure t
  :defer t  ;; Defer loading until it's explicitly called
  :bind
  ;; Bind treemacs to a convenient key
  ("C-x t t" . treemacs)  
  :config
  ;; Optional: Customize treemacs settings here
  (setq treemacs-width 30
        treemacs-is-never-other-window t))
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)
;(use-package treemacs-magit
;  :after (treemacs magit)
;  :ensure t)

;(use-package treemacs-icons-dired
;  :after (treemacs dired)
;  :ensure t
;  :config (treemacs-icons-dired-mode))
;; Optional: Treemacs integration with LSP
(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :ensure t
  :config
  (lsp-treemacs-sync-mode 1))

;; company mode
;; this is pretty much nvim-cmp in emacs
(use-package company
  :ensure t
  :after lsp-mode
  :hook
  ((prog-mode . company-mode)
   (lsp-mode . flycheck-mode))
  :bind
  ;; Enable tab and shift-tab to cycle through completions
  (:map company-active-map
        ("<tab>" . company-complete-common-or-cycle)
        ("<backtab>" . company-select-previous))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :config
  ;; Enable global Company mode
  (global-company-mode 1)

  ;; Show numbers in the completion list
  (setq company-show-numbers t)

  ;; Bind number keys for quick selection in company mode
  (let ((map company-active-map))
    (dotimes (i 10)
      (define-key map (kbd (format "%d" i))
        `(lambda () (interactive) (company-complete-number ,i)))))

  ;; Customize company backends to include all available completions
  (setq company-backends '((company-files          ; File names
                            company-keywords       ; Keywords
                            company-capf           ; Completion at point
                            company-dabbrev-code   ; Code words
                            company-dabbrev))))    ; Text words

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Suites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package projectile
  :ensure t
  ;:pin melpa-stable
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ;("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))
;  :config
;(require 'projectile)
;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;(projectile-mode +1)

;(use-package magit
;  :ensure t)

; commented out because it doesn't play nice with modus-vivendi and people on
; internet say it's slow
;(use-package highlight-indent-guides
;  :ensure t
;  :hook
;  (prog-mode . highlight-indent-guides-mode)
;  :custom
;  (highlight-indent-guides-method 'character)
;  (highlight-indent-guides-guides-odd-face "darkgray")
;  (highlight-indent-guides-guides-even-face "darkgray")
;  (highlight-indent-guides-guides-character-face "darkgray"))

;; vterm
(use-package vterm
  :ensure t)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "/path/to/org-files/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package auctex
    ::ensure t
    ::defer t)
;; Use pdf-tools to open PDF files
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)

;; Custom-set variables and faces
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2" "e410458d3e769c33e0865971deb6e8422457fad02bf51f7862fa180ccc42c032" default))
 '(helm-minibuffer-history-key "M-p")
 '(highlight-indent-guides-auto-character-face-perc 90)
 '(package-selected-packages
   '(lsp-treemacs treemacs-projectile treemacs company-c-headers pdf-tools org-roam-ui modus-themes which-key company use-package eglot evil undo-tree))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; End of init.el
