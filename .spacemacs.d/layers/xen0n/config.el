;; line number and fringe
(defun xen0n/config-linum ()
  ;; https://stackoverflow.com/a/21862698
  (setq-default linum-format "%3d ")
  (set-face-attribute
   'linum nil
   :background "#073642"
   :foreground "#586e75"
   :slant 'normal)

  ;; https://gist.github.com/whitlockjc/33fdf9bbdb9758dc2cbb
  ;; Custom face/function to pad the line number in a way that does not conflict with whitespace-mode
  (defface linum-padding
    `((t :inherit 'linum
         :foreground ,(face-attribute 'linum :background nil t)))
    "Face for displaying leading zeroes for line numbers in display margin."
    :group 'linum)

  (defun linum-format-func (line)
    (let ((w (length
              (number-to-string (count-lines (point-min) (point-max))))))
      (concat
       (propertize " " 'face 'linum-padding)
       (propertize (make-string (- w (length (number-to-string line))) ?0)
                   'face 'linum-padding)
       (propertize (number-to-string line) 'face 'linum)
       (propertize " " 'face 'linum-padding)
       )))

  (setq linum-format 'linum-format-func))
