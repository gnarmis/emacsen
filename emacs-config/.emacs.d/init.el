(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; --- Load Path Extensions ---

;; add the ~/.emacs.d/kilotau folder on the load path
(add-to-list 'load-path "~/.emacs.d/kilotau")

;; --- Require kilotau Files  ---

(require 'pbcopy)

;; --- Overriding Defaults ---

;; make sure emacs knows what the emacsclient executable is
(set-variable 'magit-emacsclient-executable "/usr/local/bin/emacsclient")

;; go to font panel (cmd-t), select font and size, then 'M-x
;; describe-font' and copy/paste the name in this function call
(defun set-font () 
  "set the default font"
  (set-default-font "-apple-Source_Code_Pro-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1"))

;; set font after init
(add-hook 'after-init-hook 'set-font)

;; set font on emacsclient launch
(add-hook 'server-visit-hook 'set-font)

;; prevent creation of backup files. I'd rather manually handle that.
(setq make-backup-files nil)

;; disable display of scroll bars
(scroll-bar-mode -1)

;; disable toolbar
(tool-bar-mode -1)

;; override the annoying `coding: undecided` comment in ruby files
(setq ruby-insert-encoding-magic-comment nil)

;; fix flyspell problem
(setq flyspell-issue-welcome-flag nil) 

;; fix ispell issue
(setq ispell-program-name "/usr/local/bin/ispell")

;; ls don't work no more on no dir bro
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

;; enable auto fill mode everywhere
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; set fringe color
(add-hook 'after-init-hook
          (lambda ()
            (set-face-background 'fringe "#2d2d2d")))
(set-face-background 'fringe "#2d2d2d")

;; --- General Editing Settings ---

;; turn on ido mode
(require 'ido)
(require 'ido-vertical-mode)
(require 'ido-hacks)
(setq ido-ubiquitous t)
(ido-mode 1) 
(ido-vertical-mode 1)

;; fuzzy matching for ido!
(setq ido-enable-flex-matching t)

;; enable smex for a much better meta-x experience
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; allow mini helm
(global-set-key (kbd "C-c h") 'helm-mini)

;; turn on projectile globally
(projectile-global-mode)

(set-keyboard-coding-system nil)

(require 'recentf)
(setq recentf-max-menu-items 25)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'recentf-ido-find-file)

;; enable recent files mode.
(recentf-mode t)

; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

;; comment or uncomment shortcut
(global-set-key (kbd "s-/") 'comment-or-uncomment-region)

;; ansi-term didn't support unicode characters, so I added this:
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

;; set history limit much higher for terms
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)))

;; cycle windows easily in term mode. http://rawsyntax.com/blog/learn-emacs-zsh-and-multi-term/
(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))

;; pasting in term mode is a pain, this eases it
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-y") 'term-paste)))


;; Set the theme
(require 'color-theme)

;; light theme
;; (color-theme-sanityinc-tomorrow)

;; dark theme
(color-theme-sanityinc-tomorrow-eighties)

;; Turn on switch-window, which steal C-x o
(require 'switch-window)

;; set indentation to 2
(setq standard-indent 2)

;; set tab width stuff
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; set newline as required for every file's last line
(setq require-final-newline nil)

;; require smart-tab, so tab behaves as I expect
(require 'smart-tab)
(global-smart-tab-mode)

;; enable git-gutter for all files
(require 'git-gutter)
(global-git-gutter-mode t)
;; git gutter key bindings
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x r") 'git-gutter:revert-hunk)
;; appearance of git gutter
(setq git-gutter:added-sign "+ ")
(setq git-gutter:deleted-sign "- ")
(setq git-gutter:modified-sign "= ")

(global-set-key [next] 'scroll-up-half)
(global-set-key [prior] 'scroll-down-half)

;; freaking don't ask me to type out "yes" and "no"
(defalias 'yes-or-no-p 'y-or-n-p)

;; key binding for fill-region
(global-set-key (kbd "C-c f") 'fill-region)

(require 'powerline)
(powerline-default-theme)

;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
(setq inhibit-startup-echo-area-message "gnarmis")

;; --- Lisp Settings ---

;; turn on rainbow delimiters
(require 'rainbow-delimiters)

;; --- Ruby Settings ---

;; ruby-mode and rspec-mode setup
(require 'ruby-mode)
(require 'rspec-mode)
(add-hook 'ruby-mode-hook 'rspec-mode)

(require 'rinari)
(setq rinari-tags-file-name "TAGS")
(global-rinari-mode)

;; enable ruby-mode for certain files
(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; --- Clojure Settings ---

;; eldoc when using nrepl
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)


;; --- Other Major Modes ---

;; enable coffee mode
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; deft settings
(require 'deft)
(setq deft-extension "txt")
(setq deft-directory "~/Dropbox/Documents/Notes")
(setq deft-text-mode 'markdown-mode)
(setq deft-use-filename-as-title t)

;; keybinding for deft
(global-set-key [f6] 'deft)

;; set markdown mode file extensions
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; add markdown to smart-tab-mode's disabled major modes list
(add-to-list 'smart-tab-disabled-major-modes 'markdown-mode)

;; turn on/configure Haskell mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)


;; add hook to rhtml to turn off auto-fill-mode
(add-hook 'rhtml-mode-hook (lambda () (auto-fill-mode -1)))

;; make sass-mode recognize file extensions
(add-to-list 'auto-mode-alist '("\\.scss\\'" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . sass-mode))

;; hippie-expand for tab completion in `eval-expression` mini-buffer
;;     http://www.emacswiki.org/emacs/TabCompletion
(define-key read-expression-map [(tab)] 'hippie-expand)

;; rhtml mode for erb files, etc
(autoload 'rhtml-mode "rhtml-mode" "RHTML" t)
(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.html\.erb$" . rhtml-mode)) 

;; highlight indentation!
(require 'highlight-indentation)
 (add-hook 'ruby-mode-hook
           (lambda () (highlight-indentation-current-column-mode)))

 (add-hook 'coffee-mode-hook
           (lambda () (highlight-indentation-current-column-mode)))

;; turn on paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)

(require 'smartparens-config)

;; --- Custom Functions ---

;; left and right margins
(defun widen-window-margins ()
  "This widens every window's margins to 4,4, and also sets the
  fringe's color to match background"
  (set-window-margins (car (get-buffer-window-list (current-buffer) nil t)) 4 4)
  (set-face-background 'fringe "#2d2d2d"))

;; change scrolling to half-page scrolling
(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height))
  (recenter-top-bottom))

(defun scroll-down-half ()         
  (interactive)                    
  (scroll-down (window-half-height))
  (recenter-top-bottom))


(defun rails-project-ctags ()
  "run the following command at project root: `ctags -a -e -f TAGS --tag-relative -R app lib vendor`"
  ())

(defun ruby-interpreter () "" "ruby -rtime")

(defun ruby-eval-region (start end)
  "Send the region through the Ruby interpreter"
  (interactive "r")
  (shell-command-on-region start end (ruby-interpreter)))


(defun ruby-eval-buffer ()
  "Send the entire buffer through the Ruby interpreter"
  (interactive)
  (ruby-eval-region (point-min) (point-max)))

;; insert timestamp
(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M")))
(global-set-key (kbd "C-c C-d") 'timestamp)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let* ((file-assoc-list
          (mapcar (lambda (x)
                    (cons (file-name-nondirectory x)
                          x))
                  recentf-list))
         (filename-list
          (remove-duplicates (mapcar #'car file-assoc-list)
                             :test #'string=))
         (filename (ido-completing-read "Choose recent file: "
                                        filename-list
                                        nil
                                        t)))
    (when filename
      (find-file (cdr (assoc filename
                             file-assoc-list))))))



;; --- Other ---

;; ido imenu mode
; find symbol in source file using ido
(require 'idomenu)
(autoload 'idomenu "idomenu" nil t)
(global-set-key (kbd "C-t") 'idomenu)
; make imenu work in ruby-mode
(add-hook 'ruby-mode-hook
          (lambda ()
            (set (make-local-variable imenu-generic-expression)
                 '(("Methods"  "^\\( *\\(def\\) +.+\\)"          1)
                   ))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
