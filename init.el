;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq mac-command-modifier 'meta
      ;;       mac-option-modifier 'control
      ns-function-modifier 'super)
(exec-path-from-shell-initialize)
(eval-when-compile
  (require 'use-package))
(setq custom-file "~/.emacs.d/custom/custom.el")
(load custom-file)
(add-to-list 'load-path "~/.emacs.d/custom/")
(load "core")
(load "golang")
(provide 'init)
