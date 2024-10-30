;;; org-export.el ---  -*- lexical-binding: t; -*-

(require 'ox-publish)

;;(setq org-export-with-toc nil)

(setq org-export-with-sub-superscripts '{}
      org-export-headline-levels 4
      org-export-with-section-numbers nil
      org-export-preserve-breaks t
      org-export-with-title t
      org-export-date-timestamp-format "%Y-%m-%d")
(setq org-html-doctype "html5"
      org-html-html5-fancy t
      org-html-checkbox-type 'html
      org-html-validation-link nil
      org-html-metadata-timestamp-format "%Y-%m-%d")
(setq org-html-head-include-default-style nil
      org-html-htmlize-output-type 'css)
(setq org-html-style
      (concat "<style type=\"text/css\">\n"
              (with-temp-buffer
                (insert-file-contents
                 (locate-user-emacs-file "org-export/gray.css"))
                (buffer-string))
              "</style>\n"))


(provide 'org-export)
;;; org-export.el ends here
