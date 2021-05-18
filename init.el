(linum-mode t)
(show-paren-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq completion-ignore-case  t)
(setq read-file-name-completion-ignore-case  t)
(setq linum-format (quote "%4d  "))
(setq cperl-auto-newline nil)
(setq cperl-autoindent-on-semi nil)
(setq cperl-auto-newline-after-colon nil)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(set-face-foreground 'linum "dark blue")

(add-to-list 'auto-mode-alist '("\\.\\(t\\)\\'" . cperl-mode))
(defalias 'perl-mode 'cperl-mode)

;; (setq display-buffer-base-action '(display-buffer-in-tab))
;; (require 'uniquify)
;; (setq uniquify-buffer-name-style 'reverse)

(setq verilog-auto-newline nil)
(global-set-key (kbd "C-;") nil)
(global-set-key (kbd "C-\\") nil)
(global-set-key (kbd "C-\\") 'er/expand-region)
;;(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "C-M-i") 'iedit-mode)

(add-to-list 'load-path "/opt/otrs/.emacs.d/stuff")
(add-to-list 'load-path "/opt/otrs/.emacs.d/pde/lisp")
(load "pde-load")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;--;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;;--;; and `package-pinned-packages`. Most users will not need or want to do this.
;;--;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;--(package-initialize)
;;--(custom-set-variables
;;-- ;; custom-set-variables was added by Custom.
;;-- ;; If you edit it by hand, you could mess it up, so be careful.
;;-- ;; Your init file should contain only one such instance.
;;-- ;; If there is more than one, they won't work right.
;;-- '(package-selected-packages '(iedit)))
;;--(custom-set-faces
;;-- ;; custom-set-faces was added by Custom.
;;-- ;; If you edit it by hand, you could mess it up, so be careful.
;;-- ;; Your init file should contain only one such instance.
;;-- ;; If there is more than one, they won't work right.
;;-- )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages '(expand-region iedit))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)

;; (require 'auto-install)
;; (auto-install-from-url "https://raw.github.com/aki2o/emacs-plsense/master/plsense.el")

;; (require 'plsense)

;; Key binding
;; (setq plsense-popup-help-key "C-:")
;; (setq plsense-display-help-buffer-key "M-:")
;; (setq plsense-jump-to-definition-key "C->")

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "plsense")

;; Do setting recommemded configuration
;; (plsense-config-default)
(plsense-direx:config-default)
(put 'upcase-region 'disabled nil)

(defun create-tags()
  "Create tags file."
  (eshell-command 
   (format "find . -type f -regex '.*\\(p[ml]\\|js\\)$' -not -path './.git/*' -not -path './.vim/*' -not -path './.emacs.d/*' -not -path '*/node_modules/*' -not -path '*/thirdparty/*' | xargs etags --append")))
