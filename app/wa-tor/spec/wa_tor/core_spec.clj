(ns wa-tor.core-spec
  (:require [speclj.core :refer :all]
            [wa-tor.core :refer :all]))

(describe "Wa-Tor World"
  (it "creates a world with the specified dimensions"
    (let [world (create-world 10 10)]
      (should= 10 (:width world))
      (should= 10 (:height world))
      (should= 100 (count (:cells world)))))
  
  (it "gets a cell at the specified coordinates"
    (let [world (create-world 5 5)
          world-with-cell (set-cell world 2 3 :fish)]
      (should= :fish (get-cell world-with-cell 2 3))
      (should= nil (get-cell world-with-cell 0 0))))
  
  (it "sets a cell at the specified coordinates"
    (let [world (create-world 5 5)
          world-with-fish (set-cell world 1 2 :fish)
          world-with-shark (set-cell world-with-fish 3 4 :shark)]
      (should= :fish (get-cell world-with-fish 1 2))
      (should= :shark (get-cell world-with-shark 3 4)))))