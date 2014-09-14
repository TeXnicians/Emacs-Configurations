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
	;(auto-complete-mode t)
        (setq-default column-number-mode t)
	;(setq-default asy-command "asy -V -render=4")
))
;(global-linum-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(asy-command "asy"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
