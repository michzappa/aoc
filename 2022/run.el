;; -*- lexical-binding: t; -*-
(require 'cl-lib)
(require 'dash)
(require 'f)
(require 's)

(unless (= (length argv) 2)
  (print "Please provide arguments: <day_num> <part_num>")
  (kill-emacs))
(defconst DAY_NUM (-first-item argv))
(defconst PART_NUM (-second-item argv))

(defconst INPUT_FILE (expand-file-name (format "./day-%s/input.txt" DAY_NUM) default-directory))
(unless (file-exists-p INPUT_FILE)
  (print (format "Input file for day %s does not exist." DAY_NUM))
  (kill-emacs))
(defconst INPUT (f-read INPUT_FILE))

(add-to-list 'load-path (expand-file-name (format "./day-%s" DAY_NUM) default-directory))
(unless (require 'solution nil t)
  (print (format "Cannot load solution for day %s." DAY_NUM))
  (kill-emacs))

(print (symbol-value (intern (format "ANSWER-PART%s" PART_NUM))))
