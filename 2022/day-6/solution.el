;; -*- lexical-binding: t; -*-

(defun s-uniq (s)
  "Return a copy of S with all duplicate characters removed."
  (s-join "" (-uniq (s-split "" s))))

(defun subroutine (last-three rest)
  (let* ((first-of-rest (s-left 1 rest))
         (entire-marker (s-append first-of-rest last-three)))
    (if (equal entire-marker (s-uniq entire-marker))
        entire-marker
      (subroutine (s-append first-of-rest (s-chop-left 1 last-three)) (s-chop-left 1 rest)))))

;; raising limits to prevent segfault
(setq max-specpdl-size 32000
      max-lisp-eval-depth 32000)

(defconst ANSWER-PART1 (+ 4 (s-index-of (subroutine (s-left 3 INPUT) (s-chop-left 3 INPUT)) INPUT)))
(defconst ANSWER-PART2 (+ 14 (s-index-of (subroutine (s-left 13 INPUT) (s-chop-left 13 INPUT)) INPUT)))

(provide 'solution)
