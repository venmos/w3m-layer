;;; packages.el --- w3m layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Kuroi Mato <venmos@fuck.gfw.es>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

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
      (spacemacs/set-leader-keys
        "awb" 'helm-w3m-bookmarks))))

(defun v/w3m-open-url (url)
  "Opens url in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address (default: google.com):" nil nil "google.com" nil )))
  (w3m-goto-url
   (concat "http://" url)))

(defun v/w3m-open-url-new-session (url)
  "Opens url in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address (default: google.com):" nil nil "google.com" nil )))
  (w3m-goto-url-new-session
   (concat "http://" url)))

(defun w3m/init-w3m()
  "Initializes w3m and adds keybindings for its exposed functionalities."
  (use-package w3m
    :defer t
    :init
    (spacemacs/set-leader-keys
      "awo" 'v/w3m-open-url
      "awf" 'w3m-find-file
      "aws" 'w3m-search
      )
    (progn
        (evilified-state-evilify-map w3m-mode-map
          :mode w3m-mode
          :eval-after-load w3m
          :bindings
          "wf" 'w3m-find-file
          "wo" 'v/w3m-open-url
          "wO" 'v/w3m-open-url-new-session
          "wt" 'w3m-view-this-url-new-session
          "wT" 'w3m-create-empty-session
          "ws" 'w3m-search
          "wS" 'w3m-search-new-session
          "wl" 'w3m-next-buffer
          "wh" 'w3m-previous-buffer
          "wd" 'w3m-delete-buffer
          "we" 'w3m-bookmark-edit
          "wa" 'w3m-bookmark-add-current-url
          "wm" 'w3m-view-url-with-external-browser
          "wb" 'helm-w3m-bookmarks
          "wB" 'w3m-bookmark-view
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
