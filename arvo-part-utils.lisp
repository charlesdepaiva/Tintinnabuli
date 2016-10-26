(in-package :arvo-part-utils)

(declaim (ftype (function (number) number) negate) (inline negate))
(defun negate (x) (* x -1))

(defparameter *middle-c* 6000)
(defparameter *octave* 1200)
(defparameter *pc-octave* 12)

(declaim (ftype (function (integer) integer) pc<-pitch octave<-pitch))

(defun pc<-pitch (pitch)
  (mod pitch *octave*))

(defun octave<-pitch (pitch)
  (values (floor pitch *octave*)))

(defmethod add-middle-c ((pitch integer))
  (+ pitch *middle-c*))

(defmethod add-middle-c ((pitch list))
  (mapcar #'add-middle-c pitch))

(defmethod next-octave ((pitch integer))
  (declare (values integer))
  (+ pitch *octave*))

(defmethod next-octave ((pitch list))
  (declare (values list))
  (mapcar #'next-octave pitch))

(defmethod prev-octave ((pitch integer))
  (declare (values integer))
  (- pitch *pc-octave*))

(defmethod prev-octave ((pitch list))
  (declare (values list))
  (mapcar #'prev-octave pitch))
