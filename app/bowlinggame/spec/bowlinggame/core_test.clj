(ns bowlinggame.core-test
  (:require [clojure.test :refer :all]
            [bowlinggame.core :refer :all]))

(defn roll-many
  "Helper function to roll the same number of pins multiple times."
  [game n pins]
  (reduce (fn [g _] (roll g pins)) game (range n)))

(deftest bowlinggame-test
  (testing "should score 0 for a gutter game"
    (let [game (roll-many (new-game) 20 0)]
      (is (= 0 (score game)))))
  )