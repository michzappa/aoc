;; -*- lexical-binding: t; -*-

(defconst RUCKSACKS (mapcar (lambda (rucksack) (string-to-list rucksack))
                            (seq-drop-last (split-string INPUT "\n") 1))
  "A list-of list-of numbers representing the items in the rucksacks.")

(defconst CONTAINERS (mapcar (lambda (rucksack)
                               (let ((compartment-size (/ (length rucksack) 2)))
                                (list (seq-take rucksack compartment-size)
                                      (seq-take-last rucksack compartment-size))))
                           RUCKSACKS)
  "A list-of list-of list-of numbers representing the items in the compartments in the
rucksacks")

(defconst CONTAINERS_SHARED_ITEM
  (mapcar (lambda (rucksack)
            (let ((compartment-one (car rucksack))
                  (compartment-two (cadr rucksack)))
              (car (seq-filter (lambda (item) (member item compartment-one)) compartment-two))))
          CONTAINERS)
  "A list-of list-of numbers representing which item type is shared
between the two compartments of each rucksack.")

(defun priority (item-type)
  "Priority for the given item type."
  (if (> item-type 90)
      ;; lowercase letter
      (- item-type 96)
    ;; uppercase letter
    (- item-type 38)))

;; 7967
(defconst ANSWER-PART1
  (apply '+ (mapcar 'priority CONTAINERS_SHARED_ITEM))
  "Sum of the priorities of the item type shared between each
rucksack's containers.")

(defconst RUCKSACK_GROUPS (seq-partition RUCKSACKS 3)
  "A list-of list-of list-of numbers representing the items in each
rucksack in each group.")

(defconst GROUPS_SHARED_ITEM
  (mapcar (lambda (group)
          (let ((rucksack-one (car group))
                (rucksack-two (cadr group))
                (rucksack-three (caddr group)))
            (car (seq-filter (lambda (item) (and (member item rucksack-one)
                                            (member item rucksack-two)))
                             rucksack-three))))
          RUCKSACK_GROUPS)
  "The shared item type for each group.")

;; 2716
(defconst ANSWER-PART2
  (apply '+ (mapcar 'priority GROUPS_SHARED_ITEM))
  "Sum of the priorities of the item type shared between each groups' rucksacks.")

(provide 'solution)
