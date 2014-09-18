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
; (setq ac-expand-on-auto-complete 0)

(require 'pos-tip)
; (setq ac-quick-help-prefer-pos-tip t)   ;default is t
; (setq ac-use-quick-help t)
; (setq ac-quick-help-delay 1.0)

; (require 'auto-complete-latex)

(add-hook 'LaTeX-mode-hook
    (lambda ()
    (setq ac-quick-help-prefer-pos-tip t)   ;default is t
    (setq ac-use-quick-help t)
    (setq ac-quick-help-delay 1.0)
    (auto-complete-mode t)
    (setq ac-sources (append
      '(ac-source-dictionary
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-same-mode-buffers
          ac-source-files-in-current-dir
          ac-source-filename) ac-sources))
    ; ; (setq ac-sources
    ;     '(ac-source-dictionary
    ;       ac-source-semantic
    ;       ac-source-yasnippet
    ;       ac-source-abbrev
    ;       ac-source-words-in-buffer
    ;       ac-source-words-in-same-mode-buffers
    ;       ac-source-files-in-current-dir
    ;       ac-source-filename))
))


(provide 'auto-complete-settings)
