;; set package repos
(setq package-archives 
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;; bootstrap use-package
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; load other items
(load "~/.emacs.d/ui.el")
(load "~/.emacs.d/edit.el")
(load "~/.emacs.d/font.el")
(load "~/.emacs.d/keys.el")

;;load theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'jdysmcl t)

;; bits n bobs
;;disable backup files
(setq make-backup-files nil)

;;set tramp to use ssh by default
(setq tramp-default-method "ssh")

;; disable blip
(setq visible-bell 1)

;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

;; ivy
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package which-key
  :config
  (which-key-mode))

