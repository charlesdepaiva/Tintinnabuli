(in-package :common-lisp-user)

(defpackage :arvo-part-utils
  (:use :cl))

(defpackage :arvo-part-modes
  (:use :cl :arvo-part-utils))

(defpackage :tintinnabulli
  (:use :cl :arvo-part-utils))

(defpackage :spiegel-im-spiegel
  (:use :cl :arvo-part-modes :tintinnabulli :spiegel-series))

(defpackage :spiegel-series
  (:use :cl :arvo-part-modes :tintinnabulli))

;; (defpackage :frates
;;   (:use :cl :modes :tintinnabulli))

;; (defpackage :cantus
;;   (:use :cl :modes :tintinnabulli))
