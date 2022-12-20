;; -*- lexical-binding: t; -*-

(defun s-partition (n s)
  "Return S as partitions of up to N size."
  (if (<= (length s) n)
      (list s)
    (cons (s-left n s) (s-partition n (s-chop-left n s)))))

(defconst CRATE_LEVELS (-map (lambda (line) (-map (lambda (cell)
                                               (s-replace-all '(("[" . "") ("]" . "") (" " . "")) cell))
                                             (s-partition 4 line)))
                             (-drop-last 1 (s-lines (-first-item (s-split "\n\n" INPUT)))))
  "Parse the input diagram into a list-of list-of strings,
representing each level of crates.")

(defconst STARTING_STACKS
  (-reduce-from (lambda (stacks crates)
                  (-zip-with (lambda (stack crate)
                                (if (equal "" crate) stack (cons crate stack)))
                             stacks
                             crates))
                (-repeat (length (-first-item CRATE_LEVELS)) '())
                (reverse CRATE_LEVELS))
  "Process the crate levels into their vertical stacks.")

(defconst MOVES (-map (lambda (move) (-map 'string-to-number (-drop 1 (s-split (rx (or "move " " from " " to ")) move))))
                      (-drop-last 1 (s-lines (-second-item (s-split "\n\n" INPUT)))))
  "All of the moves represented as (number to be moved, from, to) lists.")

(defun set-list-element (l n e)
  "Replace the N'th element in L with E."
  (-map-indexed (lambda (index item) (if (= index n) e item)) l))

(defun move-crates (part)
  "Apply the MOVES list fo STARTING_STACKS."
  (-reduce-from (lambda (stacks move)
                  (let* ((num (-first-item move))
                         (from (1- (-second-item move)))
                         (to (1- (-third-item move)))
                         (crates (-take num (nth from stacks)))
                         ;; part 1 crane handles 1 crate at a time, so
                         ;; it's a strict stack - reverse the crates
                         (crates (if (equal part 1) (reverse crates) crates)))
                    (set-list-element (set-list-element stacks from (-drop num (nth from stacks)))
                                      to
                                      (append crates (nth to stacks)))))
                STARTING_STACKS
                MOVES))

;; "TDCHVHJTG"
(defconst ANSWER-PART1 (apply 'concat (-map '-first-item (move-crates 1))))

;; "NGCMPJLHV"
(defconst ANSWER-PART2 (apply 'concat (-map '-first-item (move-crates 2))))

(provide 'solution)
