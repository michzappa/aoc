;; -*- lexical-binding: t; -*-

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
