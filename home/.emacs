;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; font size in X
;; (x-set-font "courr14")

;; turn on font-lock mode
(global-font-lock-mode t)
;; enable visual feedback on selections
(setq-default transient-mark-mode t)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(when window-system
  ;; enable wheelmouse support by default
  ;;(mwheel-install)
  ;; use extended compound-text coding for X clipboard
  ;;(set-selection-coding-system 'compound-text-with-extensions)
)

;;Mouse wheel
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)

(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)

;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

(global-set-key "\C-h" 'backward-delete-char)

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
        (global-font-lock-mode t)
))

(defun dedosify ()
  "Remove any ^M or ^Z characters in a buffer."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\015" nil t)  ;^M
    (replace-match "" nil t))
  (goto-char (point-min))
  (while (search-forward "\032" nil t)  ;^Z
    (replace-match "" nil t))
)

;(global-set-key (quote [DEL]) 'delete-char)

(global-set-key "\C-cm" 'dedosify)

;; cc-mode stuff
(require 'cc-mode)
(setq c-tab-always-indent 42)
(setq c-basic-offset 3)

;; My C++ style

(defconst my-c++-style
 '((c-tab-always-indent        . t)
   (c-comment-only-line-offset . 0)
   (c-hanging-braces-alist     . ((substatement-open after)
                                  (brace-list-open)))
   (c-hanging-colons-alist     . ((member-init-intro before)
                                  (inher-intro)
                                  (case-label after)
                                  (label after)
                                  (access-label after)))
   (c-cleanup-list             . (scope-operator
                                  ;empty-defun-braces
                                  defun-close-semi))
   (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                  (func-decl-cont . 0)
                                  (inline-open       . 0)
                                  (substatement-open . 0)
                                  (case-label        . +)
                                  (block-open        . 0)
                                  (knr-argdecl-intro . -)))
   (c-echo-syntactic-information-p . t)
   )
 "My C++ Programming Style")

;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-c-mode-common-hook ()
 ;; add my personal style and set it for the current buffer
 (c-add-style "PERSONAL" my-c++-style t)
 ;; offset customizations not in my-c-style
 (c-set-offset 'member-init-intro '++)
 ;; other customizations
 (setq tab-width 3
       ;; this will make sure spaces are used instead of tabs
       indent-tabs-mode nil)
 ;; we don't like auto-newline and hungry-delete
 (c-toggle-auto-hungry-state -1)
 ;; keybindings for all supported languages.  We can put these in
 ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
 ;; java-mode-map, and idl-mode-map inherit from it.
 (define-key c-mode-base-map "\C-m" 'newline-and-indent)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; Always end a file with a newline
(setq require-final-newline t)

;; Enable wheelmouse support by default
;;(require 'mwheel)

;; Show time in the status bar
(display-time)

;(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-size 10000000)

; preserve case when expanding dabbrevs
(setq dabbrev-case-replace nil)

(global-set-key "\C-xc" 'compile)
(global-set-key "\C-x\C-k" 'kill-compilation)

;;(global-set-key "\C-c" 'my-compile)
(global-set-key (quote [f8]) (quote (lambda nil (interactive) (compare-windows
nil))))
(global-set-key 
   (quote [f9]) (quote (lambda nil (interactive) (revert-buffer ni\lt))))
(global-set-key (quote [f10]) (quote revert-buffer))
(global-set-key "\C-g" (quote goto-line))

;;My stuff (Nathan F)
(global-set-key "\C-q" (quote global-font-lock-mode))

(defun my-compile ()
  "Compile and goto the compilation buffer"
  (interactive)
  (compile "make")
  (switch-to-buffer-other-window "*compilation*")
  (goto-char (point-max)
))

; Set up some key bindings.

(global-set-key "\C-xt" 'insert-buffer)
(global-set-key "\C-\\" 'set-mark-command)
(global-set-key "\C-xz" 'iconify-or-deiconify-frame)
(global-set-key "\C-z" '(lambda nil (interactive) (scroll-up 1)))

; Make the return key do a mode sensitive indent.
(global-set-key "\C-m" 'newline-and-indent)

(global-set-key "\ee" 'eval-expression)
(global-set-key "\eg" 'goto-line)
(global-set-key "\en" 'move-to-window-line)
(global-set-key "\er" 'replace-string)
(global-set-key "\e\\" 'just-one-space)
(global-set-key "\e " 'dabbrev-expand)
(global-set-key "\e\C-h" 'backward-kill-word)
(global-set-key (quote [f11]) '(lambda nil (interactive)
                                 (untabify (point-min) (point-max))))


; Throw caution to the winds!
(put 'eval-expression 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'erase-buffer 'disabled nil)

;; Do not add newlines to end of buffer.
(setq next-line-add-newlines nil)

(setq inhibit-startup-message t) ; seen it
(setq delete-auto-save-files t)
(setq make-backup-files nil)

(autoload 'electric-buffer-list "ebuff-menu")
(global-set-key "\C-x\C-b" 'electric-buffer-list)

;; Make - and . parts of words so dabbrevs can expand
;; them correctly; and so filename expansion skips over them.
(modify-syntax-entry ?- "w   " lisp-mode-syntax-table)
(modify-syntax-entry ?* "w   " lisp-mode-syntax-table)
(modify-syntax-entry ?_ "w   " lisp-mode-syntax-table)
(modify-syntax-entry ?~ "w   " lisp-mode-syntax-table)

(modify-syntax-entry ?- "w   " emacs-lisp-mode-syntax-table)
(modify-syntax-entry ?* "w   " emacs-lisp-mode-syntax-table)
(modify-syntax-entry ?_ "w   " emacs-lisp-mode-syntax-table)

(modify-syntax-entry ?- "w   " c-mode-syntax-table)
(modify-syntax-entry ?. "w   " c-mode-syntax-table)
(modify-syntax-entry ?* "w   " c-mode-syntax-table)
(modify-syntax-entry ?_ "w   " c-mode-syntax-table)

(modify-syntax-entry ?- "w   " text-mode-syntax-table)
(modify-syntax-entry ?. "w   " text-mode-syntax-table)
(modify-syntax-entry ?* "w   " text-mode-syntax-table)
(modify-syntax-entry ?_ "w   " text-mode-syntax-table)

(modify-syntax-entry ?- "w   " (standard-syntax-table))
(modify-syntax-entry ?. "w   " (standard-syntax-table))
(modify-syntax-entry ?* "w   " (standard-syntax-table))
(modify-syntax-entry ?_ "w   " (standard-syntax-table))

;; This switches tab and space so space will be the one that completes as
;; far as possible, which is the one we usually want.
(define-key minibuffer-local-must-match-map "\040" 'minibuffer-complete)
(define-key minibuffer-local-must-match-map "\011" 'minibuffer-complete-word)
(define-key minibuffer-local-completion-map "\040" 'minibuffer-complete)
(define-key minibuffer-local-completion-map "\011" 'minibuffer-complete-word)

(require 'compile)
(setq compilation-error-regexp-alist
  (append (list
     ;; works for jikes
     '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):\\([0-9]+\\):[0-9]+:[0-9]+:" 1 2 3)
     ;; works for javac
     '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):" 1 2))
  compilation-error-regexp-alist))

(custom-set-variables)
(custom-set-faces
 '(font-lock-string-face ((t (:foreground "Red")))))

(defalias 'teachercom
  (read-kbd-macro
   "C-SPC C-e ESC w C-x C-f C-y RET C-x b RET C-s <pre> C-a C-SPC C-s </pre> C-f C-x C-x ESC w C-x b RET C-y C-x C-s C-x k RET C-x C-x C-n C-g"))

(global-set-key (quote [f12])
  (lambda nil (interactive) (execute-kbd-macro 'teachercom)))

;; Poor Man's PowerPoint

(global-set-key (quote [f2])
  '(lambda nil (interactive)
     (while (looking-at "^$") (backward-char))
     (while (not (looking-at "^$")) (backward-char))
))
(global-set-key (quote [f3])
  '(lambda nil (interactive)
     (while (looking-at "^$") (forward-char))
     (while (not (looking-at "^$")) (forward-char))
))
(global-set-key (quote [f11])
  '(lambda nil (interactive) (open-line 33)
     (while (looking-at "^$") (forward-char))
     (while (not (looking-at "^$")) (forward-line 1))
))
(global-set-key (quote [f12])
  '(lambda nil (interactive)
     (while (looking-at "^$") (delete-char))
     (open-line 1)
     (forward-line 1)
     (while (not (looking-at "^$")) (forward-line 1))
))

;(global-set-key "\C-c" 'kill-ring-save)
;(global-set-key "\C-x" 'kill-region)
;(global-set-key "\C-v" 'yank)

;Add ruby mode...
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
;(setq load-path (append load-path '("~/.emacs_include")))

;Add php mode...
(autoload 'php-mode "php-mode" "Major mode for editing php scripts." t)
(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("php" . php-mode)) interpreter-mode-alist))
(setq load-path (append load-path '("~/.emacs_include")))

