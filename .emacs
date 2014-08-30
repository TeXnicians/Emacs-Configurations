;;; Basic Settings ;;;

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
(setq mac-command-modifier 'super) ; set Mac's Cmd key to type Super

;fonts

;(set-default-font "Courier New-14") 
;(set-face-attribute
;    'default nil :font
;    "-outline-Courier New-normal-normal-normal-mono-12-*-*-*-c-*-iso8859-1")

(add-to-list 'load-path "~/.emacs.d/site-lisp")

; session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;tabbar
(require 'tabbar)
(tabbar-mode)
(global-set-key [M-up] 'tabbar-backward-group)
(global-set-key [M-down] 'tabbar-forward-group)
(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)

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
(set-language-environment "Chinese-GBK")
(set-keyboard-coding-system 'chinese-iso-8bit)

;smart tab
(setq-default TeX-newline-function 'newline-and-indent)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;highlight parens
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; LaTeX settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;spell check
(setq ispell-program-name "aspell")
;(setq ispell-list-command "--list")
(setq ispell-extra-args '("--sug-mode=ultra"))
(setq ispell-dictionary "english") 

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;(add-to-list 'load-path "~/.emacs.d/lisps/auctex/site-lisp/site-start.d")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(mapc (lambda (mode)
      (add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
            'linum-mode))
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-global-PDF-mode t
		   TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-engine 'xetex       ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
	    (add-to-list 'TeX-command-list             	  '("XeLaTeX" "%'xelatex%(mode)%' %t" TeX-run-TeX nil t))	    ;(setq TeX-command-default "XeLaTeX")
	    (flyspell-mode 1)
	    (linum-mode 1)
	    (outline-minor-mode 1)
	    (TeX-fold-mode 1) 
	    	;C-c C-o C-b / C-c C-o b
		;folding/unfolding buffer
		;C-c C-o C-r / C-c C-o r
		;folding/unfolding region
		;C-c C-o C-p / C-c C-o p
		;folding/unfolding paragraph
		;C-c C-o C-o
		;folding and unfolding case by case
		;C-c C-o C-e
		;folding block elements
		;C-c C-o C-m
		;folding inline elements
	    ;(auto-complete-mode t)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
	    (define-key LaTeX-mode-map (kbd "C-c C-p") 'reftex-parse-all)
	    (define-key LaTeX-mode-map (kbd "C-c C-a") 'TeX-clean)
))
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)

(add-hook 'LaTeX-mode-hook (lambda ()
  (add-to-list 'TeX-command-list
    '("latexmk" "latexmk -pdf -e -f %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    )
  (setq TeX-command-default "latexmk")
))
;(add-hook 'LaTeX-mode-hook (lambda ()
;  (push
;    '("latexmk" "latexmk -pdf -e -f %s" TeX-run-TeX nil t
;      :help "Run latexmk on file")
;   TeX-command-list)))
;(add-hook 'TeX-mode-hook '(lambda ()
;	(setq TeX-command-default "latexmk")
;))
;; (setq-default TeX-master "latexmk")

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))

;(setq TeX-view-program-list '(("PDF Viewer" "open -a /Applications/Skim.app %s.pdf")))
;(setq TeX-view-program-selection '((output-pdf "DF Viewer")(output-dvi "PDF Viewer")))

(server-start); start emacs in server mode so that skim can talk to it

(require 'tex-site)
(add-hook 'TeX-mode-hook
    (lambda ()
        (add-to-list 'TeX-output-view-style
            '("^pdf$" "."
              "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))
)


;reftex
(require 'reftex)
(setq reftex-cite-format 'natbib)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) (setq reftex-toc-split-windows-horizontally t)(setq reftex-toc-split-windows-fraction 0.25)
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
;; ref label
(setq reftex-label-alist 
	'((nil ?e nil "~\\eqref{%s}" nil nil)
	  (nil ?f nil "~\\fref{%s}" nil nil)
	  (nil ?t nil "~\\tref{%s}" nil nil))
)
 	
(setq reftex-enable-partial-scans t
      reftex-save-parse-info t
      reftex-use-multiple-selection-buffers t)

;cdlatex

(setq cdlatex-math-modify-prefix [f1])
(setq cdlatex-paired-parens "$[{(")
(require 'cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
(setq cdlatex-env-alist
 '(("equation*" "\\begin{equation*}\n?\n\\end{equation*}" nil)
   ("align*" "\\begin{align*}\n?\n\\end{align*}" nil)
   ("alignat*" "\\begin{alignat*}\n?\n\\end{alignat*}" nil)
   ("multline*" "\\begin{multline*}\n?\n\\end{multline*}" nil)
   ("frame" "\\begin{frame}\n\\frametitle{?}\n\\end{frame}\n" nil)
   ("pmatrix" "\\begin{pmatrix}\n?\n\\end{pmatrix}" nil)
   ("bmatrix" "\\begin{bmatrix}\n?\n\\end{bmatrix}" nil)
   ("enumerate" "\\begin{enumerate}[?]\n\\item \n\\end{enumerate}" "\\item ?")
   ("notation" "\\begin{notation}\n\\item[?] \n\\end{notation}" "\\item[?]")
   ("equation" "\\begin{equation}\\label{eqn:?}\n\n\\end{equation}" nil)
   ("multline" "\\begin{multline}\\label{eqn:?}\n\n\\end{multline}" nil)
   ("align" "\\begin{align}\\label{eqn:?}\n\n\\end{align}" nil)
   ("alignat" "\\begin{alignat}\\label{eqn:?}\n\n\\end{alignat}" nil)
   ("aligned" "\\left\\{\n\\begin{aligned}\n\n\\end{aligned}\n\\right." nil)
  )
)   ;; define several frequently-used environments

(setq cdlatex-command-alist
'(("eq" "Insert equation* env"  "" cdlatex-environment ("equation*") t nil)
  ("al" "Insert align* env"   "" cdlatex-environment ("align*") t nil)
  ("ala" "Insert alignat* env"   "" cdlatex-environment ("alignat*") t nil)
  ("mtl" "Insert multline* env"  "" cdlatex-environment ("multline*") t nil)
  ("fm" "Insert frame env"   "" cdlatex-environment ("frame") t nil)
  ("pma" "Insert pmatrix env" "" cdlatex-environment ("pmatrix") t t)
  ("bma" "Insert bmatrix env" "" cdlatex-environment ("bmatrix") t t)
  ("enu" "Insert enumerate env" "" cdlatex-environment ("enumerate") t nil)
  ("not" "Insert notation env" "" cdlatex-environment ("notation") t nil)
  ("equ" "Insert equation env" "" cdlatex-environment ("equation") t nil)
  ("mtli" "Insert multline env" "" cdlatex-environment ("multline") t nil)
  ("ali" "Insert align env" "" cdlatex-environment ("align") t nil)
  ("alat" "Insert alignat env"   "" cdlatex-environment ("alignat") t nil)
  ("aligned" "Insert aligned env" "" cdlatex-environment ("aligned") t t)
  ("dfr"         "Insert \\dfrac{}{}"
     "\\dfrac{?}{}"           cdlatex-position-cursor nil nil t)
 )
)  ;; define alias of environment, type alias [TAB] to get the structure of environment

(setq cdlatex-math-modify-alist
 '(( ?l	  "\\mathbb"   "\\textsl"	t 	nil 	nil)
   ( ?c	  "\\mathcal"   "\\textsc"	t 	nil 	nil)
  )
)

;yasnippet
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;auto complete
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(ac-flyspell-workaround)


(require 'auto-complete-latex);(require 'yasnippet-settings)

;latex paren
(add-hook 'LaTeX-mode-hook
           (function (lambda () (require 'latex-paren))))

;asymptote
(add-to-list 'load-path "/usr/local/share/asymptote")(require 'asy-mode)
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
 '(asy-command "asy -V"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
