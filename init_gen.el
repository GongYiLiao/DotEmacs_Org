;; 

;; We need org in order to make use of the tangling functionality
(require 'org)
;; Open the org-mode configuration
(defvar src-readme-org (concat user-emacs-directory "README.org"))
;; Tangle the file
(org-babel-tangle-file src-readme-org)
;; init_gen.el ends here
