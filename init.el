;;; init.el --- emacs configuration -*- lexical-binding: t; -*-

(defun hook-when (ext action)
  "Combinator for describing a computation to be run in mode hooks.
ACTION is run when the file name matches EXT."
  #'(lambda ()
      (if (buffer-file-name)
	  (if (string-match ext buffer-file-name)
              (funcall action)))))

(fset 'yes-or-no-p 'y-or-n-p)

(use-package no-littering
  :init
  (setq
   no-littering-etc-directory "~/.local/emacs/etc/"
   no-littering-var-directory "~/.local/emacs/var/")
  (require 'no-littering)
  :config
  (setq
   auto-save-file-name-transforms
   `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))
   custom-file
   (no-littering-expand-etc-file-name "custom.el"))
  (with-eval-after-load 'recentf
    (add-to-list 'recentf-exclude no-littering-var-directory)
    (add-to-list 'recentf-exclude no-littering-etc-directory)))

(use-package ivy
  :config
  (ivy-mode +1))

;; Theme
(use-package doom-themes
  :hook
  '(org-mode . doom-themes-org-config)
  :hook
  '(after-init . (lambda ()
		   (load-theme 'doom-one t)))
  :init
  (setq
   doom-themes-enable-bold   t
   doom-themes-enable-italic t))

(use-package doom-modeline
  :hook
  '(after-init . doom-modeline-mode))

(use-package all-the-icons)

(use-package dired-sidebar
  :config
  (setq
   dired-sidebar-theme 'all-the-icons)
  :commands
  (dired-sidebar-toggle-sidebar))

(use-package all-the-icons-dired
  :after
  all-the-icons
  :hook
  '(dired-mode . all-the-icons-dired-mode))

;; Evil
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

;;; Programming

(defconst me/max-column 100)

(add-hook 'prog-mode-hook #'show-paren-mode)

(use-package editorconfig
  :hook
  '(after-init . editorconfig-mode))

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
(use-package apheleia
  :hook
  '(js2-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(js2-mode . ("npx"
                             "typescript-language-server"
                             "--stdio"))))
  '(after-init . apheleia-global-mode))

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
  :mode
  "\\.yml'"
  :hook
  '(yaml-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
	       '(yaml-mode . ("npx"
			      "yaml-language-server"
			      "--stdio"))))

;; .j|tsx
(use-package js
  :after
  eglot
  :mode
  ("\\.jsx\\'" . js-mode)
  :hook
  '(js-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
	       '(js-mode . ("npx"
			    "typescript-language-server"
			    "--stdio"))))

(use-package web-mode
  :after
  eglot
  :mode
  "\\.tsx\\'"
  :init
  (add-hook 'web-mode-hook
            (hook-when "\\.tsx\\'"
		       (lambda ()
                         (add-to-list 'eglot-server-programs
				      '(web-mode . ("npx"
					            "typescript-language-server"
                                                    "--stdio"))))))
  (add-hook 'web-mode-hook
	    (hook-when "\\.tsx\\'" 'eglot-ensure)))

(provide 'init)

;;; init.el ends here
