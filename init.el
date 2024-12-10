(setq inhibit-startup-screen t)

;; Enable org-roam-mode on startup
(add-hook 'after-init-hook 'org-roam-mode)

;; Open the org-roam buffer on startup
(add-hook 'after-init-hook 'org-roam-buffer-toggle-display)

;; Initialize package sources
(require 'package)
(setq package-archives '(
    ("melpa" . "https://melpa.org/packages/")
    ("org" . "https://orgmode.org/elpa/")
    ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install and require use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; emojis
(set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji") nil 'prepend)

;; Org-mode and Org-roam setup
(use-package org
  :ensure t)

(use-package org-roam
  :after org
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture))
  :config
  (org-roam-db-autosync-mode))

;; Org-roam keybindings
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)
(global-set-key (kbd "C-c n c") 'org-roam-capture)
(global-set-key (kbd "C-c n g") 'org-roam-graph)

;; org-roam-ui
   (use-package org-roam-ui
     :ensure t
     :after org-roam
     :init
     (setq org-roam-ui-sync-theme t
           org-roam-ui-follow t
           org-roam-ui-update-on-save t
           org-roam-ui-open-on-start t)
     :config
     ;; Start org-roam-ui-mode when Emacs starts
     (add-hook 'after-init-hook #'org-roam-ui-mode))
   
;; C++ Development setup
(use-package cc-mode
  :mode ("\\.cpp\\'" . c++-mode)
  :config
  (setq c-default-style "linux"
        c-basic-offset 4))

(use-package company
  :hook (after-init . global-company-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l") ;; Optional
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package which-key
  :config
  (which-key-mode))

;; Hooks for C++ mode
(add-hook 'c++-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook 'company-mode)

(set-face-attribute 'default nil :font "Consolas-12")
  (load-theme 'tango-dark t)


     ;; Enable Ivy-mode for enhanced completion
     (ivy-mode 1)

     ;; Optional Ivy configurations
     (setq ivy-use-virtual-buffers t)
     (setq ivy-count-format "(%d/%d) ")
     (setq enable-recursive-minibuffers t)

   ;; Counsel enhances M-x and other commands
   (use-package counsel
     :ensure t
     :config (counsel-mode 1))

   ;; Swiper enhances search
   (use-package swiper
     :ensure t
     :bind (("C-s" . swiper)))
   

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(emojify counsel which-key use-package treemacs-evil org-roam melpa-upstream-visit lsp-ui lsp-treemacs lsp-ivy company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
