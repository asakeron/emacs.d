;;; init.el --- emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Reproducible Emacs configuration using straight.el

;;; Code:

;;; vim emulation
;; * evil:            provides modal editing
;; * evil-collection: binds vimish keys standard Emacs modes
;; * vimish-fold:     provide universal folding vim-style

(use-package all-the-icons)

(use-package dired-sidebar
  ;:config
  ;(setq
  ; dired-sidebar-theme 'all-the-icons)
  :commands
  (dired-sidebar-toggle-sidebar))

(use-package all-the-icons-dired
  :after
  all-the-icons
  :hook
  '(dired-mode . all-the-icons-dired-mode))

(use-package centaur-tabs
  :after
  all-the-icons
  :init
  (setq
   centaur-tabs-style               "bar"
   centaur-tabs-set-bar             'left
   centaur-tabs-set-icons           t
   centaur-tabs-gray-out-icons      'buffer
   centaur-tabs-set-modified-marker t
   centaur-tabs-modified-marker     "●")
  :hook
  '(after-init . (lambda ()
		   (centaur-tabs-mode t)
		   (centaur-tabs-headline-match))))

(use-package evil
  :init
  (setq
   evil-want-keybinding nil)
   :config
  (evil-mode +1))

(use-package evil-collection
  :after
  evil
 :config
  (evil-collection-init))

(use-package vimish-fold
  :after
  evil)

(use-package evil-vimish-fold
  :after
  vimish-fold
  :hook
  '(prog-mode . evil-vimish-fold-mode))

(use-package ivy
  :config
  (ivy-mode +1))

;;; Programming environment
;; Emacs already includes packages for hacking code. They are enabled
;; in prog-mode and tweaked. The main points are:
;; * Display relative line numbers for comvenient navigation with
;;   vim keys;
;; * Highlight possible mistakes using whitespace-mode, flymake,
;;   fill-column indicator, etc;
;; * Use whitespace for indentation by default;
;; * Use eglot as LSP client for all languages providing accessible
;;   servers;

(defconst me/max-column 100)
(defconst me/tab-width  2)
(add-hook 'prog-mode-hook #'show-paren-mode)

(use-package display-line-numbers
  :hook
  '(prog-mode . display-line-numbers-mode)
  :init
  (setq
   display-line-numbers-type 'relative))

(use-package whitespace-mode
  :hook
  '(prog-mode . whitespace-mode)
  :init
  (setq
   indent-tabs-mode nil
   tab-width        me/tab-width
   whitespace-style '(face trailing tabs)))

(use-package display-fill-column-indicator
  :hook
  '(prog-mode . display-fill-column-indicator-mode)
  :init
  (setq
   fill-column (+ me/max-column 1)))

(use-package rainbow-delimiters
  :hook
  '(prog-mode . rainbow-delimiters-mode))

(use-package flymake
  :hook
  '(prog-mode . flymake-mode))

(use-package vterm
  :defer
  t
  :commands
  'vterm)

(use-package git-gutter
  :config
  (global-git-gutter-mode +1))

(use-package eglot)

(use-package js2-mode
  :after
  eglot
  :mode
  "\\.js\\'"
  :hook
  '(js2-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(js2-mode . ("npx"
                             "typescript-language-server"
                             "--stdio"))))

(use-package typescript-mode
  :after
  eglot
  :mode
  "\\.ts\\'"
  :hook
  '(typescript-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(typescript-mode . ("npx"
                                    "typescript-language-server"
                                    "--stdio"))))

(use-package mhtml-mode
  :after
  eglot
  :mode
  "\\.html\\'"
  :hook
  '(mhtml-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(mhtml-mode . ("npx"
                               "vscode-html-languageserver-bin"
                               "--stdio"))))

(use-package css-mode
  :after
  eglot
  :mode
  "\\.css'"
  :hook
  '('css-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(css-mode . ("npx"
                             "vscode-css-languageserver-bin"
                             "--stdio"))))

(use-package json-mode
  :after
  eglot
  :mode
  "\\.json'"
  :hook
  '(json-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(json-mode . ("npx"
                              "vscode-json-languageserver-bin"
                              "--stdio"))))

(use-package yaml-mode
  :after
  eglot
  :mode
  "\\.yaml'"
  :hook
  '(yaml-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
	       '(yaml-mode . ("npx"
			      "yaml-language-server"
			      "--stdio"))))

(use-package web-mode
  :after
  eglot
  :mode
  "\\.tsx\\'"
  :hook
  '(web-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(web-mode . ("npx"
                             "typescript-language-server"
                             "--stdio")))
  :init
  (setq
   web-mode-markup-indent-offset me/tab-width
   web-mode-css-indent-offset    me/tab-width
   web-mode-code-indent-offset   me/tab-width))

(provide 'init)

;;; init.el ends here
