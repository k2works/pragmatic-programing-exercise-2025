(ns design-pattern.composite.light.light
  (:require [design-pattern.composite.light.switchable :as s]))

(defn make-light [] {:type :light})

(defn turn-on-light [])
(defn turn-off-light [])

(defmethod s/turn-on :light [switchable]
  (turn-on-light))

(defmethod s/turn-off :light [switchable]
  (turn-off-light))
