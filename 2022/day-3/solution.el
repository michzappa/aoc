;; -*- lexical-binding: t; -*-
(defconst RUCKSACKS (-map (lambda (rucksack) (string-to-list rucksack))
                          (-drop-last 1 (s-lines INPUT)))
  "A list-of list-of numbers representing the items in the rucksacks.")

(defconst CONTAINERS (-map (lambda (rucksack)
                             (let ((compartment-size (/ (length rucksack) 2)))
                                (list (-take compartment-size rucksack)
                                      (-take-last compartment-size rucksack))))
                           RUCKSACKS)
  "A list-of list-of list-of numbers representing the items in the compartments in the
rucksacks")

(defconst CONTAINERS_SHARED_ITEM
  (-map (lambda (rucksack)
            (let ((compartment-one (-first-item rucksack))
                  (compartment-two (-second-item rucksack)))
              (-first-item (-filter (lambda (item) (member item compartment-one)) compartment-two))))
          CONTAINERS)
  "A list-of list-of numbers representing which item type is shared
between the two compartments of each rucksack.")

(defun priority (item-type)
  "Get the priority for the given item type."
  (if (> item-type 90)
      ;; lowercase letter
      (- item-type 96)
    ;; uppercase letter
    (- item-type 38)))

(defconst ANSWER-PART1
  (apply '+ (-map 'priority CONTAINERS_SHARED_ITEM))
  "Sum of the priorities of the item type shared between each
rucksack's containers. ")

(defconst RUCKSACK_GROUPS (-partition 3 RUCKSACKS)
  "A list-of list-of list-of numbers representing the items in each
rucksack in each group.")

(defconst GROUPS_SHARED_ITEM
  (-map (lambda (group)
          (let ((rucksack-one (-first-item group))
                (rucksack-two (-second-item group))
                (rucksack-three (-third-item group)))
            (-first-item (-filter (lambda (item) (and (member item rucksack-one)
                                                 (member item rucksack-two)))
                                  rucksack-three))))
        RUCKSACK_GROUPS))

(defconst ANSWER-PART2
  (apply '+ (-map 'priority GROUPS_SHARED_ITEM))
  "Sum of the priorities of the item type shared between each groups' rucksacks. ")

(provide 'solution)
