(require 'package)

;;; Code:
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
	 nil
       (if (y-or-n-p (format "Package %s is missing.Install it? " package))
	   (package-install package)
	 package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Assuming you wish to install "iedit" and "magit"
(ensure-package-installed 'iedit 'magit 'helm 'evil 'flycheck 'alchemist 'yasnippet 'powerline 'ctags 'git-gutter 'robe 'dockerfile-mode 'ample-theme 'evil-mc 'fancy-battery 'markdown-mode 'indent-guide 'minimap 'sr-speedbar 'projectile 'helm-projectile 'use-package 'minitest 'slim-mode 'ujelly-theme 'dracula-theme 'haml-mode 'yaml-mode 'coffee-mode 'rubocop 'jbeans-theme 'evil-matchit 'whitespace 'synonyms 'zenburn-theme)

(require 'whitespace)
(require 'evil-matchit)
(global-evil-matchit-mode t)

(require 'synonyms)

;; Disable autosave
(setq auto-save-default nil)

(require 'powerline)
(powerline-default-theme)

(global-flycheck-mode t)

(add-hook 'ruby-mode-hook 'robe-mode)
(require 'indent-guide)
(indent-guide-global-mode t)
(require 'helm-config)
(require 'evil)
(require 'evil-mc)
(require 'yasnippet)
(evil-mode t)
(helm-mode t)
(global-evil-mc-mode t)

(global-company-mode t)
(setq company-minimum-prefix-length 1)

(eval-after-load 'company
  '(push 'company-robe company-backends))

(require 'git-gutter)
(global-git-gutter-mode t)

(git-gutter:linum-setup)
(global-linum-mode t)


(yas-global-mode t)


(require 'ido)
(ido-mode t)
(setq make-backup-files nil)

(add-hook 'elixir-mode-hook 'alchemist-mode)

(show-paren-mode 1)

;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(require 'helm-config)
(require 'helm-misc)
(require 'helm-locate)
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)

(global-set-key (kbd "M-x") 'helm-M-x)

(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(electric-pair-mode t)

(defun helm-my-buffers ()
  (interactive)
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm-other-buffer '(helm-c-source-buffers-list
			 helm-c-source-elscreen
			 helm-c-source-ctags
			 helm-c-source-recentf
			 helm-c-source-locate)
		       "*helm-my-buffers*")))

;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
(defvar company-mode/enable-yas t "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
	    '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
	(backward-char 1)
	(if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (cond
   ((minibufferp)
    (minibuffer-complete))
   (t
    (indent-for-tab-command)
    (if (or (not yas/minor-mode)
	    (null (do-yas-expand)))
	(if (check-expansion)
	    (progn
	      (company-manual-begin)
	      (if (null company-candidates)
		  (progn
		    (company-abort)
		    (indent-for-tab-command)))))))))

(defun tab-complete-or-next-field ()
  (interactive)
  (if (or (not yas/minor-mode)
	  (null (do-yas-expand)))
      (if company-candidates
	  (company-complete-selection)
	(if (check-expansion)
	    (progn
	      (company-manual-begin)
	      (if (null company-candidates)
		  (progn
		    (company-abort)
		    (yas-next-field))))
	  (yas-next-field)))))

(defun expand-snippet-or-complete-selection ()
  (interactive)
  (if (or (not yas/minor-mode)
	  (null (do-yas-expand))
	  (company-abort))
      (company-complete-selection)))

(defun abort-company-or-yas ()
  (interactive)
  (if (null company-candidates)
      (yas-abort-snippet)
    (company-abort)))

(global-set-key [tab] 'tab-indent-or-complete)
(global-set-key (kbd "TAB") 'tab-indent-or-complete)
(global-set-key [(control return)] 'company-complete-common)

(define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
(define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

(define-key yas-minor-mode-map [tab] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(define-key yas-keymap [tab] 'tab-complete-or-next-field)
(define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
(define-key yas-keymap [(control tab)] 'yas-next-field)
(define-key yas-keymap (kbd "C-g") 'abort-company-or-yas)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-args-compile (quote ("-c" "--no-header" "--bare")))
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("4ab95b35f7720043592b49d890003874aa1954a3cf299edde13657c6a9182d85" "4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" "be4025b1954e4ac2a6d584ccfa7141334ddd78423399447b96b6fa582f206194" "45712b65018922c9173439d9b1b193cb406f725f14d02c8c33e0d2cdad844613" "345f8f92edc3508574c61850b98a2e0a7a3f5ba3bb9ed03a50f6e41546fe2de0" "d1abda58eedee72fbe28bbb7a5ff1953e1b7d2fa80913bcea9cb3cf12cf751f4" "f9805a89d4309ca29b68c4a6b3d8f13f7931603e59b881515a27535d6ffa1a6e" "12b4427ae6e0eef8b870b450e59e75122d5080016a9061c9696959e50d578057" "ad950f1b1bf65682e390f3547d479fd35d8c66cafa2b8aa28179d78122faa947" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" "4f5bb895d88b6fe6a983e63429f154b8d939b4a8c581956493783b2515e22d6d" default)))
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "~")
 '(org-agenda-files
   (quote
    ("~/org/daily.org" "~/org/unsorted.org" "~/org/projects.org")))
 '(package-selected-packages
   (quote
    (xpm synonyms evil-matchit jbeans-theme rubocop coffee-mode yaml-mode haml-mode dracula-theme ujelly-theme slim-mode minitest use-package helm-projectile projectile sr-speedbar minimap indent-guide markdown-mode fancy-battery evil-mc ample-theme dockerfile-mode robe git-gutter ctags powerline yasnippet alchemist flycheck evil helm magit iedit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(if (display-graphic-p) 
    (load-theme 'jbeans) 
  (load-theme 'jbeans))

(display-time-mode t)
(fancy-battery-mode t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setq org-default-notes-file (expand-file-name "~/org/unsorted.org"))

(setq org-refile-targets '((nil :maxlevel . 3)
			   (org-agenda-files :maxlevel . 3) ("done.org" :maxlevel . 3 ) ("ideas.org" :maxlevel . 3)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "IN-PROGRESS" "|" "DONE" "DELEGATED" "IGNORE")))
(setq org-log-done 'time)
(setq org-log-done 'note)
(setq org-agenda-start-on-weekday 0)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(set-face-foreground 'git-gutter:modified "orange")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(global-set-key (kbd "M-l") 'helm-buffers-list)
(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "M-s") (lambda () (interactive) (sr-speedbar-toggle) (sr-speedbar-select-window)))
;; Show diary in agenda
(setq org-agenda-include-diary t)

(setq speedbar-supported-extension-expressions '(
						 ".md"
						 ".emacs"
						 ".rb"
						 ".exs"
						 ".ex"
						 ".eex"
						 ))

(add-hook 'term-mode-hook (lambda()
			    (setq yas-dont-activate t)))
(use-package helm-projectile
  :ensure t
  :init
  (projectile-global-mode)
  (helm-projectile-on)
  (setq projectile-completion-system 'helm)
  (setq projectile-switch-project-action 'helm-projectile)
  (defvar helm-source-file-not-found
    (helm-build-dummy-source
	"Create file"
      :action 'find-file))
  (add-to-list 'helm-projectile-sources-list helm-source-file-not-found t)
  )

(require 'minitest)
(add-hook 'ruby-mode-hook 'minitest-mode)
(eval-after-load 'minitest '(minitest-install-snippets))

(require 'slim-mode)

;; Source: http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t))

(add-hook 'haml-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (define-key haml-mode-map "\C-m" 'newline-and-indent))
	  )
(add-hook 'yaml-mode-hook
	  (lambda ()
	    (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; coffeescript


(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

(add-hook 'ruby-mode-hook 'rubocop-mode)
(setq-default cursor-type '(bar . 1))
(set-face-attribute 'default nil :height 140)
