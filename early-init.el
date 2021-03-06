;;; early-init.el --- Early startup tweaks -*- lexical-binding:t ; -*-

;;; Cleaner UI
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)

;;; Bootstrap straight.el
(setq
 package-enable-at-startup       nil
 straight-repository-branch     "develop"
 straight-use-package-by-default t)
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

(provide 'early-init)

;;; early-init ends here
