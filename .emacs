;; author: dhuang 
;; email : dhuang8115@gmail.com
;;Time-stamp: <2012-04-06 Fri 20:12:48>
;; enable evil plug-in(vim keybinding support)
;;; must define before default-major-mode!!!
(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/evil/lib/")
(require 'undo-tree)  
(require 'evil)  
(evil-mode 1)
;;; set text-mode as default mode
(setq default-major-mode 'text-mode)
;;;;;;;;;;customize-browser generate options;;;;;;;;;; 
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-source-correlate-method (quote auto))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list (quote (("okular" "okular --unique %o#src:%n%b"))))
 '(TeX-view-program-selection (quote ((output-pdf "okular") ((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "xpdf") (output-html "xdg-open"))))
 '(abbrev-mode t)
 '(auto-image-file-mode t)
 '(auto-insert t)
 '(auto-insert-mode t)
 '(backup-by-copying-when-linked t)
 '(backup-directory-alist (quote (("." . "~/emacs_backup"))))
 '(calendar-chinese-all-holidays-flag t)
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-scroll-output (quote first-error))
 '(dict-nocorrect nil)
 '(dict-servers (quote ("localhost")))
 '(f90-auto-keyword-case (quote capitalize-word))
 '(f90-mode-hook (quote (f90-add-imenu-menu)))
 '(org-insert-heading-respect-content t)
 '(org-modules (quote (org-bbdb org-bibtex org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-annotate-file org-bookmark org-eval-light org-invoice org-man org-panel org-R org2rem org-track)))
 '(org-startup-indented t)
 '(popwin:special-display-config (quote (("*Help*") \\ ("*Async Shell Command*") \\ ("*Completions*" :noselect t) \\ ("*Occur*" :noselect t) \\ ("*MATLAB*"))))
 '(python-python-command "ipython")
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(split-width-threshold 80)
 '(user-mail-address "dhuang8115@gmail.com")
 '(x-select-enable-clipboard t))
;;;test;;;
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )



;; This was installed by package-install.el.
;; This provides support for the package system and
;; interfacing with ELPA, the package archive.
;; Move this code earlier if you want to reference
;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;; auto-complete plug-in
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete-config)
(ac-config-default)


;;; enable ibus input method
;;; ibus plug-in can be download via ppa source: 
;;; sudo add-apt-repository ppa:irie/elisp
;;; sudo apt-get update

;;;and install ibus-el package:
;;;
;;;sudo apt-get install ibus-el
;;;right now(2012-01-19 Thu 05:01 PM) the ibus v0.3 from ubuntu source has attibute errors
;;;use 0.2.1 instead
(add-to-list 'load-path "~/.emacs.d/ibus-el-0.2.1/")
(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)
;;;display line number
(global-linum-mode 1)
;;;set up color scheme
;;;require emacs-goodies-el support
;;;apt-get install emacs-goodies-el
(require 'color-theme)
(color-theme-initialize)
(color-theme-comidia)

;;;set up font to monospace 12pt
;;;use (frame-parameter nil 'font) in scratch buffer to get the current font name
(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")

;;; get rid of splash screen at start up
(setq inhibit-splash-screen t)
;;; instead start shell when emacs start
;; (add-hook 'after-init-hook 'eshell)

;;; use xetex output org-mode file(not working)
;; (setq org-latex-to-pdf-process 
;; '("xelatex -interaction nonstopmode %f"
;;   "xelatex -interaction nonstopmode %f")) ;; for multiple passes

;;; delete file in dired mode go to .trash folder
(setq delete-by-moving-to-trash t)

;;; define NerdCommenter like keybinding for comment/uncomment

(defadvice comment-or-uncomment-region (before slickcomment activate compile)
  "When called interactively with no active region, toggle comment on current line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(global-set-key (kbd "C-=") 'comment-or-uncomment-region)

;; define async-shell-command keyboard shortcut

(global-set-key [(f1)] 'async-shell-command)



;;; define kyboad shortcut: switching to eshell buffer
;;; THOUGHT: press f1 should return to previous buffer
;;; longer version
(defun switch-to-shell()
       "Switch to *shell* buffer and start eshell mode"
       (interactive)
       (switch-to-buffer "*shell*")
       (shell))
(global-set-key [S-f1] 'switch-to-shell)
;; short version
;; not getinto eshell mode if the *eshell* buffer was deleted before
;; (global-set-key [S-f1] (lambda () (interactive) (switch-to-buffer "*eshell*" 'eshell)))

;; shorten yes/no to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; enable tabbar mode
(tabbar-mode t)



;; open/close nav mode when f5 is pressed;;
;; (require 'nav)  ;; emacs-nav
;; (autoload 'nav "nav" "Runs nav-mode in a narrow window on the left side" t)
(add-to-list 'load-path "~/.emacs.d/nav")
(require 'nav)

(defun kill-buffer-and-its-windows (buffer)
  "Kill BUFFER and delete its windows.  Default is `current-buffer'.
BUFFER may be either a buffer or its name (a string)."
  (setq buffer (get-buffer buffer))
  (cond ((buffer-live-p buffer)         ; Kill live buffer only.
         (let ((wins (get-buffer-window-list buffer nil nil))) ; Only on current frames.
           (when (kill-buffer buffer)   ; Only delete windows if buffer killed.
             (dolist (win wins)         
               (when (window-live-p win) (delete-window win))))))
	))

(defun nav-customize-toggle()
  "switch on/off nav buffer and window"
  (interactive)
  (if (get-buffer "*nav*")
      (kill-buffer-and-its-windows "*nav*")
    (progn(nav)(nav-disable-emacs23-window-splitting))))


(global-set-key [(f5)] 'nav-customize-toggle)

;; switch between text-mode and normal mode
(defun text-normal-toggle ()
  (interactive)
  (save-excursion
     (if (eq major-mode 'text-mode)
      (normal-mode)
    (text-mode))
))

(global-set-key [(f6)] 'text-normal-toggle)

;; enable emacsd-tile plug-in,use emacs as a tiled windows manager
;; this plugin rebind a lot of global kemappings,be careful with shortcut conflict!!
(add-to-list 'load-path "~/.emacs.d/emacsd-tile")
(require 'emacsd-tile)

;; keyboard shotcut for kill-buffer-and-window
(global-set-key [S-f12] 'kill-buffer-and-window)

;; setting auto-fill-mode
(setq-default auto-fill-function 'do-auto-fill)
;; set rencent file list
;; open the most recent edit file when emacs start
(recentf-mode) 
;; (add-hook 'after-init-hook 'recentf-open-most-recent-file-1)
(add-hook 'after-init-hook 'recentf-open-files)

;; save desktop enviorment
;; (desktop-save-mode 1)

;; in gnu-emacs-23.2.1,killing emacs would not kill the server socket file(/tmp/emacs/1000)
;; when delete-by-moving-to-trash was enabled
;; this bug(feature?) will cause connection refuse when user trys to start server again
;; here is a workaround about it,just disable del-by-mov-to-trash when
;; calling server related functions
(defmacro bypass-trash-in-function (fun)
  "Set FUN to always use normal deletion, and never trash.

Specifically, the value of `delete-by-moving-to-trash' will be
set to nil inside FUN, so any deletions that happen inside FUN or
any functions called by it will bypass the trash."
  `(defadvice ,fun (around no-trash activate)
     "Ignore `delete-by-moving-to-trash' inside this function.

See `bypass-trash-in-function' for more information."
     (let (delete-by-moving-to-trash)
       ad-do-it)))

;; Any server function that may delete the server file should never
;; move it to trash instead.
(mapc (lambda (fun) (eval `(bypass-trash-in-function ,fun)))
      '(server-start server-sentinel server-force-delete))

;; start emacs-server
(server-start)

;; popwin plugin
(add-to-list 'load-path "~/.emacs.d/popwin/")
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; show parentheses
(show-paren-mode t)
(setq show-paren-style 'parentheses)


;; display time stamp
;; type "Time-stamp: < >" in the first 8 lines of a buffer will
;; enable auto time stamp update
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S")
(add-hook 'before-save-hook 'time-stamp)

;; verson control
;; move all backup file to another folder
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)

;; do not save backup file
(setq make-backup-files nil)

;; set up cycle-buffer plugin
(add-to-list 'load-path "~/.emacs.d/cycle-buffer")
(require 'cycle-buffer)
;; (global-set-key [(f9)]        'cycle-buffer-backward)
;; FIXME: key binding Ctrl-tab conflict with org-mode
;; the following line try to solve this problem
(global-set-key [f9] 'cycle-buffer)
;; set up cycle-buffer plugin

;; key binding for compiler
(global-set-key [(f7)] 'compile)

;; (setq split-height-threshold most-positive-fixnum)
;; (setq split-weight-threshold most-positive-fixnum) 
;; ("*compilation*" :noselect t)
;; cedet mode
;; (load-file "~/.emacs.d/cedet-1.0/common/cedet.el")
;; (global-ede-mode 1)
;; (global-srecode-minor-mode 1)
;; (semantic-load-enable-code-helpers)
;; (semantic-load-enable-semantic-debugging-helpers)
;; (require 'semantic-ia)
;; (require 'semantic-gcc)
 
;; nxhtml mode
;; (add-to-list 'load-path "~/.emacs.d/nxhtml")
;; (Require 'nxhtml)
(load "~/.emacs.d/nxhtml/autostart.el")


;; pymacs set Up
(add-to-list 'load-path "~/.emacs.d/pymacs/")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(setq pymacs-auto-restart t)

;; ropemacs
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;; css mode
(add-to-list 'load-path "~/.emacs.d/nxhtml/")
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)