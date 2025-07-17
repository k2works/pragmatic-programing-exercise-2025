(ns primefactors.core-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.test.check :as tc]
            [clojure.test.check.properties :as prop]
            [clojure.test.check.generators :as gen-tc]
            [primefactors.core :refer :all]))

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

(defn power2 [n]
  (apply * (repeat n 2N)))

(deftest factors-test
  (testing "factors 1 -> []"
    (is (= [] (prime-factors-of 1))))
  (testing "factors 2 -> [2]"
    (is (= [2] (prime-factors-of 2))))
  (testing "factors 3 -> [3]"
    (is (= [3] (prime-factors-of 3))))
  (testing "factors 4 -> [2 2]"
    (is (= [2 2] (prime-factors-of 4))))
  (testing "factors 5 -> [5]"
    (is (= [5] (prime-factors-of 5))))
  (testing "factors 6 -> [2 3]"
    (is (= [2 3] (prime-factors-of 6))))
  (testing "factors 7 -> [7]"
    (is (= [7] (prime-factors-of 7))))
  (testing "factors 8 -> [2 2 2]"
    (is (= [2 2 2] (prime-factors-of 8))))
  (testing "factors 9 -> [3 3]"
    (is (= [3 3] (prime-factors-of 9))))
  (testing "factors lots"
    (is (= [2 2 3 3 5 7 11 11 13]
           (prime-factors-of (* 2 2 3 3 5 7 11 11 13)))))

  (testing "factors Euler 3"
    (is (= [71 839 1471 6857] (prime-factors-of 600851475143))))

  (testing "factors mersenne 2^31-1"
    (is (= [2147483647] (prime-factors-of (dec (power2 31)))))))

(def gen-inputs (gen-tc/large-integer* {:min 1 :max 1E9}))

(deftest factors-multiply-out-property-test
  (testing "factors multiply out properly (generative)"
    (let [result (tc/quick-check
                   1000
                   (prop/for-all
                     [n gen-inputs]
                     (let [factors (factors-of n)]
                       (= n (apply * factors)))))]
      (is (:result result)
          (str "Property test failed: " (:fail result))))))

(deftest factors-are-prime-property-test
  (testing "all factors are prime (generative)"
    (let [result (tc/quick-check
                   1000
                   (prop/for-all
                     [n gen-inputs]
                     (let [factors (factors-of n)]
                       (every? is-prime? factors))))]
      (is (:result result)
          (str "Property test failed: " (:fail result))))))

