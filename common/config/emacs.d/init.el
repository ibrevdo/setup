

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
              set-mark-command-repeat-pop t)

(setq recentf-max-saved-items 1000)
(recentf-mode)
(global-set-key (kbd "C-c r") 'recentf)

(global-set-key (kbd "C-c p") 'find-file-at-point)

;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(setq whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark))

(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)

;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")

;;; vertico
(rc/require 'vertico 'marginalia)
(vertico-mode)
(marginalia-mode)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; iedit
(rc/require 'iedit)
(global-set-key (kbd "C-;") 'iedit-mode)

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

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

(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "<f5>" 'rc/run-py-file))))

(require 'ansi-color)
(defun rc/colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'rc/colorize-compilation-buffer)


;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)

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


(rc/require
 'cmake-mode
 'yaml-mode)

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
