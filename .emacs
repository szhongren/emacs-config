(modify-frame-parameters nil '((wait-for-wm . nil)))
(require 'package)
(require 'json)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; auto-complete
(require 'auto-complete)
(add-to-list 'load-path "~/.emacs.d")    ; This may not be appeared if you have already added.
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20140824.1658/dict")
(require 'auto-complete-config)
(ac-config-default)

;; auto-complete for c headers
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (require 'ac-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-header-symbols t)
  (add-to-list 'achead:include-directories '"~/../../lib/gcc/x86_64-pc-cygwin/4.8.3/include")
  (add-to-list 'achead:include-directories '"~/../../usr/include")
)
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; helm
(add-to-list 'load-path "~/.emacs.d/elpa/helm-20140902.1137")
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)

;; function-args
(add-to-list 'load-path "~/.emacs.d/elpa/function-args-20140622.808")
(require 'function-args)
(fa-config-default)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(set-default 'semantic-case-fold t)
(semantic-add-system-include "~/../../lib/gcc/x86_64-pc-cygwin/4.8.3/include" 'c++-mode)
(semantic-add-system-include "~/../../usr/include" 'c++-mode)
(semantic-add-system-include "~/../../lib/gcc/x86_64-pc-cygwin/4.8.3/include" 'c-mode)
(semantic-add-system-include "~/../../usr/include" 'c-mode)

;; semantic
(semantic-mode 1)
(defun my:semantic-ac-source ()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c++-mode-hook 'my:semantic-ac-source)
(add-hook 'c-mode-hook 'my:semantic-ac-source)
(add-hook 'c-mode-common-hook 'my:semantic-ac-source)
(global-semantic-idle-scheduler-mode 1)

;; ede
(global-ede-mode 1)

;; elpy
(elpy-enable)

;; latex and math
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))
(add-hook 'latex-mode-hook 'ac-latex-mode-setup)

;; theme
(require 'noctilux-theme)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.6)
 '(ac-auto-start 1)
 '(column-number-mode 1)
 '(elpy-rpc-backend nil)
 '(indent-tabs-mode nil)
 '(show-paren-mode t)
 '(standard-indent 3))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun current-time-microseconds ()
  (let* ((nowtime (current-time))
         (now-ms (nth 2 nowtime)))
    (concat (format-time-string "[%Y-%m-%dT%T" nowtime) (format ".%d] " now-ms))))

(defadvice message (before test-symbol activate)
  (if (not (string-equal (ad-get-arg 0) "%s%s"))
      (let ((deactivate-mark nil))
        (save-excursion
          (set-buffer "*Messages*")
          (goto-char (point-max))
          (if (not (bolp))
              (newline))
          (insert (current-time-microseconds))))))
