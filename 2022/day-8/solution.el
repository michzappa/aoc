;; -*- lexical-binding: t; -*-

(defun cars (matrix)
  "Return a list with all the cars of the lists in MATRIX."
  (if (null matrix)
      nil
    (cons (car (car matrix)) (cars (cdr matrix)))))

(defun cdrs (matrix)
  "Return a list with all the cdrs of the lists in MATRIX."
  (if (null matrix)
      nil
    (cons (cdr (car matrix)) (cdrs (cdr matrix)))))

(defun transpose (matrix)
  "Transpose MATRIX."
  (cond ((null matrix) nil)
        ((null (car matrix)) nil)
        (t (cons (cars matrix) (transpose (cdrs matrix))))))

(defconst TREES (-map (lambda (line) (-map 'string-to-number (-drop-last 1 (-drop 1 (s-split "" line)))))
                      (-drop-last 1 (s-lines INPUT))))

(defun left->right (grid) grid)
(defun right->left (grid) (-map 'reverse grid))
(defun top->bottom (grid) (transpose grid))
(defun bottom->top (grid) (transpose (reverse grid)))

;; cdr of a tree is 0 for not visible (or not known), 1 for known to be visible
(defvar VISIBILITY (-map (lambda (row) (-map (lambda (tree) (cons tree 0)) row)) TREES))

(defun mark-visible (trees)
  (-each trees
    (lambda (row)
      (let ((visible-height -1))
        (-each row (lambda (tree)
                     (when (> (car tree) visible-height)
                       (setf (cdr tree) 1)
                       (setq visible-height (car tree)))))))))

(mark-visible (left->right VISIBILITY))
(mark-visible (right->left VISIBILITY))
(mark-visible (top->bottom VISIBILITY))
(mark-visible (bottom->top VISIBILITY))

;; 1851
(defconst ANSWER-PART1 (apply '+ (-map 'cdr (-flatten VISIBILITY))))

(defconst SCENIC_SCORES (-map (lambda (row) (-map (lambda (tree) (cons tree 1)) row)) TREES))

(defun mark-scenic-scores (trees)
  "Multiply the existing scenic score for each tree by the viewing
distance in this direction."
  (-each trees
    (lambda (row)
      (-each row (lambda (tree)
                   (let* ((tree-height (car tree))
                          (rest-of-row (cdr (-drop-while (lambda (tr) (not (eq tr tree))) row)))
                          (viewing-distance
                           (let ((dist 0))
                             (catch 'distance
                               (dolist (tr rest-of-row)
                                 (setq dist (1+ dist))
                                 (when (>= (car tr) tree-height)
                                   (throw 'distance dist)))
                               dist))))
                     (setf (cdr tree) (* viewing-distance (cdr tree)))))))))

(mark-scenic-scores (left->right SCENIC_SCORES))
(mark-scenic-scores (right->left SCENIC_SCORES))
(mark-scenic-scores (top->bottom SCENIC_SCORES))
(mark-scenic-scores (bottom->top SCENIC_SCORES))

;; 574080
(defconst ANSWER-PART2 (apply 'max (-map 'cdr (-flatten SCENIC_SCORES))))

(provide 'solution)
