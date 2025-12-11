(ns design-pattern.composite.light.switchable)

(defmulti turn-on :type)
(defmulti turn-off :type)
