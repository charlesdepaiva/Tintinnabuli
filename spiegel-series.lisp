(in-package :spiegel-series)

(declaim (optimize (debug 1) (safety 3) (speed 1)))

(defun sequence-of-mode-numbers (n &key (key #'identity))
  (declare ((integer 1) n) (function key))
  (if (= n 1)
      (list n)
      (loop for i from 0 upto (1- n) collect (1+ (mod (funcall key i) 4)))))

(defun sequence-of-takes (n)
  (declare ((integer 0) n))
  (loop for i from 2 upto (1+ n) collect (values (floor (/ i 2))))) 


(defun spiegel-series (n)
  (take<-mode (sequence-of-takes n) (sequence-of-mode-numbers n)))






