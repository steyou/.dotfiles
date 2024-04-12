;; Basic setup
(setq inhibit-startup-message t)
(setq indent-tabs-mode nil) ; always spaces
(menu-bar-mode -1)  ; Disable the menu bar

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
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;(use-package evil
;  :ensure t
					;  :init
(setq evil-undo-system 'undo-tree)
;    ;(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
;    ;(setq evil-want-keybinding nil)
;  :config (evil-mode 1)

;(use-package evil-collection
;  :after evil
;  :ensure t
;  :config
;  (evil-collection-init))

;; LSP things

(use-package tree-sitter
  :ensure t
  :config
  (add-hook 'c-mode-hook #'tree-sitter-mode)
  (add-hook 'c++-mode-hook #'tree-sitter-mode))

;; which-key
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;; vterm
(use-package vterm
  :ensure t)

;; eglot
(use-package eglot
  :ensure t
  :hook ((c-mode c++-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd")))
  (setq eldoc-echo-area-use-multiline-p nil))

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
