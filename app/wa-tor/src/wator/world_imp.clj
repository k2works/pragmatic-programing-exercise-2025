(ns wator.world-imp
  (:require [wator.animal :as animal]
            [wator.fish :as fish]
            [wator.water :as water]
            [wator.world :as world :refer :all]))

(defmethod world/tick ::world/world [world]
  (-> (make 2 1)
      (set-cell [0 0] (water/make))
      (set-cell [0 1] (animal/set-age (fish/make) 1))))
