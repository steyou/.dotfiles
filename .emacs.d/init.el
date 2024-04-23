;; Basic setup
(setq-default inhibit-startup-message t)
(setq-default indent-tabs-mode nil) ; always spaces
(setq-default tab-width 4)
(setq-default indent-line-function 'insert-tab)
(menu-bar-mode -1)  ; Disable the menu bar

;(setq backup-directory-alist `(("." . "~/.emacs.d/tildefiles/")))
(setq backup-directory-alist nil)
(setq backup-by-copying t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; forcibly escape prompts on Escape

;; Package management setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;(unless (package-installed-p 'helm)
;  (package-refresh-contents)
;  (package-install 'helm))

;(require 'helm-config)
;(helm-mode 1)

;(use-package popup
;  :ensure t)
;

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; Display line numbers
(use-package display-line-numbers
  :config
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t))

;; evil mode and undo-tree
(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode 1))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
  :config
  (evil-mode 1))
(define-key evil-normal-state-map (kbd "gb") 'next-buffer)
(define-key evil-normal-state-map (kbd "gB") 'previous-buffer)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; LSP things
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c++-mode . lsp)
         (c-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package helm
  :ensure t
  :demand t
  :bind (("M-x" . helm-M-x) ; SC
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         ("C-x c o" . helm-occur)) ;SC
         ("M-y" . helm-show-kill-ring) ;SC
         ("C-x r b" . helm-filtered-bookmarks) ;SC
  :config
    (require 'helm-config)
    (helm-mode 1))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)

;; optionally if you want to use debugger
(use-package dap-mode)
(use-package dap-cpptools)

;; which-key
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package tree-sitter
  :ensure t
  :config
  (add-hook 'c-mode-hook #'tree-sitter-mode)
  (add-hook 'c++-mode-hook #'tree-sitter-mode))

;; vterm
(use-package vterm
  :ensure t
  :bind ("C-/" . vterm))

;; eglot
;(use-package eglot
;  :ensure t
;  :hook ((c-mode c++-mode) . eglot-ensure)
;  :config
;  (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd")))
;  (setq eldoc-echo-area-use-multiline-p nil))

;; company mode
(use-package company
  :ensure t
  :config (global-company-mode 1))

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

(use-package magit
  :ensure t)

;(use-package highlight-indent-guides
;  :ensure t
;  :config
;  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;  (customize-variable highlight-indent-guides-method 'character))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tomorrow-night t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-tomorrow-night") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Custom-set variables and faces
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(highlight-indent-guides-auto-character-face-perc 90)
 '(package-selected-packages '(which-key company use-package eglot evil undo-tree))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; End of init.el
