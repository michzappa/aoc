;; -*- lexical-binding: t; -*-

(defconst CRATE_LEVELS (mapcar (lambda (line)
                                 (mapcar (lambda (cell)
                                           (string-match (rx upper) cell)
                                           (match-string 0 cell))
                                         (seq-partition line 4)))
                               (seq-drop-final (split-string-lines (car (split-string INPUT "\n\n")))))
  "A list-of list-of strings, representing each level of crates.")

(defconst STARTING_STACKS
  (seq-reduce (lambda (stacks crates)
                (seq-zip (lambda (stack crate)
                             (if (equal " " crate)
                                 stack
                               (cons crate stack)))
                           stacks
                           crates))
              (reverse CRATE_LEVELS)
              (seq-repeat '() (length (car CRATE_LEVELS))))
  "Process the crate levels into their vertical stacks.")

(defconst MOVES (mapcar (lambda (move) (mapcar 'string-to-number
                                          (seq-drop-first (split-string move (rx (or "move " " from " " to "))))))
                        (seq-drop-final (split-string-lines (cadr (split-string INPUT "\n\n")))))
  "All of the moves represented as (number to be moved, from, to) lists.")

(defun move-crates (part)
  "Apply the MOVES list to STARTING_STACKS. Part 1 moves one crate
at a time, part 2 can move multiple."
  (seq-reduce (lambda (stacks move)
                (let* ((num (car move))
                       (from (1- (cadr move)))
                       (to (1- (caddr move)))
                       (crates (seq-take (nth from stacks) num))
                       ;; part 1 crane handles 1 crate at a time, so
                       ;; it's a strict stack - reverse the crates
                       (crates (if (= part 1) (reverse crates) crates)))
                  (set-list-element (set-list-element stacks from (seq-drop (nth from stacks) num))
                                    to
                                    (append crates (nth to stacks)))))
              MOVES
              STARTING_STACKS))

;; "TDCHVHJTG"
(defconst ANSWER-PART1 (apply 'concat (mapcar 'car (move-crates 1)))
  "Crates on top of each stack moving 1 crate at a time.")

;; "NGCMPJLHV"
(defconst ANSWER-PART2 (apply 'concat (mapcar 'car (move-crates 2)))
  "Crates on top of each stack moving multiple crates at a time.")

(provide 'solution)
