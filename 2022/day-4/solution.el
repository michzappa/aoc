;; -*- lexical-binding: t; -*-

(defconst ASSIGNMENTS (mapcar (lambda (pair)
                                (mapcar (lambda (assignment)
                                          (mapcar 'string-to-number (split-string assignment "-")))
                                        (split-string pair ",")))
                              (seq-drop-final (split-string-lines INPUT)))
  "A list-of list-of list-of numbers representing section assignments to each elf.")

(defun fully-contained? (range1 range2)
  "Is RANGE1 fully contained within RANGE2? Ranges are pairs of
numbers where car < cadr."
  (and (<= (car range2) (car range1))
       (>= (cadr range2) (cadr range1))))

;; 464
(defconst ANSWER-PART1
  (length (seq-filter (lambda (pair)
                        (let ((first (car pair))
                              (second (cadr pair)))
                          (or (fully-contained? first second)
                              (fully-contained? second first))))
                      ASSIGNMENTS))
  "How many assignment pairs have one range fully contain the other.")

(defun overlap? (range1 range2)
  "Does RANGE1 overlap RANGE2? Ranges are pairs of
numbers where car < cadr."
  (and (<= (car range1) (cadr range2))
       (<= (car range2) (cadr range1))))

;; 770
(defconst ANSWER-PART2
  (length (seq-filter (lambda (pair)
                        (let ((first (car pair))
                              (second (cadr pair)))
                          (overlap? first second)))
                      ASSIGNMENTS))
  "How many assignment pairs have overlapping ranges.")

(provide 'solution)
