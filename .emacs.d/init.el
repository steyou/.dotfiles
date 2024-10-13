(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; Basic setup
(setq inhibit-startup-message t)
(setq indent-tabs-mode nil) ; always spaces
(menu-bar-mode -1)  ; Disable the menu bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)

; Make window actually fit when mono view
(setq frame-resize-pixelwise t)

; 80 margin
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setopt display-fill-column-indicator-column 85)

(setq backup-directory-alist nil)
(setq backup-by-copying t)

(setq read-process-output-max (* 1024 1024)) ;; 1MB
(setq gc-cons-threshold (* 100 1024 1024)) ;; 100MB

(setq-default tab-width 4)
(setq-default standard-indent 4)

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
  :ensure t
  :config
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t))

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
   ((helm-mode 1)
    (setq helm-ff-skip-boring-files t)
    (setq helm-ff-file-name-history-use-recentf)))

(use-package helm-projectile
  :after (helm projectile)
  :bind ("C-c f" . helm-projectile-find-file)
  :ensure t)

(use-package magit
  :ensure t)

(use-package perspective
  :ensure t
  :custom (persp-mode-prefix-key (kbd "C-c c"))  ; pick your own prefix key here
  :init (persp-mode))

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
  (org-roam-directory (file-truename "~/roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today)))

(use-package auctex
    :ensure t
    :defer t)
;; Use pdf-tools to open PDF files
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package treemacs
  :ensure t
  :defer t  ;; Defer loading until it's explicitly called
  :bind ("C-x t t" . treemacs)  
  :config
  ;; Optional: Customize treemacs settings here
  (setq treemacs-width 30
        treemacs-is-never-other-window t))
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)
(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package tree-sitter
  :ensure t
  :config
  (add-hook 'c-mode-hook #'tree-sitter-mode)
  (add-hook 'c++-mode-hook #'tree-sitter-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((c++-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

(use-package helm-lsp
  :after (helm lsp-mode)
  :commands helm-lsp-workspace-symbol)

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :ensure t
  :config (lsp-treemacs-sync-mode 1)  ;; Automatically sync LSP with Treemacs
  :commands (lsp-treemacs-errors-list lsp-treemacs-symbols lsp-treemacs-references))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover t))

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(use-package treemacs-icons-dired
;  :after (treemacs dired)
;  :ensure t
;  :config (treemacs-icons-dired-mode))
;; Optional: Treemacs integration with LSP

;; which-key
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;; Set the default indentation level for C/C++
(setq c-basic-offset 4)
(c-set-offset 'innamespace 0)

;; End of init.el
