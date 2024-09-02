;; init.el --- emacs init file -*- lexical-binding: t; -*-
;;; Commentary:
;; ibrevdo
;;; Code: test

(require 'server)
(unless (server-running-p)
  (server-start))

(package-initialize)

(load "~/.emacs.d/rc.el")

;;; Appearance
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "Iosevka-13")))

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

;; (rc/require-theme 'gruber-darker)
;; (load-theme 'adwaita t)

(when (eq system-type 'gnu/linux)
  (load-theme 'modus-operandi))

(when (eq system-type 'windows-nt)
  (rc/require-theme 'zenburn))

(eval-after-load 'zenburn
  (set-face-attribute 'line-number nil :inherit 'default))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
;;(global-auto-revert-mode 1)
(delete-selection-mode)
(save-place-mode 1)
(savehist-mode 1)
(pixel-scroll-precision-mode)
(global-display-line-numbers-mode)


(setq-default inhibit-splash-screen t
              make-backup-files nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t
              buffer-file-coding-system 'utf-8-unix
              default-input-method "hebrew"
              visible-bell (equal system-type 'windows-nt)
              use-short-answers t
              search-whitespace-regexp ".*?"
              vc-follow-symlinks t
              set-mark-command-repeat-pop t
              confirm-kill-emacs 'y-or-n-p)

;;; completion
(setq completion-auto-select nil
      ;; tab-always-indent 'complete
      ;; completion-auto-select 'second-tab
      completions-max-height 20
      completions-header-format nil
      completions-format 'one-column
      )

(setq recentf-max-saved-items 1000)
(recentf-mode)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c o r") 'recentf)
(global-set-key (kbd "C-c o f") 'find-file-at-point)
(global-set-key (kbd "C-c t SPC") 'whitespace-mode)
(global-set-key (kbd "C-c t s") 'flyspell-mode)
(global-set-key (kbd "C-c t l") 'hl-line-mode)
(global-set-key (kbd "C-c t f") 'display-fill-column-indicator-mode)
(global-set-key (kbd "C-,") 'duplicate-dwim)
(global-set-key (kbd "M-s g") 'deadgrep)

(defun rc/revert-this-buffer ()
  (interactive)
  (revert-buffer nil t t)
  (message (concat "Reverted buffer " (buffer-name))))
(global-set-key (kbd "C-x C-r") 'rc/revert-this-buffer)

(defun rc/switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))
(global-set-key (kbd "C-z") 'rc/switch-to-previous-buffer)

;;; Windmove
(setq windmove-create-window t)
(global-set-key (kbd "C-x w b") 'windmove-left)
(global-set-key (kbd "C-x w n") 'windmove-down)
(global-set-key (kbd "C-x w p") 'windmove-up)
(global-set-key (kbd "C-x w f") 'windmove-right)
(global-set-key (kbd "C-x w B") 'windmove-swap-states-left)
(global-set-key (kbd "C-x w N") 'windmove-swap-states-down)
(global-set-key (kbd "C-x w P") 'windmove-swap-states-up)
(global-set-key (kbd "C-x w F") 'windmove-swap-states-right)

;; ;;; Winner-mode
(setq winner-dont-bind-my-keys t)
(global-set-key (kbd "C-x w w") 'winner-undo)
(global-set-key (kbd "C-x w W") 'winner-redo)
(winner-mode)

;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-kill-when-opening-new-dired-buffer t)

;;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

(defun rc/run-py-file ()
  "Compile and run single python file"
  (interactive)
  (when-let ((file-name buffer-file-name)
             (python (if (executable-find "python3") "python3" "python")))
    (compile (concat python " " (shell-quote-argument file-name)))))

;;(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "<f5>" 'rc/run-py-file))))

;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))
(setq whitespace-style '(face trailing tabs tab-mark))
(add-hook 'prog-mode-hook 'rc/set-up-whitespace-handling)

(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)



;;; External packages
(rc/require
 'cmake-mode
 'yaml-mode
;; 'elpy
 'lua-mode
 'dockerfile-mode)

;;; deadgrep
(rc/require 'deadgrep)
(setq deadgrep-max-buffers 1)

;;; vertico
(rc/require 'vertico 'marginalia)
(vertico-mode)
(marginalia-mode)

;;; orderless
(rc/require 'orderless)
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;;; Move Text
(rc/require 'move-text)
(move-text-default-bindings)            ; M-up/down

;;; iedit
(rc/require 'iedit)
(global-set-key (kbd "C-;") 'iedit-mode)
(defun rc/iedit-dwim ()
  "Select a single thing for iedit-mode."
  (interactive)
  (iedit-mode 1))
(global-set-key (kbd "M-n") 'rc/iedit-dwim)
(global-set-key (kbd "M-p") 'rc/iedit-dwim)


;;; Expand region
(rc/require 'expand-region)
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;; Magit
;; magit requres this lib, but it is not installed automatically on Windows.
(rc/require 'cl-lib)
(rc/require 'magit)
(setq magit-ediff-dwim-show-on-hunks t)
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g l") 'magit-log)

;;; markdown mode
(rc/require 'markdown-mode)
(setq markdown-fontify-code-blocks-natively t)
(setq markdown-unordered-list-item-prefix "  - ")

;;; word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

;;(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; howm
(rc/require 'howm)
(require 'howm)

(setq howm-directory "~/igorba/git/info/notes/")   ; Path to the system files
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.md")
(setq howm-home-directory "~/igorba/git/info/notes/")
(setq howm-keyword-file (expand-file-name ".howm-keys" howm-home-directory))
(setq howm-history-file (expand-file-name ".howm-history" howm-home-directory))

(setq howm-view-keep-one-window t)   ; Buffer name will be according to title
(add-hook 'howm-mode-hook 'howm-mode-set-buffer-name)   ; Buffer name will be according to title
(add-hook 'after-save-hook 'howm-mode-set-buffer-name)

(setq howm-search-other-dir t)
(setq howm-search-path '("~/igorba/git/info/docs/"))

(setq howm-excluded-file-regexp
      (concat "\\.\\(docx\\|odt\\|ods\\|pdf\\)$\\|" howm-excluded-file-regexp))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(dash-functional dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;; init.el ends here
