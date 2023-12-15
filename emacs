(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; set font
(add-to-list 'default-frame-alist
             '(font . "Source Code Pro-14"))

;; set up Powerline (see github.com/jonathanchu/emacs-powerline for install
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)

;; set dark theme and transparent background
(require 'moe-theme)
;;(moe-theme-set-color 'cyan)
;; available colors: blue, orange, green, magenta, yellow, purple, red, cyan, w/b
(moe-light)
(set-frame-parameter (selected-frame) 'alpha '(92 . 90))
(add-to-list 'default-frame-alist '(alpha . (92 . 90)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(exec-path-from-shell pandoc-mode pandoc markdown-mode ranger markdown-preview-mode excorporate auctex-latexmk auctex moe-theme))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set up LaTeX path for AUCTeX (needed for Catalina)
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))

;; disable emacs automatic backup~ file and #auto-save#
(setq make-backup-files nil)
(setq auto-save-default nil)

;; wrap org mode files by default
(setq org-startup-truncated nil)

;; setup LaTeX FoilTeX slides from Emacs
(require 'ox-latex)
(add-to-list 'org-latex-classes
	     '("foils"
	       "\\documentclass{foils}"
	       ("\\foilhead[-1cm]{%s}" . "\\foilhead[-1cm]*(%s)"))
	     )


;; stuff to help with converting org to docx and pdf for book project

(exec-path-from-shell-initialize) ;; makes OS-X path available to Emacs -- needed for pandoc

(defun ox-export-via-pandoc ()
  "eval code chunks and export the current org file as docx and pdf"
  (interactive)
 ;; (org-babel-execute-buffer)
 ;; (save-buffer)
  (let* ((current-file (file-name-nondirectory buffer-file-name))
	 (basename (file-name-sans-extension current-file))
	 (docx-file (concat basename ".docx"))
	 (pdf-file (concat basename ".pdf")))
    (unless (file-directory-p "docx-exports")
      (shell-command "mkdir docx-exports"))
    (shell-command (format
		    "pandoc -s %s -o docx-exports/%s"
		    current-file docx-file))
    (unless (file-directory-p "pdf-exports")
      (shell-command "mkdir pdf-exports"))
    (shell-command (format
		    "pandoc -s %s -o pdf-exports/%s"
		    current-file pdf-file))
    ))

(global-set-key (kbd "C-c p") 'ox-export-via-pandoc)

;; don't ask for confirmation when running org code chunks
(setq org-confirm-babel-evaluate nil)
(put 'downcase-region 'disabled nil)
