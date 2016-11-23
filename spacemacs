;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     htmlauto-completion
     ranger
     gtags
     colors
     syntax-checking
     version-control
     git
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
     flycheck-cython)
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
   dotspacemacs-themes '(gruvbox
                         spacemacs-light
                         spacemacs-dark
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   dotspacemacs-default-font '("Consolas"
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
