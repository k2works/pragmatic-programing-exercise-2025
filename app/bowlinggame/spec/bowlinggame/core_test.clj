(ns bowlinggame.core-test
  (:require [clojure.test :refer :all]
            [bowlinggame.core :refer :all]))

(deftest bowlinggame-test
  (testing "should score 0 for a gutter game"
      (is (= 0 (score (repeat 20 0)))))
  (testing "should score 17 for spare"
      (is (= 24 (score (concat [5 5 7] (repeat 17 0))))))
  (testing "should score 20 for all ones"
      (is (= 20 (score (repeat 20 1)))))
  (testing "should score 20 for strike"
      (is (= 20 (score (concat [10 2 3] (repeat 16 0))))))
  (testing "should score 300 for perfect game"
      (is (= 300 (score (repeat 12 10)))))
  )
