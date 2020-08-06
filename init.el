
;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)    ; 类似于 package-initialize
(require 'pallet)
(pallet-mode t)      ; 激活 pallet, 在安装包时将 Cask 文件写入相应信息(require 'org-install)

(require 'ob-tangle)
(org-babel-load-file (expand-file-name "pekingcy.org" user-emacs-directory))

;; (add-to-list 'load-path "~/.emacs.d/lisp/")

;; ;; 快速打开配置文件
;; (defun open-init-file()
;;   (interactive)
;;   (find-file "~/.emacs.d/init.el"))

;; (require 'init-packages)
;; (require 'init-ui)
;; (require 'init-org)
;; (require 'init-better-defaults)
;; (require 'init-keybindings)
;; (setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))

;; (load-file custom-file)
