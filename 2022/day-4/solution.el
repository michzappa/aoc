;; -*- lexical-binding: t; -*-

(defconst ASSIGNMENTS (-map (lambda (pair)
                              (-map (lambda (assignment)
                                      (-map 'string-to-number (s-split "-" assignment)))
                                    (s-split "," pair)))
                            (-drop-last 1 (s-lines INPUT)))
  "A list-of list-of list-of numbers, representing all the section
assignments.")

(defun fully-contained? (range1 range2)
  "Is `range1' fully contained within `range2'?"
  (and (<= (-first-item range2) (-first-item range1))
       (>= (-second-item range2) (-second-item range1))))

(defconst ANSWER-PART1
  (length (-filter (lambda (pair)
                     (let ((first (-first-item pair))
                           (second (-second-item pair)))
                       (or (fully-contained? first second)
                           (fully-contained? second first))))
                   ASSIGNMENTS)))

(defun overlap? (range1 range2)
  "Does `range1' overlap `range2'"
  (and (<= (-first-item range1) (-second-item range2))
       (<= (-first-item range2) (-second-item range1))))

(defconst ANSWER-PART2
  (length (-filter (lambda (pair)
                     (let ((first (-first-item pair))
                           (second (-second-item pair)))
                       (overlap? first second)))
                   ASSIGNMENTS)))

(provide 'solution)
