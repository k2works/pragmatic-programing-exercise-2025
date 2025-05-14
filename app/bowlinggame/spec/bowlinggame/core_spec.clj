(ns bowlinggame.core-spec
  (:require [speclj.core :refer :all]
            [bowlinggame.core :refer :all]))

(defn roll-many
  "Helper function to roll the same number of pins multiple times."
  [game n pins]
  (reduce (fn [g _] (roll g pins)) game (range n)))

(defn roll-spare
  "Helper function to roll a spare."
  [game]
  (-> game
      (roll 5)
      (roll 5)))

(defn roll-strike
  "Helper function to roll a strike."
  [game]
  (roll game 10))

(describe "Bowling Game"
  (it "should score 0 for a gutter game"
    (let [game (roll-many (new-game) 20 0)]
      (should= 0 (score game))))
  
  (it "should score 20 for a game of all ones"
    (let [game (roll-many (new-game) 20 1)]
      (should= 20 (score game))))
  
  (it "should handle a spare correctly"
    (let [game (-> (new-game)
                   (roll-spare)
                   (roll 3)
                   (roll-many 17 0))]
      (should= 16 (score game))))
  
  (it "should handle a strike correctly"
    (let [game (-> (new-game)
                   (roll-strike)
                   (roll 3)
                   (roll 4)
                   (roll-many 16 0))]
      (should= 24 (score game))))
  
  (it "should handle a perfect game"
    (let [game (roll-many (new-game) 12 10)]
      (should= 300 (score game)))))