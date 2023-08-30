;; remove initial buffer, set index file	
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message
      ";;oh how i adore to edit text with emacs!")

;; hide Scroll bar,menu bar, tool bar
(scroll-bar-mode -1)   
(tool-bar-mode -1)
(menu-bar-mode -1)

;;modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; icons
(use-package nerd-icons)

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ivy-rich
  :ensure t
  :init
  (nerd-icons-ivy-rich-mode 1)
  (ivy-rich-mode 1))

(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode))
