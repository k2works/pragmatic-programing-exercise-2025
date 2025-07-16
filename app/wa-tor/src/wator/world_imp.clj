(ns wator.world-imp
  (:require [wator.animal :as animal]
            [wator.cell :as cell]
            [wator.fish :as fish]
            [wator.shark :as shark]
            [wator.water :as water]
            [wator.world :as world :refer :all]))

(defmethod world/tick :wator.world/world [world]
  (let [cells (::world/cells world)]
    (loop [locs (keys cells)
           new-cells {}
           moved-into #{}]
      (cond

        (empty? locs)
        (assoc world ::world/cells new-cells)

        (contains? moved-into (first locs))
        (recur (rest locs) new-cells moved-into)

        :else
        (let [loc (first locs)
              cell (get cells loc)
              [from to] (cell/tick cell loc (assoc world :moved-into moved-into))
              new-cells (-> new-cells (merge from) (merge to))
              to-loc (first (keys to))
              to-cell (get to to-loc)
              moved-into (if (water/is? to-cell)
                           moved-into
                           (conj moved-into to-loc))]
          (recur (rest locs)
                 new-cells
                 moved-into))))))

(defmethod world/make-cell :wator.world/world [world cell-type]
  (condp = cell-type
         :default-cell (water/make)
         :water (water/make)
         :fish (fish/make)
         :shark (shark/make)))