(ns wator.world
  (:require [wator.water :as water]))

(defn make [w h]
  (let [locs (for [x (range w) y (range h)] [x y])
        loc-water (interleave locs (repeat (water/make)))
        cells (apply hash-map loc-water)]
    {:cells cells}))

(defn set-cell [world loc cell]
  (assoc-in world [:cells loc] cell))