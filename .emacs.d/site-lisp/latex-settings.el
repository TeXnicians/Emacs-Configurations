
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
	    (add-to-list 'TeX-command-list
             	  '("XeLaTeX" "%'xelatex%(mode)%' %t" TeX-run-TeX nil t))
	    ;(setq TeX-command-default "XeLaTeX")
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
    '("latexmk" "latexmk -pdf -e -f %s && /Applications/Skim.app/Contents/SharedSupport/displayline -r %n %o %b" TeX-run-TeX nil t
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
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -r %n %o %b")))

;(setq TeX-view-program-list '(("PDF Viewer" "open -a /Applications/Skim.app %s.pdf")))
;(setq TeX-view-program-selection '((output-pdf "DF Viewer")(output-dvi "PDF Viewer")))

(server-start); start emacs in server mode so that skim can talk to it

(require 'tex-site)
(add-hook 'TeX-mode-hook
    (lambda ()
        (add-to-list 'TeX-output-view-style
            '("^pdf$" "."
              "/Applications/Skim.app/Contents/SharedSupport/displayline -r %n %o %b")))
)


;reftex
(require 'reftex)
(setq reftex-cite-format 'natbib)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-toc-split-windows-horizontally t)
(setq reftex-toc-split-windows-fraction 0.25)
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

;auto-complete
(require 'auto-complete-settings)

;cdlatex

(setq cdlatex-math-modify-prefix [f1])
; (setq cdlatex-paired-parens "$[{(")
(require 'cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
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
   ("numsol" "\\begin{numsol}\n\\exercise{?}\n\\end{numsol}" nil)
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
  ("nms" "Insert align env" "" cdlatex-environment ("numsol") t nil)
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


; ;latex paren
; (add-hook 'LaTeX-mode-hook
;            (function (lambda () (require 'latex-paren))))
