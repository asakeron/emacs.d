;;; early-init.el --- Early startup tweaks -*- lexical-binding:t ; -*-

;;; Commentary:
;; The early startup process setups the package manager and
;; make changes to the UI before it initializes.
;; no-littering is also setup very early.

;;; Code:

(setq-default
 straight-repository-branch      "develop"
 straight-use-package-by-default t
 package-enable-at-startup       nil
 inhibit-startup-screen          t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

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

(use-package doom-themes
  :hook
  '(org-mode . doom-themes-org-config)
  :init
  (setq
   doom-themes-enable-bold   t
   doom-themes-enable-italic t)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (load-theme 'doom-one t))

(provide 'early-init)

;;; early-init ends here
