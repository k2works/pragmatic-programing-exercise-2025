(ns design-pattern.adapter.turn-on-light.engage-switch
  (:require [design-pattern.adapter.turn-on-light.switchable :as s]))

(defn engage-switch [switchable]
  ;Some other stuff..
  (s/turn-on switchable)
  ;Some more other stuff...
  (s/turn-off switchable)
  )