(warn "Loading .emacs")
(load-library "xscheme")
(add-to-list 'load-path "~/lib/emacs")
(autoload 'enable-paredit-mode "paredit-beta"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(setq transient-mark-mode 1)
;;; Enabler couple of hooks so scheme mode major mode and paredit mode come up at the same time
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'inferior-scheme-mode-hook 'enable-paredit-mode)
