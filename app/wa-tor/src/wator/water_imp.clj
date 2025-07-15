(ns wator.water-imp
  (:require [wator.cell :as cell]
            [wator.fish :as fish]
            [wator.config :as config]))

(defmethod cell/tick :wator.water/water [water]
  (if (> (rand) config/water-evolution-rate)
    (fish/make)
    water))