;; enable this if you want `swiper' to use it
;;(setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(define-abbrev-table 'global-abbrev-table '(
					    ;; Shifu
					    ("pc" "pekingcy")
					    ;; Tudi
					    
					    ))

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
(global-set-key (kbd "C-c p") 'counsel-git)

;;代码缩进快捷键
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)
;;补全 不同与“company”
(global-set-key (kbd "s-/") 'hippie-expand)

(global-set-key (kbd "C-=") 'er/expand-region)

(define-key global-map (kbd "M-s e") 'iedit-mode)

(global-set-key (kbd "C-c a")'org-agenda)
(global-set-key (kbd "C-c r") 'org-capture)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(global-set-key (kbd "C-x p s") 'helm-do-ag-project-root)

(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)

(provide 'init-keybindings)
