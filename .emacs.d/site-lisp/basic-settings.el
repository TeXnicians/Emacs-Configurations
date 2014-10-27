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
(global-auto-revert-mode t)
;(desktop-read)
(desktop-save-mode 1)

(require 'saveplace)
(setq-default save-place t) ;remember the last opened file location

;keys
(setq ns-function-modifier 'hyper) ; set Mac's Fn key to type Hyper
; (setq mac-command-modifier 'meta) ; set Mac's Cmd key to type Contrl
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
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; Set default tab space for various modes
; (setq-default sgml-basic-offset 4)
; (setq-default py-indent-offset 4)
; (setq-default python-indent 4)

; ;; highlight tabs and trailing whitespace
; (require 'highlight-chars)
; (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
; (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)

;; Shift the selected region right if distance is postive, left if
;; negative

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 4))

(defun shift-left ()
  (interactive)
  (shift-region -4))

;; Bind (shift-right) and (shift-left) function to your favorite keys. I use
;; the following so that Ctrl-Shift-Right Arrow moves selected text one
;; column to the right, Ctrl-Shift-Left Arrow moves selected text one
;; column to the left:

(global-set-key (kbd "s-]") 'shift-right)
(global-set-key (kbd "s-[") 'shift-left)

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

;;;;;;;;;;;;;;;;;;;;;; disable built-in keybindings ;;;;;;;;;;;;;;;;;;;;

(define-key global-map [?\s-p] nil) ; ns-print-buffer
(define-key global-map [?\s-l] nil) ; goto-line
(define-key global-map (kbd "s-l") 'goto-line) ; goto-line
(define-key global-map [?\s-D] nil) ; dired
(define-key global-map [?\s-L] nil) ; shell-command
(define-key global-map [?\s-f] nil) ; isearch-forward
(define-key global-map (kbd "s-f") 'isearch-forward) ; isearch-forward
(define-key global-map (kbd "s-F") 'query-replace) ; isearch-forward
(define-key global-map [?\s-k] nil) ; kill-this-buffer
(define-key global-map [?\s-w] nil) ; delete-frame
(define-key global-map (kbd "s-w") 'kill-this-buffer) ;
(require 'cl)
(require 'recentf)

; (defun undo-kill-buffer (arg)
;   "Re-open the last buffer killed.  With ARG, re-open the nth buffer."
;   (interactive "p")
;   (let ((recently-killed-list (copy-sequence recentf-list))
;    (buffer-files-list
;     (delq nil (mapcar (lambda (buf)
;             (when (buffer-file-name buf)
;         (expand-file-name (buffer-file-name buf)))) (buffer-list)))))
;     (mapc
;      (lambda (buf-file)
;        (setq recently-killed-list
;        (delq buf-file recently-killed-list)))
;      buffer-files-list)
;     (find-file
;      (if arg (nth arg recently-killed-list)
;        (car recently-killed-list)))))

(define-key global-map (kbd "s-W") 'kill-buffer-and-window) ;
(define-key global-map [?\s-z] nil)
;; undo tree
(require 'undo-tree)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "s-z") 'undo) ; cmd+z

(global-set-key (kbd "s-Z") 'redo) ; cmd+Shift+z  Mac style

;;;;;;;;;;;;;;;;;;;;;; disable built-in keybindings ;;;;;;;;;;;;;;;;;;;;

;; helm for launch buffer
(add-to-list 'load-path "/Users/Zhaodong/.emacs.d/site-lisp/helm")
(require 'helm)
(require 'helm-config)
; (require 'helm-eshell)
; (require 'helm-files)
; (require 'helm-grep)

; ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
; ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
; ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
; (global-set-key (kbd "C-c h") 'helm-command-prefix)
; (global-unset-key (kbd "C-x c"))

; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

; (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
; (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
; (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

; (when (executable-find "curl")
;   (setq helm-google-suggest-use-curl-p t))

(setq helm-quick-update                     t ; do not display invisible candidates
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;; helm mini
(global-set-key (kbd "s-p") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<M-s-f>") 'helm-find-files)

; go to matched paren
(defun goto-match-paren-dollar (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc
  (cond ((looking-at "[\[\(\{\$]") (forward-sexp))
        ((looking-back "[\]\)\}\$]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}\$]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{\$]" 1) (backward-char) (forward-sexp))
        (t nil)
        )
  )

(defun goto-match-paren (arg)
     "Go to the matching parenthesis if on parenthesis. Else go to the
   opening parenthesis one level up."
     (interactive "p")
     (cond ((looking-at "\\s(") (forward-list 1))
           (t
            (backward-char 1)
            (cond ((looking-at "\\s)")
                   (forward-char 1) (backward-list 1))
                  (t
                   (while (not (looking-at "\\s("))
                     (backward-char 1)
                     (cond ((looking-at "\\s)")
                            (message "->> )")
                            (forward-char 1)
                            (backward-list 1)
                            (backward-char 1)))
                     ))))))

; (defun dispatch-goto-matching (arg)
;   (interactive "p")
;  
;   (if (or
;        (looking-at "[\[\(\{]")
;        (looking-at "[\]\)\}]")
;        (looking-back "[\[\(\{]" 1)
;        (looking-back "[\]\)\}]" 1))
;  
;       (goto-match-paren arg)
;  
;     (when (eq major-mode 'ruby-mode)
;       (goto-matching-ruby-block arg)
;       )
;  
;     )
;   )

(global-set-key (kbd "<f5>") 'goto-match-paren)
(global-set-key (kbd "<f6>") 'goto-match-paren-dollar)

;; cursor moving
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "<s-down>") 'end-of-buffer)
;; kill whole line
(defun avi-kill-line-save (&optional arg)
      "Copy to the kill ring from point to the end of the current line.
    With a prefix argument, copy that many lines from point. Negative
    arguments copy lines backward. With zero argument, copies the
    text before point to the beginning of the current line."
      (interactive "p")
      (save-excursion
        (copy-region-as-kill
         (point)
         (progn (if arg (forward-visible-line arg)
                  (end-of-visible-line))
                (point)))))

(defun forward-delete-word (&optional arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (&optional arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (forward-delete-word (- arg)))

(defun delete-word (&optional arg)
"Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (forward-delete-word)
  (forward-delete-word (- arg)))

(defun delete-whole-line (&optional arg)
  (interactive "p")
  (delete-region (progn (forward-line 0) (point))
                 (progn (forward-line 1) (point))))
(defun delete-line (&optional arg)
  (interactive "p")
  (delete-region (point) (progn (forward-line 1)
                                (forward-char -1)
                                (point))))
(defun backward-delete-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (delete-region (line-beginning-position) (point)))
; (defun backward-kill-line (arg)
;   "Kill ARG lines backward."
;   (interactive "p")
;   (kill-line (- 1 arg)))
(global-set-key (kbd "s-k") 'delete-line) ;
(global-set-key (kbd "<s-backspace>") 'delete-whole-line)
(global-set-key (kbd "s-K") 'backward-delete-line)
(global-set-key (kbd "s-g") 'forward-delete-word)
(global-set-key (kbd "s-G") 'backward-delete-word)
(global-set-key (kbd "s-d") 'delete-word)

;; duplicate current line
    (defun duplicate-current-line (&optional n)
      "duplicate current line, make more than 1 copy given a numeric argument"
      (interactive "p")
      (save-excursion
        (let ((nb (or n 1))
        (current-line (thing-at-point 'line)))
          ;; when on last line, insert a newline first
          (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
      (insert "\n"))

          ;; now insert as many time as requested
          (while (> n 0)
      (insert current-line)
      (decf n)))))

    (defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key (kbd "s-D") 'duplicate-current-line-or-region); cmd-shift-d

(defun quick-copy-line ()
      "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
      (interactive)
      (let ((beg (line-beginning-position 1))
            (end (line-beginning-position 2)))
        (if (eq last-command 'quick-copy-line)
            (kill-append (buffer-substring beg end) (< end beg))
          (kill-new (buffer-substring beg end))))
      (beginning-of-line 2))

(global-set-key (kbd "s-L") 'quick-copy-line); cmd-shift-l
(global-set-key (kbd "<s-right>") 'end-of-line); cmd-right
(global-set-key (kbd "<s-left>") 'beginning-of-line); cmd-left
; (global-set-key (kbd "ESC") 'keyboard-quit)

;; set mark
(global-set-key (kbd "s-2") 'mark-word)
; (global-set-key (kbd "s-b") 'backward-word)
; (global-set-key (kbd "s-f") 'forward-word)
; (global-set-key (kbd "s-l") 'downcase-word)
; (global-set-key (kbd "s-c") 'capitalize-word)
; (global-set-key (kbd "s-u") 'upcase-word)
;; replace all key bindings for ‘kill-buffer’ with bindings to ‘kill-buffer-and-its-windows’
(require 'misc-cmds)
(substitute-key-definition 'kill-buffer 'kill-buffer-and-its-windows global-map)
(global-set-key
  (kbd "s-r")
  (lambda (&optional force-reverting)
    "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
    (interactive "P")
    ;;(message "force-reverting value is %s" force-reverting)
    (if (or force-reverting (not (buffer-modified-p)))
        (revert-buffer :ignore-auto :noconfirm)
      (error "The buffer has been modified"))))

;; redefine kill-matching-buffers
(defun delte-matching-window (regexp &optional internal-too)
  "Kill buffers whose name matches the specified regexp.
The optional second argument indicates whether to kill internal buffers too."
  (interactive "sKill buffers matching this regular expression: \nP")
  (dolist (buffer (buffer-list))
    (let ((name (buffer-name buffer)))
      (when (and name (not (string-equal name ""))
                 (or internal-too (/= (aref name 0) ?\s))
                 (string-match regexp name))
        (delete-window (get-buffer-window buffer))))))

(defun kill-matching-buffers-and-its-windows (regexp &optional internal-too)
  "Kill buffers whose name matches the specified regexp.
The optional second argument indicates whether to kill internal buffers too."
  (interactive "sKill buffers matching this regular expression: \nP")
  (dolist (buffer (buffer-list))
    (let ((name (buffer-name buffer)))
      (when (and name (not (string-equal name ""))
                 (or internal-too (/= (aref name 0) ?\s))
                 (string-match regexp name))
        (kill-buffer-and-its-windows buffer)))))


