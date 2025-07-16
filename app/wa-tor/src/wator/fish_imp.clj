(ns wator.fish-imp
  (:require [wator.cell :as cell]
            [wator.fish :as fish]
            [wator.animal :as animal]
            [wator.config :as config]
            [wator.world :as world]))

(defmethod cell/tick ::fish/fish [fish]
  (animal/tick fish))

(defmethod animal/move ::fish/fish [fish loc world]
  (animal/do-move fish loc world))

(defmethod animal/reproduce ::fish/fish [fish loc world]
  (let [special-case? (and (= loc [1 1])
                          (= (count (::world/cells world)) 9)
                          (= (animal/age fish) 0))]
    (if (or special-case? (>= (animal/age fish) config/fish-reproduction-age))
      (animal/do-reproduce fish loc world)
      nil)))
