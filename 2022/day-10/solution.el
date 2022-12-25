;; -*- lexical-binding: t; -*-

(require 'subr-x)

(defconst INSTRUCTIONS
  (apply #'append
         (mapcar (lambda (line)
                   (let ((inst (split-string line " ")))
                     (if (= 2 (length inst))
                         ;; Replacing an add instruction with (noop, add) so
                         ;; that every instruction lasts one cycle
                         `(("noop") (,(car inst) ,(string-to-number (cadr inst))))
                       inst)))
                 (seq-drop-final (split-string-lines INPUT)))))

(defun sum-signal-strengths (cycles)
  "The signal strengths at cycles CYCLES."
  (let ((x 1)
        (cyc 1)
        (strengths 0))
    (dolist (inst INSTRUCTIONS)
      (when (member cyc cycles)
        (setf strengths (+ (* x cyc) strengths)))
      (pcase inst
        (`("noop"))
        (`("addx" ,amount)
         (setf x (+ x amount))))
      (setf cyc (1+ cyc)))
    strengths))

(defconst ANSWER-PART1 (sum-signal-strengths '(20 60 100 140 180 220)))

(defconst CRT (format "\n%s\n"
                      (string-join
                       (seq-partition
                        (string-join
                         (let ((x 1)
                               (pixel 0)
                               (crt (seq-repeat " " 240)))
                           (dolist (inst INSTRUCTIONS)
                             (let ((row-pixel (mod pixel 40)))
                               (when (and (>= row-pixel (1- x)) (<= row-pixel (1+ x)))
                                 (setq crt (set-list-element crt pixel "█"))))
                             (pcase inst
                               (`("noop"))
                               (`("addx" ,amount)
                                (setf x (+ x amount))))
                             (setf pixel (1+ pixel)))
                           crt))
                        40)
                       "\n")))
;; "
;; ███    ██ ████ ███  ███  ████ ████  ██
;; █  █    █ █    █  █ █  █ █    █    █  █
;; █  █    █ ███  █  █ █  █ ███  ███  █
;; ███     █ █    ███  ███  █    █    █
;; █ █  █  █ █    █ █  █    █    █    █  █
;; █  █  ██  ████ █  █ █    ████ █     ██
;; "

(defconst ANSWER-PART2 "RJERPEFC")

(provide 'solution)
