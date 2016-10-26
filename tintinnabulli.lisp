(in-package :tintinnabulli)

(declaim (optimize (debug 1) (safety 3) (speed 1)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun diad-p (x)
    (= (length x) 2)))

(deftype diad ()
  '(and list (satisfies diad-p)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun triad-p (x)
    (= (length x) 3)))

(deftype triad ()
  '(and list (satisfies triad-p)))

(deftype pc ()
  '(integer 0 1200))

(declaim (ftype (function (pc (or diad triad)) integer)
		tintinnabuli-superior-1st-position
		tintinnabuli-superior-2nd-position
		tintinnabuli-inferior-1st-position
		tintinnabuli-inferior-2nd-position))

(defun tintinnabuli-superior-1st-position (pc triad)
  (let ((found (find pc triad :test '<)))
    (declare (type (or integer null) found))
    (if found found (tintinnabuli-superior-1st-position pc (next-octave triad)))))

(defun tintinnabuli-superior-2nd-position (pc triad)
  (let ((set (remove pc triad :test '< :count 1)))
    (declare (type (or diad triad) set))
    (if (diad-p set)
	(tintinnabuli-superior-1st-position pc set)
	(tintinnabuli-superior-1st-position pc (reverse (butlast set))))))

(defun tintinnabuli-inferior-1st-position (pc triad)
  (let ((found (find pc triad :test '> :from-end t)))
    (declare (type (or integer null)))
    (if found found (tintinnabuli-inferior-1st-position pc (prev-octave triad)))))

(defun tintinnabuli-inferior-2nd-position (pc triad)
  (let ((set (remove pc triad :test '> :count 1 :from-end t)))
    (declare (type (or diad triad) set))
    (if (diad-p set)
	(tintinnabuli-inferior-1st-position pc set)
	(tintinnabuli-inferior-1st-position pc (butlast set)))))

(declaim (ftype (function (pc triad (member :1st :2nd)) integer)
		tintinnabuli-superior
		tintinnabuli-inferior))

(defun tintinnabuli-superior (pc triad position)
  (ecase position
    (:1st (tintinnabuli-superior-1st-position pc triad))
    (:2nd (tintinnabuli-superior-2nd-position pc triad))))

(defun tintinnabuli-inferior (pc triad position)
  (ecase position
    (:1st (tintinnabuli-inferior-1st-position pc triad))
    (:2nd (tintinnabuli-inferior-2nd-position pc triad))))

(declaim
 (ftype (function (pc triad (member :1st :2nd) (member :superior :inferior))
	    integer) pc-tintinnabuli))

(defun pc-tintinnabuli (pc triad position direction)
  (ecase direction 
    (:superior (tintinnabuli-superior pc triad position))
    (:inferior (tintinnabuli-inferior pc triad position))))

(defmethod tintinnabuli ((note integer) (triad list) (position symbol) (direction symbol))
   (let ((triad (mapcar #'pc<-pitch (sort triad '<)))
	 (pc (pc<-pitch note))
	 (pc-octave (octave<-pitch note)))
     (+ (* pc-octave *octave*) (pc-tintinnabuli pc triad position direction))))

(tintinnabuli 6700 '(6000 6400 6700) :1st :superior)

(pc<-pitch 6100)

