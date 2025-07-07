(ns design-pattern.composite.switchable)

(defmulti turn-on :type)
(defmulti turn-off :type)
