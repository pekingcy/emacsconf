(with-eval-after-load 'org
  ;; Org 模式相关设定
  ;;语法高亮的效果
(setq org-src-fontify-natively t)
(setq org-agenda-files '("~/.emacs.d"))



(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排")
	 "* TODO [#B] %?\n  %i\n"
	 :empty-lines 1)

	("c" "crome" entry (file+headline "~/.emacs.d/gtd.org" "quick note")
	 "* TODO [#C] %?\n %(pekingcy/retrieve-chrome-current-tab-url)\n %i\n %U"
	 :empty-lines 1)

	))
  )



(provide 'init-org)
