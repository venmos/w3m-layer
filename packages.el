;;; packages.el --- w3m layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Kuroi Mato <venmos@Xubuntu>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `w3m-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `w3m/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `w3m/pre-init-PACKAGE' and/or
;;   `w3m/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(setq w3m-packages
      '(
        w3m
        helm-w3m
        ))

(defun w3m/init-helm-w3m ()
  "Initializes helm-w3m and adds keybindings for its exposed functionalities."
  (use-package helm-w3m
    :commands (helm-w3m-bookmarks)
    :init
    (progn
      (evil-leader/set-key
        "awb" 'helm-w3m-bookmarks))))

(defun v/w3m-open-site (site)
  "Opens site in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address (default: google.co.jp):" nil nil "google.co.jp" nil )))
  (w3m-goto-url
   (concat "http://" site)))

(defun v/w3m-open-site-new-session (site)
  "Opens site in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address (default: google.co.jp):" nil nil "google.co.jp" nil )))
  (w3m-goto-url-new-session
   (concat "http://" site)))

(defun w3m/init-w3m()
  "Initializes w3m and adds keybindings for its exposed functionalities."
  (use-package w3m
    :init
    (progn
      (spacemacs/set-leader-keys
        "awo" 'v/w3m-open-site
        "awg" 'w3m-goto-url
        "awG" 'w3m-goto-url-new-session
        "aws" 'w3m-search
        "awS" 'w3m-search-new-session
        (evilified-state-evilify-map w3m-mode-map
          :mode w3m-mode
          :eval-after-load w3m
          :bindings
          "wh" 'w3m-next-buffer
          "wl" 'w3m-tab-next-buffer)
          "wx" 'w3m-delete-buffer
        ))))

(with-eval-after-load 'w3m
  (define-key w3m-mode-map (kbd "C-f") 'evil-scroll-page-down)
  (define-key w3m-mode-map (kbd "C-b") 'evil-scroll-page-up)
  (define-key w3m-mode-map (kbd "SPC") 'evil-evilified-state))

(defun v/init-w3m ()
  (use-package w3m
    :init
    (progn
      (setq-default browse-url-browser-function 'w3m-goto-url-new-session)
      (setq-default w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533."))))

;;; packages.el ends here
