(ns primefactors.core-test
  (:require [clojure.test :refer [deftest is testing]]
            [primefactors.core :refer [prime-factors-of]]))

(deftest prime-factors-test
  (testing "returns [] for 1"
    (is (= [] (prime-factors-of 1))))
  (testing "returns [2] for 2"
    (is (= [2] (prime-factors-of 2))))
  (testing "returns [3] for 3"
    (is (= [3] (prime-factors-of 3))))
  (testing "returns [2] for 4"
    (is (= [2 2] (prime-factors-of 4))))
  (testing "returns [5] for 5"
    (is (= [5] (prime-factors-of 5))))
  (testing "returns [2 3] for 6"
    (is (= [2 3] (prime-factors-of 6))))
  (testing "returns [7] for 7"
    (is (= [7] (prime-factors-of 7))))
  (testing "returns [2 2 2] for 8"
    (is (= [2 2 2] (prime-factors-of 8))))
  (testing "returns [3 3] for 9"
    (is (= [3 3] (prime-factors-of 9))))
  (testing "returns [5 5] for 25"
    (is (= [5 5] (prime-factors-of 25))))
  )