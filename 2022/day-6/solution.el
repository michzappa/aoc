;; -*- lexical-binding: t; -*-

(defun subroutine (len)
  "The process to find the first marker of length LEN, where no
character is repeated."
  (catch 'return
    (dotimes (index (length INPUT))
      (when (eq len (length (seq-uniq (substring INPUT index (+ index len)))))
        (throw 'return (+ index len))))))

;; 1287
(defconst ANSWER-PART1 (subroutine 4)
  "Index of a marker of length 4.")

;; 3716
(defconst ANSWER-PART2 (subroutine 14)
  "Index of a marker of length 14.")

(provide 'solution)
