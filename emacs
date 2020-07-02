
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; set font
(set-default-font "Source Code Pro 13")

;; set up Powerline (see github.com/jonathanchu/emacs-powerline for install
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)

;; set dark theme and transparent background
(require 'moe-theme)
(moe-theme-set-color 'cyan)
;; available colors: blue, orange, green, magenta, yellow, purple, red, cyan, w/b
(moe-dark)
(set-frame-parameter (selected-frame) 'alpha '(92 . 90))
(add-to-list 'default-frame-alist '(alpha . (92 . 90)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote default))
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/Dropbox/calendar.org")))
 '(package-selected-packages
   (quote
    (markdown-mode+ biblio moe-theme powerline helm-themes helm ranger markdown-mode ein reykjavik-theme auctex)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

; default window width and height
(defun custom-set-frame-size ()
  (add-to-list 'default-frame-alist '(height . 48))
  (add-to-list 'default-frame-alist '(width . 145)))
(custom-set-frame-size)
(add-hook 'before-make-frame-hook 'custom-set-frame-size)

; setup org mode stuff
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (R . t)
   (latex . t)
   ))

;; setting up org-agenda
(setq org-agenda-files
      '("~/Dropbox/calendar.org"))
(global-set-key "\C-ca" 'org-agenda)

;; setting up additional org-latex-classes
;; FoilTeX
(require 'ox-latex)
(add-to-list 'org-latex-classes
              '("foils"
                "\\documentclass{foils}"
                ("\\foilhead[-1cm]{%s}" . "\\foilhead[-1cm]*(%s)"))
              )

;; control line wrapping in org mode
(setq org-startup-truncated nil)
;; define a key to toggle line truncation
(define-key org-mode-map "\M-q" 'toggle-truncate-lines)

;; fix spacing in src code blocks
(setq org-src-preserve-indentation nil
      org-edit-src-content-indentation 0)

;; set up mu4e
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)

(setq mu4e-get-mail-command "offlineimap")

(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/local/bin/msmtp")

(setq  user-mail-address "faulkenberry@tarleton.edu"
       user-full-name "Faulkenberry, Dr. Thomas")

(setq mu4e-sent-messages-behavior 'delete
      mu4e-compose-signature-auto-include 'nil)

;; set up LaTeX path for AUCTeX (needed for Catalina)
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))

