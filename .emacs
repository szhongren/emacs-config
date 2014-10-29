(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; theme
(require 'monokai-theme)

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
(global-set-key (kbd "C-:") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)

;; auto-complete c-headers
(defun my:ac-c-header-init ()
  ;; needs both for some weird reason, the second one only breaks the auto-complete completely
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

;; smooth scrolling
(require 'smooth-scrolling)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.6)
 '(ac-auto-start 1)
 '(column-number-mode 1)
 '(paradox-github-token t)
 '(show-paren-mode t)
 '(standard-indent 3))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
