;; -*- lexical-binding: t; -*-

(unless (= (length argv) 1)
  (print "Please provide argument: <day_num>")
  (kill-emacs))
(defconst DAY_NUM (car argv))

(defconst INPUT_FILE (expand-file-name (format "./day-%s/input.txt" DAY_NUM) default-directory))
(unless (file-exists-p INPUT_FILE)
  (print (format "Input file for day %s does not exist." DAY_NUM))
  (kill-emacs))
(defconst INPUT (with-temp-buffer
                  (insert-file-contents INPUT_FILE)
                  (buffer-string)))
(add-to-list 'load-path default-directory)
(require 'utils)

(add-to-list 'load-path (expand-file-name (format "./day-%s" DAY_NUM) default-directory))
(unless (require 'solution nil t)
  (print (format "Cannot load solution for day %s." DAY_NUM))
  (kill-emacs))

(let ((part1 (intern "ANSWER-PART1"))
      (part2 (intern  "ANSWER-PART2")))
  (if (boundp part1)
      (print (symbol-value part1))
    (print "Cannot find answer to part 1."))
  (if (boundp part2)
      (print (symbol-value part2))
    (print "Cannot find answer to part 2.")))
