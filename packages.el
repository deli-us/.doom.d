;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! yang-mode :recipe (:host github :repo "mbj4668/yang-mode" :branch "master"))
(package! lux-mode :recipe (:local-repo  "system/test/lib/lux/" :branch "master" :files  ("emacs/lux-mode.el")))
;;(package! lux-mode :recipe (:host github :repo "hawk/lux" :branch "master" :files  ("emacs/lux-mode.el")))

(package! beacon)

(package! rfc-mode :recipe (:host github :repo "galdor/rfc-mode" :branch "master"))
(package! wsd-mode :recipe (:host github :repo "josteink/wsd-mode" :branch "master"))
(package! dot-mode :recipe (:host github :repo "ppareit/graphviz-dot-mode" :branch "master"))

;;(package! daml-mode :recipe (:local-repo  "~/git/daml/" :branch "master" :files  ("emacs/mode-mode.el")))

(package! qrencode :recipe (:host github :repo "ruediger/qrencode-el" :branch "main"))
;;https://github.com/ruediger/qrencode-el

(package! gptel :recipe (:host github :repo "karthink/gptel" :branch "master"))

(package! origami)
(package! lsp-origami)

(package! org-reveal)
(package! ox-reveal)

(package! haskell-mode)
(package! lsp-haskell)
