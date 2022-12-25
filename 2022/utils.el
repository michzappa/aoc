;; -*- lexical-binding: t; -*-

(defun set-list-element (l n e)
  "Replace the N'th element in L with E. 0-indexed."
  (seq-map-indexed (lambda (item index) (if (= index n) e item)) l))

(defmacro split-string-lines (str)
  `(split-string ,str "\n"))

(defmacro seq-drop-first (l)
  `(seq-drop ,l 1))

(defmacro seq-drop-final (l)
  `(seq-drop-last ,l 1))

(defmacro seq-drop-last (l n)
  `(let ((l2 ,l))
     (seq-take l2 (- (length l2) ,n))))

(defmacro seq-take-last (l n)
  `(let ((l2 ,l))
     (seq-drop l2 (- (length l2) ,n))))

(defun seq-repeat (x n)
  (if (= n 0)
      nil
    (cons x (seq-repeat x (1- n)))))

(defun seq-zip (fn l1 l2)
  (if (or (null l1) (null l2))
      nil
    (cons (funcall fn (car l1) (car l2)) (seq-zip fn (cdr l1) (cdr l2)))))

(provide 'utils)
