(in-package :arvo-part-modes)

(declaim (optimize (debug 1) (safety 3) (speed 1)))

(defvar *mode-one* (lambda (n)
		     (declare ((integer 0) n) (values cons))
		     (loop for i from 0 upto (1- n) collect i))
  "an ascending series of integers starting from zero")

(defvar *mode-two* (lambda (n)
		     (declare ((integer 0) n) (values cons))
		     (loop for i from 0 downto (* (1- n) -1) collect i))
  "a descending series of integers starting from zero")

(defvar *mode-three* (lambda (n)
		       (declare ((integer 0) n) (values cons))
		       (loop for i from (1- n) downto 0 collect i))
  "a descending series of integers ending in zero")

(defvar *mode-four* (lambda (n)
		      (declare ((integer 0) n) (values cons))
		      (loop for i from (* (1- n) -1) upto 0 collect i))
  "an ascending series of integers ending in zero")

(defun select-mode (mode-number)
  "selects from four modes and returns the chosen one"
  (declare ((integer 1 4) mode-number))
  (ecase mode-number
    (1 *mode-one*)
    (2 *mode-two*)
    (3 *mode-three*)
    (4 *mode-four*)))

(defun take<-mode (pair)
  "takes n elements from mode. pair is in the form (n . mode-number)"
  (if ))

(defgeneric take<-mode (n mode-number)
  :documentation "takes n elements from mode(s).")

(defmethod take<-mode ((n number) (mode-number number))
  (funcall (select-mode mode-number) n))

(defmethod take<-mode ((n list) (mode-number number))
  (mapcar #'(lambda (x) (take<-mode x mode-number)) n))

(defmethod take<-mode ((n number) (mode-number list))
  (mapcar #'(lambda (x) (take<-mode n x)) mode-number))

(defmethod take<-mode ((n list) (mode-number list))
  (mapcar #'take<-mode n mode-number))

;(defun ser (x) (when (> x 0) (cons (1- x) (ser (1- x)))))
;(defun ser1 (x) (when (> x 0) (append (ser1 (1- x)) (list (1- x)))))
;(defun tser1 (x &optional acc) (if (= x 0) acc (tser1 (1- x) (append acc (list x)))))
