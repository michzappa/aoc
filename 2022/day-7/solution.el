;; -*- lexical-binding: t; -*-

(defconst COMMANDS (mapcar (lambda (cmd) (split-string cmd " ")) (split-string INPUT "\n"))
  "A list-of list-of strings representing the commands entered into the machine.")

(defconst DIR_SIZES (let ((dir-depth nil)
                          (dir-sizes '()))
                      (dolist (cmd COMMANDS)
                        (pcase cmd
                          (`("$" "cd" "..") (setq dir-depth (cdr dir-depth)))
                          (`("$" "cd" ,dir)
                           (setq dir-depth (cons dir dir-depth))
                           (setq dir-sizes (cons `(,dir . 0) dir-sizes)))
                          (`("$" "ls") nil)
                          (`("dir" dir-name) nil)
                          (`(,file-size ,file-name)
                           (dolist (dir dir-depth)
                             (setf (alist-get dir dir-sizes) (+ (string-to-number file-size)
                                                                (alist-get dir dir-sizes)))))))
                      dir-sizes)
  "A list-of pairs-of (dir-name . dir-size).")

;; 1845346
(defconst ANSWER-PART1 (apply '+ (seq-filter (lambda (n) (>= 100000 n)) (mapcar 'cdr DIR_SIZES)))
  "The sum of the total sizes of directories wich a total size < 100000.")

;; 3636703
(defconst ANSWER-PART2 (let ((current-free-space (- 70000000 (cdr (assoc "/" DIR_SIZES))))
                             (sorted-dirs (seq-sort (lambda (dir1 dir2) (<= (cdr dir1) (cdr dir2))) DIR_SIZES)))
                         (cdr (seq-find (lambda (dir) (<= 30000000 (+ current-free-space (cdr dir)))) sorted-dirs)))
  "The size of the smallest directory which can be deleted to create 3000000 free space.")

(provide 'solution)
