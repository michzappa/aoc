;; -*- lexical-binding: t; -*-

(defconst ELVES
  (mapcar (lambda (elf) (mapcar 'string-to-number (split-string-lines elf)))
          (split-string INPUT "\n\n" ))
  "A list-of list-of numbers, representing the caloric values of
each item held by each elf.")

(defconst TOTALS
  (mapcar (lambda (elf) (apply '+ elf)) ELVES)
  "A list of total calories held by each elf.")

;; 67027
(defconst ANSWER-PART1
  (apply 'max TOTALS)
  "The highest caloric value held by any elf.")

;; 197291
(defconst ANSWER-PART2
  (apply '+ (seq-take (sort TOTALS '>) 3))
  "The sum of the three highest caloric values.")

(provide 'solution)
