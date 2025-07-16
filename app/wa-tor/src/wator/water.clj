(ns wator.water
  (:require [wator.cell :as cell]))

(defn make [] {::cell/type :wator.water/water})

(defn is? [cell]
  (= :wator.water/water (::cell/type cell)))