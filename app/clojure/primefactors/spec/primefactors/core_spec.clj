(ns primefactors.core-spec
  (:require [speclj.core :refer :all]
            [primefactors.core :refer :all]))

(describe "prime-factors-of"
          (it "returns [] for 1"
              (should= [] (prime-factors-of 1)))
          (it "returns [2] for 2"
              (should= [2] (prime-factors-of 2)))
          (it "returns [3] for 3"
              (should= [3] (prime-factors-of 3)))
          (it "returns [2 2] for 4"
              (should= [2 2] (prime-factors-of 4)))
          (it "returns [5] for 5"
              (should= [5] (prime-factors-of 5)))
          (it "returns [2 3] for 6"
              (should= [2 3] (prime-factors-of 6)))
          (it "returns [7] for 7"
              (should= [7] (prime-factors-of 7)))
          (it "returns [2 2 2] for 8"
              (should= [2 2 2] (prime-factors-of 8)))
          (it "returns [3 3] for 9"
              (should= [3 3] (prime-factors-of 9)))
          (it "returns [5 5] for 25"
              (should= [5 5] (prime-factors-of 25)))
          )
