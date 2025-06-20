;;; lkg-org-face.el ---    -*- lexical-binding: t; coding: utf-8 -*-

;; Keywords: 

;; Author:     Kiong-Gē Liāu <lkg@KiongLtp2>
;; Copyright:  © 2025, Kiong-Gē Liāu, all rights reserved.
;; Created:    2025-06-19 21:32:00 -0500
;; Updated:    2025-06-19 Thu 22:39:54-05:00 by Kiong-Gē Liāu

;; This file is NOT part of GNU Emacs
;; This program is free software; you can redistribute it ano/or modify
;; it under the terms oqf the GNU General Public License as published by
;; the Free Software Foundation; either version 3 or later
;; 
;; This program is distributed in the hope that it will be useful
;; but WTTHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program, if not, see <https://www.gnu.org/license/>.

;;; Commentary:
;;
;;  

;;
;;; Code:
(require 'org)
(require 'svg-tag)
(require 'prog-mode)

(defvar lkg-basic-face
  '((variable-pitch ((t (:family "Linux Libertine O"))))
    (fixed-pitch ((t ( :family "Fira Code"))))
    (org-code ((t (:inherit (shadow fixed-pitch)))))
    (org-block ((t (:inherit org-code :background "#efefd3" :extend t) )))
    (org-block-begin-line ((t (:inherit org-block))))
    (org-block-end-line ((t (:inherit org-block))))
    (org-document-info ((t (:foreground "dark orange"))))
    (org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
    (org-indent ((t (:inherit (org-hide fixed-pitch)))))
    (org-link ((t (:foreground "royal blue" :underline t))))
    (org-meta-line ((t (:inherit (shadow fixed-pitch)))))
    (org-property-value ((t (:inherit fixed-pitch))) t)
    (org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
    (org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
    (org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
    (org-verbatim ((t (:inherit (shadow fixed-pitch)))))
    (org-hdrfc ((t (:inherit fixed-pitch :weight bold))))
    (org-level-8 ((t (:inherit org-hdrfc :height 1.0  :foreground "snow3"))))
    (org-level-7 ((t (:inherit org-hdrfc :height 1.0  :foreground "DarkSalmon"))))
    (org-level-6 ((t (:inherit org-hdrfc :height 1.0  :foreground "SlateBlue"))))
    (org-level-5 ((t (:inherit org-hdrfc :height 1.1  :foreground "SeasGreen"))))
    (org-level-4 ((t (:inherit org-hdrfc :height 1.2  :foreground "RoyalBlue"))))
    (org-level-3 ((t (:inherit org-hdrfc :height 1.4  :foreground "DarkCyan"))))
    (org-level-2 ((t (:inherit org-hdrfc :height 1.6  :foreground "DarkOrange2"))))
    (org-level-1 ((t (:inherit org-hdrfc :height 1.75 :foreground "DarkOrchid2"))))
    (org-document-title ((t (:inherit org-hdrfc :height 2.0 :foreground "maroon"))))))
;;
(defvar lkg-org-prettify-symbols-alist
  '(("[ ]" . "")
    ("[X]" . "")
    ("[-]" . "" )
    ("#+BEGIN_SRC" . ?≫)
    ("#+END_SRC" . ?≫)
    ("#+begin_src" . ?≫)
    ("#+end_src" . ?≫)
    ("#+BEGIN_QUOTE" . ?❝)
    ("#+END_QUOTE" . ?❞)
    (":work:"     . "")
    (":inbox:"    . "")
    (":task:"     . "")
    (":thesis:"   . "")
    (":uio:"      . "")
    (":emacs:"    . "")
    (":learn:"    . "")
    (":code:"     . "")))
;; 
(defvar lkg-org-tag-pttrns
  `(;; TODO / DONE
    ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0))))
    ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :inverse t :margin 0))))
    ;; Task priority
    ("\\[#[A-Z]\\]" . ( (lambda (tag)
                          (svg-tag-make tag :face 'org-priority
                                        :beg 2 :end -1 :margin 0))))
    ;; Progress
    ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                        (svg-progress-percent (substring tag 1 -2)))))
    ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
  				    (svg-progress-count (substring tag 1 -1)))))
    ;; Citation of the form [cite:@Knuth:1984]
    ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
  				    (svg-tag-make tag
                                                    :inverse t
                                                    :beg 7 :end -1
                                                    :crop-right t))))
    ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                               (svg-tag-make tag
                                                             :end -1
                                                             :crop-left t)))) 
    ;; Active date (with or without day name, with or without time)
    (,(format "\\(<%s>\\)" date-re) .
     ((lambda (tag)
        (svg-tag-make tag :beg 1 :end -1 :margin 0))))
    (,(format "\\(<%s \\)%s>" date-re day-time-re) .
     ((lambda (tag)
        (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
    (,(format "<%s \\(%s>\\)" date-re day-time-re) .
     ((lambda (tag)
        (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

    ;; Inactive date  (with or without day name, with or without time)
    (,(format "\\(\\[%s\\]\\)" date-re) .
     ((lambda (tag)
        (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
    (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
     ((lambda (tag)
        (svg-tag-make tag :beg 1 :inverse nil
  		    :crop-right t :margin 0 :face 'org-date))))
    (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
     ((lambda (tag)
        (svg-tag-make tag :end -1 :inverse t
  		    :crop-left t :margin 0 :face 'org-date))))))
;; 
(defun lkg-org-face-set ()
  "Org mode hook top level."
  (interactive)
  (with-current-buffer (current-buffer)
    (setq-local prettify-symbols-alist lkg-org-prettify-symbols-alist)
    (setq-local svg-tag-tags lkg-org-tag-pttrns)
    (dolist (spec lkg-basic-face)
      (face-remap-set-base (car spec)
  			 (face-spec-choose (nth 1 spec))))
    (prettify-symbols-mode t)
    (svg-tag-mode t)))
;;
;; (if (display-graphic-p)
;;     (add-hook 'org-mode-hook 'lkg-org-face-set 90))

(provide 'lkg-org-face)
;;; lkg-org-face.el ends here
