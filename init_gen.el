(require 'package)
(setopt package-user-dir (concat user-emacs-directory "/elpa")
	package-enable-at-startup nil
	package-archives '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
			   ("Non-Gnu ELPA" . "https://elpa.nongnu.org/nongnu/")
			   ("MELPA Stable" . "https://stable.melpa.org/packages/")
			   ("MELPA Now"    . "https://melpa.org/packages/"))
	package-archive-priorities '(("GNU ELPA"     . 100)
				     ("Non-Gnu ELPA" . 50)
				     ("MELPA Stable" . 45)
				     ("MELPA Now"    . 20))
	package-gnupghome-dir (concat user-emacs-directory "/elpa/gnupg")
	use-package-compute-statistics t)
(package-initialize t)
;; 
(dolist (pkg '(async
	       ace-window
	       shrink-path
	       consult
	       marginalia
	       vertico
	       orderless
	       theme-anchor
	       svg-tag-mode
	       doom-modeline
	       base16-theme
	       eat
	       eshell-git-prompt
	       helpful
	       rainbow-delimiters
	       lin
	       dash
	       treesit-auto
	       corfu
	       logview
	       yasnippet
	       yasnippet-snippets
	       magit
	       lispy
	       zenburn-theme
	       sly
	       geiser
	       racket-mode
	       cider
	       ess
	       rust-mode
	       haskell-mode
	       scala-repl
	       apropospriate-theme
	       org-superstar))
  (package-install pkg))

(package-vc-install "https://github.com/nverno/r-ts-mode")
(package-vc-install "https://github.com/jdtsmith/eglot-booster")

;; We need org in order to make use of the tangling functionality
(require 'org)
;; Open the org-mode configuration
(defvar src-readme-org (concat user-emacs-directory "README.org"))
;; Tangle the file
(org-babel-tangle-file src-readme-org)
;; init_gen.el ends here
