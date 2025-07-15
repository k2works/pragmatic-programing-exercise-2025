(ns wator.animal
  (:require [clojure.spec.alpha :as s]
            [wator.cell :as cell]
            [wator.world :as world]
            [wator.config :as config]
            [wator.water :as water]))

(s/def ::age int?)
(s/def ::animal (s/keys :req [::age]))

(defmulti move (fn [animal & args] (::cell/type animal)))
(defmulti reproduce (fn [animal & args] (::cell/type animal)))
(defmulti make-child ::cell/type)

(defn make []
  {::age 0})

(defn age [animal]
  (::age animal))

(defn set-age [animal age]
  (assoc animal ::age age))

(defn tick [animal]
  )

(defn do-move [animal loc world]
  (let [neighbors (world/neighbors world loc)

        destinations (filter
                       #(water/is?
                          (world/get-cell world %))
                       neighbors)
        new-location (rand-nth destinations)]
    [new-location animal]))

(defn do-reproduce [animal loc world]
  (let [neighbors (world/neighbors world loc)
        birth-places (filter #(water/is? (world/get-cell world %))
                             neighbors)]
    (if (empty? birth-places)
      nil
      (let [parent (set-age animal 0)
            birth-place (rand-nth birth-places)
            child (make-child animal)]
        [loc parent birth-place child]))))
