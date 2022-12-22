;; -*- lexical-binding: t; -*-

(require 'seq)
(require 'cl-lib)

(defconst MOVES (mapcar (lambda (move) `(,(car move) ,(string-to-number (cadr move))))
                        (mapcar (lambda (line) (split-string line " "))
                                (seq-drop-final (split-string-lines INPUT)))))

(defconst ALL_MOVES (apply 'append
                           (mapcar (lambda (move) (seq-repeat `(,(car move) 1) (cadr move))) MOVES)))

(defvar head-position '(0 0))
(defvar tail-position '(0 0))
(defvar visited-positions-1 '())

(defun move-up (pos) (setf (cadr pos) (1+ (cadr pos))))
(defun move-down (pos) (setf (cadr pos) (1- (cadr pos))))
(defun move-left (pos) (setf (car pos) (1- (car pos))))
(defun move-right (pos) (setf (car pos) (1+ (car pos))))

(defun move-head (move pos)
  (pcase move
    (`("U" ,dist)
     (move-up pos))
    (`("D" ,dist)
     (move-down pos))
    (`("L" ,dist)
     (move-left pos))
    (`("R" ,dist)
     (move-right pos))))

(defun move-tail (head-pos tail-pos)
  (defmacro move-y ()
    '(cond
      ((= y-delta 0) nil)
      ((< y-delta 0) (move-down tail-pos))
      ((> y-delta 0) (move-up tail-pos))))
  (let ((x-delta (- (car head-pos) (car tail-pos)))
        (y-delta (- (cadr head-pos) (cadr tail-pos))))
    (when (or (> (abs x-delta) 1) (> (abs y-delta) 1))
      (cond
       ((= x-delta 0) (move-y))
       ((< x-delta 0)
        (move-left tail-pos)
        (move-y))
       ((> x-delta 0)
        (move-right tail-pos)
        (move-y))))))

(defun make-move-1 (move)
  (move-head move head-position)
  (move-tail head-position tail-position)
  (setq visited-positions-1 (cons (seq-copy tail-position) visited-positions-1)))

(mapc #'make-move-1 ALL_MOVES)

(defconst ANSWER-PART1 (length (seq-uniq visited-positions-1)))

(defvar knots '((0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0) (0 0)))
(defvar visited-positions-2 '())

(defun make-move-2 (move)
  (move-head move (car knots))
  (cl-loop for index from 1 to 9
           do (progn
                (move-tail (nth (1- index) knots) (nth index knots))
                (setf visited-positions-2 (cons (seq-copy (nth 9 knots)) visited-positions-2)))))

(mapc #'make-move-2 ALL_MOVES)

(defconst ANSWER-PART2 (length (seq-uniq visited-positions-2)))

(provide 'solution)
