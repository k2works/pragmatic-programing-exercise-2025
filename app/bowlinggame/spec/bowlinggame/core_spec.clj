(ns bowlinggame.core-spec
  (:require [speclj.core :refer :all]
            [bowlinggame.core :refer :all]))

(describe "Bowling Game"
          (it "should score 0 for a gutter game"
              (should= 0 (score (repeat 20 0))))
          (it "should score 24 for spare"
              (should= 24 (score (concat [5 5 7] (repeat 17 0)))))
          (it "should score 20 for strike"
              (should= 20 (score (concat [10 2 3] (repeat 16 0)))))
          (it "should score 300 for perfect game"
              (should= 300 (score (repeat 12 10))))
          (it "should score 20 for all ones"
              (should= 20 (score (repeat 20 1)))))