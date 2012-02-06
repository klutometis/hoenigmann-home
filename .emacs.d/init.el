(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages
  '(
    haskell-mode
    magit
    starter-kit
    starter-kit-bindings
    starter-kit-eshell
    starter-kit-lisp
    unbound
    )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; Remove line-highlighting.
(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

;;; Peters additions.
(define-skeleton org-mode-src-skel
  "Insert #+BEGIN_SRC <source>...#+END_SRC blocks."
  "Source: "
  >
  "#+BEGIN_SRC " str
  \n
  _
  \n
  "#+END_SRC"
  > \n)

(define-skeleton org-mode-example-skel
  "Insert #+BEGIN_EXAMPLE...#+END_EXAMPLE blocks."
  nil
  >
  "#+BEGIN_EXAMPLE"
  \n
  _
  \n
  "#+END_EXAMPLE"
  > \n)

(define-skeleton org-mode-quote-skel
  "Insert #+BEGIN_QUOTE...#+END_QUOTE blocks."
  nil
  >
  "#+BEGIN_QUOTE"
  \n
  _
  \n
  "#+END_QUOTE"
  > \n)

(add-hook
 'org-mode-hook
 (lambda ()
    (define-key org-mode-map (kbd "C-c C-x C-s") 'org-mode-src-skel)
    (define-key org-mode-map (kbd "C-c C-x C-q") 'org-mode-quote-skel)
    (define-key org-mode-map (kbd "C-c C-x C-e") 'org-mode-example-skel)))

;;; Hitting return opens link in browser.
(setq org-return-follows-link t)

;;; org-mode statuses
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)" "CANCELED(c)")))

;;; Allows you to set a note when switching from TODO to DONE.
(setq org-log-done 'note)

;;; Evaluate whole Scheme buffer.
(defun scheme-send-buffer ()
  "Just send the goddamn thing."
  (interactive)
  (scheme-send-region (point-min) (point-max)))

(defun scheme-send-buffer-and-go ()
  "Send and go."
  (interactive)
  (scheme-send-buffer)
  (switch-to-buffer-other-window "*scheme*"))

(add-hook
 'scheme-mode-hook
 (lambda ()
   (define-key scheme-mode-map (kbd "C-c b") 'scheme-send-buffer)
   (define-key scheme-mode-map (kbd "C-c B") 'scheme-send-buffer-and-go)))

;;; Answer yes-or-no questions with <return>.
(define-key query-replace-map (kbd "C-m") 'act)
