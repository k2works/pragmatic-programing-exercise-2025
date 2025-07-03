(ns design-pattern.adapter.turn-on-light.variable-light-adapter
  (:require [design-pattern.adapter.turn-on-light.switchable :as s]
            [design-pattern.adapter.turn-on-light.variable-light :as v-l]))

(defn make-adapter []
  {:type :variable-light})

(defmethod s/turn-on :variable-light [switchable]
  (v-l/turn-on-light 100))

(defmethod s/turn-off :variable-light [switchable]
  (v-l/turn-on-light 0))
