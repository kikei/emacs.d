(if (file-readable-p "./secrets.el")
    (load-file "./secrets.el"))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (parse-colon-path (getenv "PATH")))

(require `package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(if (eq system-type 'darwin)
    (progn
      (add-to-list 'default-frame-alist '(font . "Menlo 15"))
      (set-face-attribute 'default t :font "Menlo 15")
      (set-frame-font "Menlo 15" nil t)
      ; Command key as Meta key in MacOS
      (setq mac-command-modifier 'meta)
      (setq browse-url-browser-function 'browse-url-generic
	    browse-url-generic-program
	    "/Applications/Vivaldi.app/Contents/MacOS/Vivaldi")))


(add-to-list 'load-path "~/.emacs.d/site-lisp")

; backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; (message "Deleting old backup files...")
;; (let ((week (* 60 60 24 7))
;;       (current (float-time (current-time))))
;;   (dolist (file (directory-files temporary-file-directory t))
;;     (when (and (backup-file-name-p file)
;;                (> (- current (float-time (fifth (file-attributes file))))
;;                   week))
;;       (message "%s" file)
;;       (delete-file file))))

; window size
(setq initial-frame-alist
      (append (list '(width . 80) '(height . 77))
	      initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

; kill
(setq kill-whole-line t)

; scroll
(setq scroll-step 1)

; highlight paired parentheses
(show-paren-mode 1)

;; Insert date
(defun insert-date ()
  (interactive)
  (insert (concat
           "" (format-time-string "%Y-%m-%d"))))

;; Insert file name
(defun insert-buffer-file-name ()
  (interactive)
  (insert (buffer-file-name)))

;; Toggle indent-tabs-mode
(defun toggle-indent-mode ()
  (interactive)
  (setq indent-tabs-mode (not indent-tabs-mode))
  (message (concat "indent with " (if indent-tabs-mode "tabs" "spaces"))))

(setq c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

(add-hook 'shell-script-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)))

; Java-mode
(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4
			          tab-width 4
				  indent-tabs-mode nil)))

; Javascript mode
(add-hook 'javascript-mode-hook 
	  (lambda ()
	    (setq c-basic-offset 4
		  indent-tabs-mode nil
		  js-indent-level 4
		  tab-width 4)))

; ActionScript mode
(autoload 'actionscript-mode
  "actionscript-mode-haas-7.0" "Action Script mode" t)

(add-hook 'actionscript-mode-hook
	  (lambda ()
	    (setq c-basic-offset 4
		  tab-width 4
		  indent-tabs-mode t)))

; Python mode
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4
                  python-indent 4
                  indent-tabs-mode nil)))

; markdown mode
;; (autoload 'markdown-mode "markdown-mode"
;;   "Major mode for editing Markdown files" t)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$\\|\\.yaml$" . yaml-mode))

; File and major mode
(setq auto-mode-alist
      (append auto-mode-alist
	      '(("\\.as$" . java-mode)
                ("\\.perl$\\|\\.p[hlm]$\\|/perl/" . perl-mode)
		("\\.el$\\|\\.emacs$" . elisp-mode)
		("\\.txt$\\|\\.markdown$\\|\\.md$" . markdown-mode))))

; Key bind
(global-set-key (kbd "C-h")	'backward-delete-char)
(global-set-key (kbd "\M-?")	'help-for-help)
(global-set-key (kbd "<f1>")    'help-for-help)
(global-set-key (kbd "M-SPC")	'just-one-space)
(global-set-key (kbd "C-x a")	'align-regexp)
(global-set-key (kbd "C-c ;")	'comment-region)
(global-set-key (kbd "C-c :")	'uncomment-region)
(global-set-key (kbd "C-c c")	'compile)
(global-set-key (kbd "C-c d")   'describe-char)
(global-set-key (kbd "C-c b")   'browse-url-of-file)
(global-set-key (kbd "C-c g")	'goto-line)
(global-set-key (kbd "C-c C-d") 'insert-date)
(global-set-key (kbd "C-c C-f") 'insert-buffer-file-name)
(global-set-key (kbd "C-c C-t") 'toggle-indent-mode)

(global-set-key (kbd "C-+")	'text-scale-adjust)
(global-set-key (kbd "C-x r e") 'revert-buffer)
(global-set-key (kbd "C-{")     'backward-sexp)
(global-set-key (kbd "C-}")     'forward-sexp)

(put 'downcase-region 'disabled nil)
