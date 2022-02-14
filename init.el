(setq indent-line-function 'insert-tab)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(add-to-list 'auto-mode-alist '("\\.\\(t\\)\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.\\(tt\\)\\'" . sgml-mode))
(defalias 'perl-mode 'cperl-mode)

(add-to-list 'load-path "~/.emacs.d/stuff")
(add-to-list 'load-path "~/.emacs.d/pde/lisp")
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
 '(cperl-auto-newline nil)
 '(cperl-auto-newline-after-colon nil)
 '(cperl-autoindent-on-semi nil)
 '(find-file-suppress-same-file-warnings t)
 '(global-linum-mode t)
 '(grep-command "grep -rl ")
 '(grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules" "tmp" "*.swp" "log"))
 '(grep-find-ignored-files
   '(".#*" "*.o" "*~" "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg" "*.bbl" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo" "*.swp"))
 '(grep-search-path '(nil "~/"))
 '(indent-tabs-mode nil)
 '(linum-format "%4d ")
 '(mouse-wheel-scroll-amount '(1 ((shift) . 1) ((meta)) ((control) . text-scale)))
 '(package-selected-packages '(helm magit expand-region iedit))
 '(read-buffer-completion-ignore-case t)
 '(read-file-name-completion-ignore-case t)
 '(show-paren-mode t)
 '(tab-width 4)
 '(truncate-lines t)
 '(uniquify-buffer-name-style 'forward nil (uniquify))
 '(uniquify-min-dir-content 2)
 '(word-wrap t))
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
(put 'set-goal-column 'disabled nil)

(global-set-key (kbd "C-;") nil)
(global-set-key (kbd "C-\\") nil)
(global-set-key (kbd "<C-left>") nil)
(global-set-key (kbd "<C-right>") nil)

(global-set-key (kbd "C-\\") 'er/expand-region)
(global-set-key (kbd "C-M-i") 'iedit-mode)
(global-set-key (kbd "<C-left>") 'backward-sexp)
(global-set-key (kbd "<C-right>") 'forward-sexp)

(set-face-foreground 'linum "dark blue")
(ac-config-default)
