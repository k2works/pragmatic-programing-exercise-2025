(ns test.primefactors.core-test
  (:require [clojure.test :refer [deftest is testing]]
            [primefactors.core :refer [prime-factors]]))

(deftest prime-factors-test
  (testing "returns an empty sequence for 1"
    (is (= [] (prime-factors 1))))

  (testing "returns [2] for 2"
    (is (= [2] (prime-factors 2))))

  (testing "returns [3] for 3"
    (is (= [3] (prime-factors 3))))

  (testing "returns [2 2] for 4"
    (is (= [2 2] (prime-factors 4))))

  (testing "returns [2 3] for 6"
    (is (= [2 3] (prime-factors 6))))

  (testing "returns [2 2 2] for 8"
    (is (= [2 2 2] (prime-factors 8))))

  (testing "returns [3 3] for 9"
    (is (= [3 3] (prime-factors 9))))

  (testing "returns [2 2 5 5] for 100"
    (is (= [2 2 5 5] (prime-factors 100)))))
