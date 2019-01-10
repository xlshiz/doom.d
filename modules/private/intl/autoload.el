;;; private/intl/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +intel/re-builder-pinyin (str)
  (or (+intel/pinyin-to-utf8 str)
      (ivy--regex-plus str)
      (ivy--regex-ignore-order str)
      ))

;;;###autoload
(defun +intel/pinyinlib-build-regexp-string (str)
  (progn
    (cond ((equal str ".*")
           ".*")
          (t
           (pinyinlib-build-regexp-string str t))))
  )

;;;###autoload
(defun +intel/pinyin-regexp-helper (str)
  (cond ((equal str " ")
         ".*")
        ((equal str "")
         nil)
        (t
         str)))

;;;###autoload
(defun +intel/pinyin-to-utf8 (str)
  (cond ((equal 0 (length str))
         nil)
        ((equal (substring str 0 1) "!")
         (mapconcat '+intel/pinyinlib-build-regexp-string
                    (remove nil (mapcar '+intel/pinyin-regexp-helper (split-string
                                                                  (substring str 1) "")))
                    ""))
        (t nil)))
