;; -*- lexical-binding: t; -*-

(defconst COMMANDS (-map (lambda (cmd) (s-split " " cmd)) (s-lines INPUT)))

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
                      dir-sizes))

;; 1845346
(defconst ANSWER-PART1 (apply '+ (-filter (lambda (n) (>= 100000 n)) (-map 'cdr DIR_SIZES))))

;; 3636703
(defconst ANSWER-PART2 (let ((current-free-space (- 70000000 (cdr (assoc "/" DIR_SIZES))))
                             (sorted-dirs (-sort (lambda (dir1 dir2) (<= (cdr dir1) (cdr dir2))) DIR_SIZES)))
                         (cdr (-first (lambda (dir) (<= 30000000 (+ current-free-space (cdr dir)))) sorted-dirs))))

(provide 'solution)
