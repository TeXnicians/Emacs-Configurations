;asymptote
(add-to-list 'load-path "/usr/local/share/asymptote")
(require 'asy-mode)
;(setq ac-modes (append ac-modes '(asy-mode)))
;(add-hook 'asy-mode-hook 'ac-l-setup)
;(add-hook 'asy-mode-hook 'flyspell-mode)
;(add-hook 'asy-mode-hook 'flyspell-buffer)
(add-hook 'asy-mode-hook
    (lambda ()
	(linum-mode t)
	(flyspell-mode t)
	(auto-complete-mode t)
    (setq-default column-number-mode t)
    (setq ac-quick-help-prefer-pos-tip t)   ;default is t
    (setq ac-use-quick-help t)
    (setq ac-quick-help-delay 1.0)
    (setq ac-sources
        '(ac-source-dictionary
          ;; ac-source-semantic
          ; ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-same-mode-buffers
          ac-source-files-in-current-dir
          ac-source-filename))
	(setq-default asy-command "asy")
))
(add-hook 'asy-mode-hook 'turn-on-cdlatex)

;; parens auto-complete
(require 'smartparens-latex)
; ; (package-initialize)
; (defun prelude-latex-mode-defaults ()
;    (turn-on-auto-fill)
;    (abbrev-mode +1)
;    (smartparens-mode +1))

; (setq prelude-latex-mode-hook 'prelude-latex-mode-defaults)

(smartparens-global-mode +1)
(show-smartparens-global-mode +1)
(setq show-paren-style 'parenthesis)

(kill-buffer-and-its-windows "*Compile-Log*")
(kill-buffer-and-its-windows "*scratch*")
(kill-buffer-and-its-windows "*Messages*")
(kill-buffer-and-its-windows "*flyspell-region*")
