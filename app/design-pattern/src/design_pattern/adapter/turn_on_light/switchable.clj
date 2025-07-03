(ns design-pattern.adapter.turn-on-light.switchable)

(defmulti turn-on :type)

(defmulti turn-off :type)
