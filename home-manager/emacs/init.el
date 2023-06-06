x-alt-keysym(eval-when-compile
  (require 'use-package))

;;GENERAL SETTINGS
;;Remove initial buffer, set index file	
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message
      ";;oh how i adore to edit text with emacs!")

;;disable backup files
(setq make-backup-files nil)

;; hide Scroll bar,menu bar, tool bar
;;(scroll-bar-mode -1)   
(tool-bar-mode -1)
;;(menu-bar-mode -1)

;; line numbering
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;;line higlight
(global-hl-line-mode t)

;; default indent
(setq-default tab-width 4)

;;set tramp to use ssh by default
(setq tramp-default-method "ssh")

;; disable blip
(setq visible-bell 1)

;;theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'jdysmcl t)

;;font
(setq default-frame-alist '((font . "Agave Nerd Font 16")))

;; visual line mode
(global-visual-line-mode)

;;EVIL AND KEYBINDINGS
(use-package evil
  :config
  (evil-mode 1)
  (evil-select-search-module 'evil-search-module 'evil-search)

  ;; splits
  (define-key evil-normal-state-map (kbd "<SPC>sh") 'evil-window-split)
  (define-key evil-normal-state-map (kbd "<SPC>sv") 'evil-window-vsplit)

  ;; move focus
  (define-key evil-normal-state-map (kbd "<SPC>h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "<SPC>j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "<SPC>k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "<SPC>l") 'evil-window-right)

  ;; buffers
  (define-key evil-normal-state-map (kbd "<SPC>bb") 'ivy-switch-buffer)
  (define-key evil-normal-state-map (kbd "<SPC>bl") (kbd "C-x <left>"))
  (define-key evil-normal-state-map (kbd "<SPC>bh") (kbd "C-x <right>"))
  
  ;; open stuff
  (define-key evil-normal-state-map (kbd "<SPC>ff") 'counsel-find-file)
  (define-key evil-normal-state-map (kbd "<SPC>fb") 'dired-jump)
  (define-key evil-normal-state-map (kbd "<SPC>fr") 'counsel-recentf)

  ;; projects
  (define-key evil-normal-state-map (kbd "<SPC>pf") 'projectile-find-file)
  (define-key evil-normal-state-map (kbd "<SPC>pb") 'projectile-dired)
  (define-key evil-normal-state-map (kbd "<SPC>pr") 'projectile-recentf)
  (define-key evil-normal-state-map (kbd "<SPC>pp") 'projectile-switch-project)

  ;; magit
  (define-key evil-normal-state-map (kbd "<SPC>gg") 'magit)

  ;; swiper stop swiping
  (define-key evil-normal-state-map (kbd "<SPC>//") 'swiper-isearch)

  ;; shell admin
  (define-key evil-normal-state-map (kbd "<SPC>tt") 'term)
  (define-key evil-normal-state-map (kbd "<SPC>sc") 'shell-command)
  (define-key evil-normal-state-map (kbd "<SPC>md") 'make-directory)

  ;; comment
  (define-key evil-normal-state-map (kbd "C-;") 'smart-comment)

  ;; writeroom-mode
  (define-key evil-normal-state-map (kbd "<SPC>zz") 'writeroom-mode)
  (define-key evil-normal-state-map (kbd "<SPC>zg") 'global-writeroom-mode)
  (define-key evil-normal-state-map (kbd "<SPC>z=") 'writeroom-increase-width)
  (define-key evil-normal-state-map (kbd "<SPC>z-") 'writeroom-decrease-width)
  )

;;modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;;all-the-icons
(use-package all-the-icons
  :if (display-graphic-p))

;;all-the-icons dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

;;MAGIT
(use-package magit
  :ensure t)

;;COMPANY
;; enable company in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(use-package company
  :commands company-tng-configure-default
  :custom
  ;; delay to start completion
  (company-idle-delay 0)
  ;; nb of chars before triggering completion
  (company-minimum-prefix-length 1))

;;autopair
(use-package flex-autopair
  :config
  (flex-autopair-mode 1))

;;comment
(use-package smart-comment)

;; ivy
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

;; eglot
(use-package eglot
  :ensure t
  :hook
  (python-mode . eglot-ensure)
  (nix-mode . eglot-ensure)
  (lua-mode . eglot-ensure)
  (go-mode . eglot-ensure)
  (sh-mode . eglot-ensure))

;; modes
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package lua-mode
  :mode "\\.lua\\'")

(use-package go-mode
  :mode "\\.go\\'")

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package writeroom-mode
  :ensure t)

