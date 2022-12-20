;; -*- lexical-binding: t; -*-

(defun subroutine (len)
  (catch 'return
    (dotimes (index (length INPUT))
      (when (eq len (length (cl-remove-duplicates (substring INPUT index (+ index len)))))
        (throw 'return (+ index len))))))

(defconst ANSWER-PART1 (subroutine 4))
(defconst ANSWER-PART2 (subroutine 14))

(provide 'solution)
