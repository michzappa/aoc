;; -*- lexical-binding: t; -*-

(require 'cl-lib)

(defconst TREES (mapcar (lambda (line)
                          (mapcar 'string-to-number
                                  (seq-drop-final (seq-drop-first (split-string line "")))))
                        (seq-drop-final (split-string-lines INPUT)))
  "A list-of list-of numbers represnting the heights of the trees.")

(defun left->right (grid) grid)
(defun right->left (grid) (mapcar 'reverse grid))
(defun top->bottom (grid) (apply 'cl-mapcar 'list grid))
(defun bottom->top (grid) (apply 'cl-mapcar 'list (reverse grid)))

(defvar visibilities (mapcar (lambda (row) (mapcar (lambda (tree) (cons tree 0)) row)) TREES)
  "A list-of list-of pairs-of (number . 0/1) representing whether
each tree is visible from outside the forest.")

(defun mark-visible (trees)
  "Mark trees visible in VISIBILITIES if they are."
  (mapc (lambda (row)
          (let ((visible-height -1))
            (mapc (lambda (tree)
                    (when (> (car tree) visible-height)
                      (setf (cdr tree) 1)
                      (setq visible-height (car tree))))
                  row)))
        trees))

(mark-visible (left->right visibilities))
(mark-visible (right->left visibilities))
(mark-visible (top->bottom visibilities))
(mark-visible (bottom->top visibilities))

;; 1851
(defconst ANSWER-PART1 (apply '+ (mapcar 'cdr (seq-reduce 'append visibilities '())))
  "The number of trees in the forest which are visible from the outside.")

(defvar scenic-scores (mapcar (lambda (row) (mapcar (lambda (tree) (cons tree 1)) row)) TREES)
  "A list-of list-of pairs-of (number . 0/1) representing each
  tree's scenic score, defined as the product of how far it can
  see in each direction.")

(defun mark-scenic-scores (trees)
  "Multiply the existing score in scenic-scores for each tree by its viewing
distance in this direction."
  (mapc (lambda (row)
          (mapc (lambda (tree)
                  (let* ((tree-height (car tree))
                         (rest-of-row (cdr (seq-drop-while (lambda (tr) (not (eq tr tree))) row)))
                         (viewing-distance
                          (let ((dist 0))
                            (catch 'distance
                              (dolist (tr rest-of-row)
                                (setq dist (1+ dist))
                                (when (>= (car tr) tree-height)
                                  (throw 'distance dist)))
                              dist))))
                    (setf (cdr tree) (* viewing-distance (cdr tree)))))
                row))
        trees))

(mark-scenic-scores (left->right scenic-scores))
(mark-scenic-scores (right->left scenic-scores))
(mark-scenic-scores (top->bottom scenic-scores))
(mark-scenic-scores (bottom->top scenic-scores))

;; 574080
(defconst ANSWER-PART2 (apply 'max (mapcar 'cdr  (seq-reduce 'append scenic-scores '())))
  "The highest scenic score in the forest, the product of all a
tree's viewing distances.")

(provide 'solution)
