;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(typescript
     perl5
     ivy
     rust
     erlang
     php
     javascript
     go
     windows-scripts
     html
     fsharp
     csv
     (markdown :variables markdown-live-preview-engine 'eww)
     ranger
     gtags
     colors
     syntax-checking
     version-control
     git
     auto-completion
     theming
     semantic
     imenu-list
     ;; Languages
     shell-scripts
     systemd
     clojure
     emacs-lisp
     haskell
     python
     nixos
     docker
     yaml
     elixir
     elm
     latex
     ansible
     terraform
     csharp
     groovy
     smex
     )
   dotspacemacs-additional-packages
   '(cython-mode
     flycheck-cython
     lfe-mode
     git-gutter+
     git-gutter-fringe+)
   dotspacemacs-excluded-packages
   '(smartparens
     yasnippet
     evil-escape)
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
                         spacemacs-light
                         spacemacs-dark
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   dotspacemacs-default-font '("Pragmata Pro"
                               :size 16
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
   rust-format-on-save t
   ))

(defun dotspacemacs/user-init ()
  (push '("melpa-stable" . "stable.melpa.org/packages/") configuration-layer--elpa-archives)
  (push '(use-package . "melpa-stable") package-pinned-packages))

(defun dotspacemacs/user-config ()
  (custom-set-faces (if (not window-system) '(default ((t (:background "nil"))))))
  (setq powerline-default-separator 'bar)
  (setq spaceline-window-numbers-unicode 'nil)
  (setq spaceline-workspace-numbers-unicode 'nil)
  (setq dotspacemacs-mode-line-unicode-symbols 'nil)
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
  (setq flycheck-python-shell-interpreter "python3")
  (setq flycheck-python-pylint-executable "pylint3")
  (setq flycheck-python-pycompile-executable "python3")
  (setq flycheck-python-flake8-executable "flake8"))

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
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (insert-shebang flycheck-bashate fish-mode company-shell zenburn-theme yasnippet-snippets yapfify yaml-mode ws-butler winum which-key wgrep web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toml-mode toc-org tide tagedit systemd symon string-inflection stickyfunc-enhance srefactor spaceline-all-the-icons solarized-theme smex smeargle slim-mode scss-mode sayid sass-mode restart-emacs request ranger rainbow-mode rainbow-identifiers rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode powershell popwin pippel pipenv pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pcre2el password-generator paradox overseer org-bullets open-junk-file omnisharp ob-elixir nix-mode neotree nameless move-text monokai-theme mmm-mode material-theme markdown-toc magit-svn magit-gitflow macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint lfe-mode less-css-mode json-navigator js2-refactor js-doc jinja2-mode ivy-yasnippet ivy-xref ivy-purpose ivy-hydra intero indent-guide importmagic impatient-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation helm-make haskell-snippets groovy-mode groovy-imports google-translate golden-ratio godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc gitignore-templates gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md ggtags fuzzy fsharp-mode font-lock+ flycheck-rust flycheck-pos-tip flycheck-mix flycheck-haskell flycheck-elm flycheck-cython flycheck-credo flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-cleverparens evil-args evil-anzu erlang emmet-mode elm-mode elisp-slime-nav editorconfig dumb-jump drupal-mode dotenv-mode dockerfile-mode docker diminish diff-hl define-word dante cython-mode csv-mode counsel-projectile counsel-gtags counsel-css company-web company-terraform company-tern company-statistics company-plsense company-php company-nixos-options company-go company-ghci company-ghc company-cabal company-auctex company-ansible company-anaconda column-enforce-mode color-identifiers-mode cmm-mode clojure-snippets clojure-cheatsheet clj-refactor clean-aindent-mode cider-eval-sexp-fu centered-cursor-mode cargo browse-at-remote auto-yasnippet auto-highlight-symbol auto-compile ansible-doc ansible alchemist aggressive-indent ace-window ace-link ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:underline "Red1"))))
 '(flycheck-info ((t (:underline "ForestGreen"))))
 '(flycheck-warning ((t (:underline "DarkOrange")))))
)
