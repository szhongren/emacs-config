(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; theme
(require 'cyberpunk-theme)

;; auto-complete!
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; helm
(require 'helm-config)
(require 'helm-themes)
(helm-mode 1)
(global-set-key (kbd "C-c h") 'helm-mini)

;; ac-helm interface
(global-set-key (kbd "C-;") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-;") 'ac-complete-with-helm)

;; helm-ls-git, lists files in curr git dir
(require 'helm-ls-git)
(global-set-key (kbd "C-c g") 'helm-ls-git-ls)

;; helm dash, offline api documentation
(require 'helm-dash)
(global-set-key (kbd "C-c d") 'helm-dash)
(add-to-list 'helm-dash-common-docsets '"C")
(add-to-list 'helm-dash-common-docsets '"C++")
(add-to-list 'helm-dash-common-docsets '"Python 2")
(add-to-list 'helm-dash-common-docsets '"Bash")
(add-to-list 'helm-dash-common-docsets '"HTML")
(add-to-list 'helm-dash-common-docsets '"CSS")
(add-to-list 'helm-dash-common-docsets '"Javascript")

;; git-timemachine, goes though commits for a certan file
(global-set-key (kbd "C-c t") 'git-timemachine)

;; function-args, displays signature for a function when called
(fa-config-default)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(global-set-key (kbd "C-c f") 'fa-show)

;; auto-complete c-headers
(defun my:ac-c-header-init ()
  ;; needs both for some weird reason, the second one only breaks the auto-complete completely, while first one cannot add custom include dirs
  (require 'ac-c-headers)
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-header-symbols t)
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-pc-cygwin/4.8.3/include/c++")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-pc-cygwin/4.8.3/include/c++/x86_64-pc-cygwin")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-pc-cygwin/4.8.3/include/c++/backward")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-pc-cygwin/4.8.3/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-pc-cygwin/4.8.3/include-fixed")
  (add-to-list 'achead:include-directories '"/usr/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-pc-cygwin/4.8.3/../../../../lib/../include/w32api")
  )
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; ac-anaconda, anaconda source for ac
(add-to-list 'ac-sources 'ac-sources-anaconda)
(add-hook 'python-mode-hook 'ac-anaconda-setup)
(add-hook 'python-mode-hook 'anaconda-mode)

;; semantic mode
(semantic-mode 1)
(defun my:ac-semantic-init ()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:ac-semantic-init)
(global-semantic-idle-scheduler-mode 1)

;; jedi config
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)   

;; helm-google, searches google in helm
(global-set-key (kbd "C-h C-g") 'helm-google)

;; smooth scrolling
(require 'smooth-scrolling)

;; column-enforce-mode
(require 'column-enforce-mode)
(global-column-enforce-mode t)

;; display theme
(global-display-theme-mode 1)

;; highlight curr line
(require 'highlight-current-line)

;; highlight parens
(require 'highlight-parentheses)

;; color identified vars
(add-hook 'after-init-hook 'global-color-identifiers-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.4)
 '(ac-auto-start 1)
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode c-mode cc-mode c++-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode less-css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode ts-mode sclang-mode verilog-mode qml-mode text-mode fundamental-mode)))
 '(browse-url-browser-function (quote browse-url-text-emacs))
 '(browse-url-text-browser "lynx")
 '(column-number-mode 1)
 '(global-highlight-parentheses-mode t)
 '(highlight-current-line-globally t nil (highlight-current-line))
 '(hl-paren-background-colors (quote ("brightblack")))
 '(paradox-github-token t)
 '(show-paren-mode t)
 '(standard-indent 3))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-current-line-face ((t (:underline t)))))
