;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;;Maximize the window upon startup.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(after! lsp-ui
  (setq lsp-ui-doc-enable t))


;; global beacon minor-mode
(use-package! beacon)
(after! beacon (beacon-mode 1))

(after! org
  (load-library "ox-reveal")
  (setq org-reveal-root "file:///path/to/reveal.js-master"))

(remove-hook 'doom-first-buffer-hook #'ws-butler-global-mode)

;; Generate erlang-ls config
(defconst erlang-ls-template "~/.doom.d/erlang_ls.config.template")

(defun my/write-erlang-ls-file (dir)
  (let ((dirname (expand-file-name dir)))
    (with-temp-file (concat dirname "/erlang_ls.config")
      (progn
        (insert-file-contents erlang-ls-template)
        (while (re-search-forward "<base>" nil t)
          (replace-match dirname))))))

(defun my/ensure-erlang-ls-template-exists ()
  (interactive)
  (let ((dir default-directory))
    (message "Instantiated erlang_ls.config to %s " dir)
    (my/write-erlang-ls-file dir)))

;(with-eval-after-load 'lsp-mode 
;  (progn
;    (setq lsp-enable-file-watchers nil)
;    (add-hook 'lsp-managed-mode-hook
;              (lambda ()
;                (when lsp-enable-on-type-formatting
;                 (warn "You have lsp-enable-on-type-formatting set to t"))))))

(use-package! lsp-mode

  :config
  ;; Enable LSP automatically for Erlang files
  (add-hook 'erlang-mode-hook #'lsp)

  ;; ELP, added as priority 0 (> -1) so takes priority over the built-in one
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("elp" "server"))
                    :major-modes '(erlang-mode)
                    :priority 0
                    :server-id 'erlang-language-platform))
  )

(with-eval-after-load 'yang-mode
  (progn
    (add-hook 'yang-mode-hook
              '(lambda ()
                 (setq c-basic-offset 2)))))

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; Disable drtr-mode
  (dtrt-indent-mode -1))

(use-package! whitespace
  :config
  (setq
    whitespace-style '(face tabs tab-mark spaces space-mark trailing newline newline-mark)
    whitespace-display-mappings '(
      (space-mark   ?\     [?\u00B7]     [?.])
      (space-mark   ?\xA0  [?\u00A4]     [?_])
      (newline-mark ?\n    [182 ?\n])
      (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t])))
  (global-whitespace-mode +1))

;;; Use ISO week numbering.
(setq calendar-week-start-day 1
      calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-function-name-face))
