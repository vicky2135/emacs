(setenv "GOPATH" "/Users/vikas.uikey/go")
(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet"))
  ; Go oracle
  ;(load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
  ; Godef jump key binding
  (local-set-key [?\M-.] 'godef-jump)
  (local-set-key [?\M-,] 'pop-tag-mark)
  (local-set-key (kbd "M-p") 'compile)            ; Invoke compiler
  (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
  (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
  (local-set-key (kbd "M-[") 'previous-error)
  (go-guru-hl-identifier-mode t)
)

(defun jc/go-guru-set-current-package-as-main ()
    "GoGuru requires the scope to be set to a go package which
     contains a main, this function will make the current package the
     active go guru scope, assuming it contains a main"
    (interactive)
    (let* ((filename (buffer-file-name))
           (gopath-src-path (concat (file-name-as-directory (go-guess-gopath)) "/Users/vikas.uikey/go/src/bitbucket.org/kyc-agent"))
           (relative-package-path (directory-file-name (file-name-directory (file-relative-name filename gopath-src-path)))))
      (setq go-guru-scope relative-package-path)))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'go-mode-hook 'jc/go-guru-set-current-package-as-main)
(require 'go-projectile)
(add-hook 'after-init-hook #'global-flycheck-mode)
(defun auto-complete-for-go ()
(auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

;; gotests
(load "~/.emacs.d/gotests.el")
(require 'gotest)

(with-eval-after-load 'go-mode
  (define-key go-mode-map (kbd "C-c t") #'go-tag-add)
  (define-key go-mode-map (kbd "C-c T") #'go-tag-remove))

(provide 'golang)
