;; -*- Emacs-Lisp -*-

;auto complete
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(ac-flyspell-workaround)
(setq ac-use-fuzzy t
      turn-on-fuzzy-isearch t)
(ac-set-trigger-key "RET")
(setq ac-expand-on-auto-complete 0)

(require 'auto-complete-latex)

(provide 'auto-complete-settings)
