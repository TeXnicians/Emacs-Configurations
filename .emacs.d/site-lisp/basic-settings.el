;path variables
(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/texbin" ":"

(getenv "PATH")))

(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/local/bin" ":"

(getenv "PATH")))

(when (string-equal system-type "darwin")
  (setq exec-path
'(
  "/usr/local/bin"
  "/usr/texbin"
  "/usr/local"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
 )
 ))

;(load "desktop")
;(desktop-load-default)
;(desktop-read)
(desktop-save-mode 1)

(require 'saveplace)
(setq-default save-place t) ;remember the last opened file location

;keys
(setq ns-function-modifier 'hyper) ; set Mac's Fn key to type Hyper
; (setq mac-command-modifier 'control) ; set Mac's Cmd key to type Contrl
(setq mac-right-command-modifier 'super) ; set Mac's Cmd key to type Super

;fonts

(set-default-font "Menlo")
(set-fontset-font "fontset-default"
  'unicode '("STHeiti" . "unicode-bmp"))
;(set-face-attribute
;    'default nil :font
;    "-outline-Courier New-normal-normal-normal-mono-12-*-*-*-c-*-iso8859-1")


; session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;tabbar
(require 'tabbar)
(tabbar-mode)
(global-set-key [M-s-up] 'tabbar-backward-group)
(global-set-key [M-s-down] 'tabbar-forward-group)
(global-set-key [M-s-left] 'tabbar-backward-tab)
(global-set-key [M-s-right] 'tabbar-forward-tab)

;;;; tabbar appearance
;; themes, fonts, back-&foreground,size
(set-face-attribute 'tabbar-default nil
		    :family "Monaco"
                    :background "gray90"
                    :foreground "black"
                    :height 1.0
                    )
;; let button
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "gray30")
                    )
;; current tab
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "white"
                    :background "black"
                    :box '(:line-width 2 :color "black")
                    ;; :overline "black"
                    ;; :underline "black"
                    :weight 'bold
                    )
;; non-current tab
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "gray70")
                    )

;; themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night t)

;(global-set-key (kbd "C-s-<down>") 'shrink-window)
;(global-set-key (kbd "C-s-<up>") 'enlarge-window)
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)
(setq-default word-wrap t)
(setq-default fill-column 5000)
(delete-selection-mode 1)
;; Compilation output
(setq compilation-scroll-output 'first-error)

;;cursor scrolling
;(setq scroll-preserve-screen-position )


;(save-window-excursion
 ;  (async-shell-command osascript))

;; display buffer name or absolute file path name in the frame title
(defun frame-title-string ()
  "Return the file name of current buffer, using ~ if under home directory"
  (let
      ((fname (or
	       (buffer-file-name (current-buffer))
	       (buffer-name)))
       (max-len 100))
    (when (string-match (getenv "HOME") fname)
      (setq fname (replace-match "~" t t fname)))
    (if (> (length fname) max-len)
	(setq fname
	      (concat "..."
		      (substring fname (- (length fname) max-len)))))
    fname))
(setq frame-title-format '((:eval (frame-title-string))))

;coding system
;(set-language-environment "Chinese-GBK")
;(set-keyboard-coding-system 'chinese-iso-8bit)

;smart tab
(setq-default TeX-newline-function 'newline-and-indent)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;highlight parens
; (show-paren-mode 1)
; (setq show-paren-style 'parenthesis)
; (setq show-paren-delay 0)

;open file in new buffer instead of new window
(setq ns-pop-up-frames nil)

;; To load at the start up
(require 'reveal-in-finder)
;; If you want to configure a keybinding (e.g., C-c z), add the following
(global-set-key (kbd "<f10>") 'reveal-in-finder)

;; copy line
(defun copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

;; optional key binding
(global-set-key (kbd "C-s-l") 'copy-line)

(add-to-list 'load-path "~/.emacs.d/site-lisp/smartparens")

; Smooth scrolling
(setq my-wheel-scroll-lines 2) ; or whatever you prefer

(defun safe-scroll-up () "Scroll up but don't try at bottom" (interactive)
(if (not (pos-visible-in-window-p (point-max)))
(scroll-up my-wheel-scroll-lines)))
(defun safe-scroll-down () "Scroll down but don't try at top" (interactive)
(if (not (pos-visible-in-window-p (point-min)))
(scroll-down my-wheel-scroll-lines)))

(global-set-key [wheel-up] 'safe-scroll-down)
(global-set-key [wheel-down] 'safe-scroll-up)

;; helm for launch buffer
(add-to-list 'load-path "/Users/Zhaodong/.emacs.d/site-lisp/helm")
(require 'helm-config)
;; helm mini
(global-set-key (kbd "C-s-p") 'helm-mini)
(helm-mode 1)
(setq helm-quick-update                     t
      helm-split-window-in-side-p           t
      helm-buffers-fuzzy-matching           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-ff-file-name-history-use-recentf t)


; go to matched paren
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)
        )
  )

(defun dispatch-goto-matching (arg)
  (interactive "p")
 
  (if (or
       (looking-at "[\[\(\{]")
       (looking-at "[\]\)\}]")
       (looking-back "[\[\(\{]" 1)
       (looking-back "[\]\)\}]" 1))
 
      (goto-match-paren arg)
 
    (when (eq major-mode 'ruby-mode)
      (goto-matching-ruby-block arg)
      )
 
    )
  )

(global-set-key "\M--" 'dispatch-goto-matching)

;; cursor moving
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "<s-down>") 'end-of-buffer)
