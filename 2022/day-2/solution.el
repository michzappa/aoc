;; -*- lexical-binding: t; -*-
(defconst ROUNDS (-map (lambda (round) (s-split " " round))
                         (-drop-last 1 (s-lines INPUT)))
  "A list-of list-of strings representing both moves for the round.")

(defun play-round-1 (round)
  "Returns score for this round of rock-paper-scissors."
  (let ((opponent (-first-item round))
        (me (-second-item round)))
    (pcase opponent
      ("A" (pcase me
             ("X" 4)      ; 3 for draw, 1 for rock
             ("Y" 8)      ; 6 for win,  2 for paper
             ("Z" 3)))    ; 0 for loss, 3 for scissors
      ("B" (pcase me
             ("X" 1)      ; 0 for loss, 1 for rock
             ("Y" 5)      ; 3 for draw, 2 for paper
             ("Z" 9)))    ; 6 for win,  3 for scissors
      ("C" (pcase me
             ("X" 7)      ; 6 for win, 1 for rock
             ("Y" 2)      ; 0 for loss,  2 for paper
             ("Z" 6)))))) ; 3 for draw, 3 for scissors

(defconst ANSWER-PART1
  (apply '+ (-map 'play-round-1 ROUNDS))
  "Sum score for all rounds.")

(defun play-round-2 (round)
  (let ((opponent (-first-item round))
        (me (-second-item round)))
    (pcase opponent
      ("A" (pcase me
             ("X" 3)      ; 0 for loss, 3 for scissors
             ("Y" 4)      ; 3 for draw, 1 for rock
             ("Z" 8)))    ; 6 for win,  2 for paper
      ("B" (pcase me
             ("X" 1)      ; 0 for loss, 1 for rock
             ("Y" 5)      ; 3 for draw, 2 for paper
             ("Z" 9)))    ; 6 for win,  3 for scissors
      ("C" (pcase me
             ("X" 2)      ; 0 for loss, 2 for paper
             ("Y" 6)      ; 3 for draw, 3 for scissors
             ("Z" 7)))))) ; 6 for win,  1 for rock

(defconst ANSWER-PART2
  (apply '+ (-map 'play-round-2 ROUNDS))
  "Sum score for all rounds.")

(provide 'solution)
