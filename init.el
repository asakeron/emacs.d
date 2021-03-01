;;; init.el --- emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Reproducible Emacs configuration using straight.el

;;; Code:

(fset 'yes-or-no-p 'y-or-n-p)

(use-package evil
  :init
  (evil-mode +1))

(use-package doom-modeline
  :hook
  '(after-init . doom-modeline-mode))

;;; Programming environments

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

(use-package eglot)

;; Javascript
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
;; Typescript
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
;; HTML
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

;; CSS
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

;;; Data formats

;; JSON
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

;; YAML
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

(provide 'init)

;;; init.el ends here
