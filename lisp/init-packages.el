
(require 'cl)
   ;;使用cask管理项目以后下边不在使用
   ;; You may delete these explanatory comments.
   ;; (when (>= emacs-major-version 24)
   ;;      (require 'package)
   ;;      (package-initialize)
   ;;      (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
   ;; 		      ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))))
   
;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common Lisp Extension

 ;; Add Packages
     ;; (defvar my/packages '(
     ;; 		;; --- Auto-completion ---
     ;; 	        company
     ;; 	        popwin
     ;; 		;; --- Better Editor ---
     ;; 		hungry-delete
     ;; 		swiper
     ;; 		counsel
     ;; 		smartparens
     ;; 		;; --- Major Mode ---
     ;; 		js2-mode
	       
     ;; 		;; --- Minor Mode ---
     ;; 		nodejs-repl
     ;; 		exec-path-from-shell
     ;; 		;; --- Themes ---
     ;;  		monokai-theme
     ;; 		iedit
     ;; 		org-pomodoro
     ;; 		expand-region
     ;; 		helm-ag
     ;; 		flycheck
     ;; 		yasnippet
     ;; 		auto-yasnippet
     ;; 		evil
     ;; 		evil-leader
     ;; 		window-numbering
     ;;  		evil-surround
     ;; 		powerline
     ;; 		evil-nerd-commenter
     ;; 		which-key	
     ;; 		;; solarized-theme
     ;; 		) "Default packages")

     ;; (setq package-selected-packages my/packages)

     ;; (defun my/packages-installed-p ()
     ;;     (loop for pkg in my/packages
     ;; 	   when (not (package-installed-p pkg)) do (return nil)
     ;; 	    finally (return t)))

     ;; (unless (my/packages-installed-p)
     ;;     (message "%s" "Refreshing package database...")
     ;;     (package-refresh-contents)
     ;;     (dolist (pkg my/packages)
     ;;       (when (not (package-installed-p pkg))
     ;; 	 (package-install pkg))))

 ;; ;; Find Executable Path on OS 
 ;; (when (memq window-system '(mac ns))
 ;;   (exec-path-from-shell-initialize))

(use-package exec-path-from-shell
  :ensure t
  :pin melpa-stable
  :if (and (eq system-type 'darwin) (display-graphic-p))
  :config
  (progn
    (when (string-match-p "/zsh$" (getenv "SHELL"))
      ;; Use a non-interactive login shell.  A login shell, because my
      ;; environment variables are mostly set in `.zprofile'.
      (setq exec-path-from-shell-arguments '("-l")))

    (exec-path-from-shell-initialize)
    )
  )

;;外部有修改文件自动加载
(global-auto-revert-mode t)
;;添加主体
;; (add-to-list 'my/packages 'monokai-theme)
(load-theme 'monokai 1)

(require 'hungry-delete)
(global-hungry-delete-mode)

;;(require 'smex)
;;(smex-initialize)
;;(global-set-key (kbd "M-x") 'smex)
;;wiper 
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;;autoload function 
;;(require 'smartparens-config)
;; Always start smartparens mode in js-mode.
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
;;全局使用smartparens
(smartparens-global-mode t)
;;去掉","的自动匹配的问题
;;(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;;(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
;;上面两句功能合并
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)

;;匹配括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))



(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))



(require 'nodejs-repl)
;;定位光标位置
(require 'popwin)
(popwin-mode t)
(require 'org-pomodoro)

(require 'iedit)

(require 'expand-region)

(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'yasnippet)

(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(evil-mode 1);; 文件末尾

(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(setq-default evil-want-C-u-scroll t)

(global-evil-leader-mode)
  
(evil-leader/set-key
  "ff" 'find-file
  "fr" 'recentf-open-files
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "pf" 'counsel-git
  "ps" 'helm-do-ag-project-root
  "0"  'select-window-0
  "1"  'select-window-1
  "2"  'select-window-2
  "3"  'select-window-3
  "w/" 'split-window-right
  "w-" 'split-window-below
  ":"  'counsel-M-x
  "wM" 'delete-other-windows
  )
(require 'evil-surround)
(global-evil-surround-mode)
(window-numbering-mode 1)

(require 'powerline)
(powerline-default-theme)
;; 文件末尾

(evilnc-default-hotkeys)

(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)

(dolist (mode '(ag-mode
		flycheck-error-list-mode
		occur-mode
		git-rebase-mode))
  (add-to-list 'evil-emacs-state-modes mode))

(add-hook 'occur-mode-hook
	  (lambda()
	    (evil-add-hjkl-bindings occur-mode-map 'emacs
	      (kbd"/") 'evil-search-forward
	      (kbd"n") 'evil-search-next
	      (kbd"N") 'evil-search-previous
	      (kbd"C-d") 'evil-scroll-up
	      (kbd"C-u") 'evil-scroll-down
	     )
	   ))
(which-key-mode 1)
(setq which-key-side-window-location 'right) 

(sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)



(add-hook 'python-mode-hook
	  (lambda ()
	    (set (make-local-variable 'company-backends) '(company-anaconda company-dabbrev))))

(provide 'init-packages)  
