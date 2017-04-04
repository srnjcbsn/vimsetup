;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     erlang
     php
     javascript
     go
     windows-scripts
     html
     fsharp
     csv
     (markdown :variables markdown-live-preview-engine 'vmd)
     ranger
     gtags
     colors
     syntax-checking
     version-control
     git
     auto-completion
     theming
     ;; Languages
     clojure
     emacs-lisp
     haskell
     python
     nixos
     docker
     yaml
     elixir
     elm
     )
   dotspacemacs-additional-packages
   '(cython-mode
     flycheck-cython
     lfe-mode)
   dotspacemacs-excluded-packages
   '(smartparens
     yasnippet)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-startup-banner 'nil
   dotspacemacs-startup-lists '(recents projects bookmarks)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-themes '(material
                         gruvbox
                         spacemacs-light
                         spacemacs-dark
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   dotspacemacs-default-font '("Source Code Pro"
                               ;; "Input Mono Narrow"
                               :size 17
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-command-key ":"
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-persistent-server t
   ))

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-config ()
  (setq powerline-default-separator 'nil)
  (setq x-meta-keysym 'super)
  (setq x-super-keysym 'meta)
  (require 'flycheck-cython)
  (add-hook 'cython-mode-hook 'flycheck-mode)
  ;; scroll two lines at a time
  (setq mouse-wheel-scroll-amount '(2 ((shift) . 1)))
  ;; don't accelerate scrolling
  (setq mouse-wheel-progressive-speed nil)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (spaceline-compile)
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:underline "Red1"))))
 '(flycheck-info ((t (:underline "ForestGreen"))))
 '(flycheck-warning ((t (:underline "DarkOrange")))))
