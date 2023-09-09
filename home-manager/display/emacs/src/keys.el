(use-package evil
  :config
  (evil-mode 1)
  (evil-select-search-module 'evil-search-module 'evil-search)

  ;; splits
  (define-key evil-normal-state-map (kbd "<SPC>-") 'evil-window-split)
  (define-key evil-normal-state-map (kbd "<SPC>|") 'evil-window-vsplit)

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

  ;; git
  (define-key evil-normal-state-map (kbd "<SPC>gg") 'magit)

  ;; swiper stop swiping
  (define-key evil-normal-state-map (kbd "<SPC>//") 'swiper-isearch)

  ;; shell admin
  (define-key evil-normal-state-map (kbd "<SPC>tt") 'term)
  (define-key evil-normal-state-map (kbd "<SPC>sc") 'shell-command)
  (define-key evil-normal-state-map (kbd "<SPC>md") 'make-directory)

  ;; comment
  (define-key evil-normal-state-map (kbd "C-;") 'smart-comment)

  ;; writeroom-mode aka zen
  (define-key evil-normal-state-map (kbd "<SPC>zz") 'writeroom-mode)
  (define-key evil-normal-state-map (kbd "<SPC>zg") 'global-writeroom-mode)
  (define-key evil-normal-state-map (kbd "<SPC>z=") 'writeroom-increase-width)
  (define-key evil-normal-state-map (kbd "<SPC>z-") 'writeroom-decrease-width)
  )
