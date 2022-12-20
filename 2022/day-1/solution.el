;; -*- lexical-binding: t; -*-
(defconst ELVES
  (mapcar (lambda (elf) (mapcar 'string-to-number (s-lines elf)))
          (s-split "\n\n" INPUT))
  "Process input into a list-of list-of numbers, representing the
caloric values of each item held by each elf.")

(defconst TOTALS
  (mapcar (lambda (elf) (apply '+ elf)) ELVES)
  "Total calories held by each elf.")

;; 67027
(defconst ANSWER-PART1
  (apply 'max TOTALS)
  "The highest caloric value held by any elf.")

;; 197291
(defconst ANSWER-PART2
  (apply '+ (-take 3 (sort TOTALS '>)))
  "The sum of the three highest caloric values.")

(provide 'solution)
