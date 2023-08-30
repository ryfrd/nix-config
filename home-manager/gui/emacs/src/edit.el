;; default indent
(setq-default tab-width 4)

;; line numbering
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;;line higlight
(global-hl-line-mode t)

;; visual line mode
(global-visual-line-mode)

;;autopair
(use-package flex-autopair
  :config
  (flex-autopair-mode 1))

;;comment
(use-package smart-comment)

;; enable company in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(use-package company
  :commands company-tng-configure-default
  :custom
  ;; delay to start completion
  (company-idle-delay 0)
  ;; nb of chars before triggering completion
  (company-minimum-prefix-length 1))

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

;; syntax nit pick
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
