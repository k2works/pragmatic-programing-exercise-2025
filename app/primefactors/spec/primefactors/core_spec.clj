(ns primefactors.core-spec
  (:require [clojure.spec.gen.alpha :as gen]
            [clojure.test.check :as tc]
            [clojure.test.check.properties :as prop]
            [clojure.test.check.generators :as gen-tc]
            [speclj.core :refer :all]
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
              (should= [5 5] (prime-factors-of 25))))

(defn power2 [n]
  (apply * (repeat n 2N)))

(describe "factors-of"
          (it "factors 1 -> []"
              (should= [] (factors-of 1)))
          (it "factors 2 -> [2]"
              (should= [2] (factors-of 2)))
          (it "factors 3 -> [3]"
              (should= [3] (factors-of 3)))
          (it "factors 4 -> [2 2]"
              (should= [2 2] (factors-of 4)))
          (it "factors 5 -> [5]"
              (should= [5] (factors-of 5)))
          (it "factors 6 -> [2 3]"
              (should= [2 3] (factors-of 6)))
          (it "factors 7 -> [7]"
              (should= [7] (factors-of 7)))
          (it "factors 8 -> [2 2 2]"
              (should= [2 2 2] (factors-of 8)))
          (it "factors 9 -> [3 3]"
              (should= [3 3] (factors-of 9)))
          (it "factors lots"
              (should= [2 2 3 3 5 7 11 11 13]
                       (factors-of (* 2 2 3 3 5 7 11 11 13))))
          (it "factors Euler 3"
              (should= [71 839 1471 6857] (factors-of 600851475143)))
          (it "factors mersenne 2^31-1"
              (should= [2147483647] (factors-of (dec (power2 31))))))

(def gen-inputs (gen-tc/large-integer* {:min 1 :max 1E9}))

(describe "properties"
          (it "multiplies out properly"
              (should-be
                :result (tc/quick-check
                          1000
                          (prop/for-all
                            [n gen-inputs]
                            (let [factors (factors-of n)]
                              (= n (reduce * factors))))))))

(describe "factors"
          (it "they are all prime"
              (should-be
                :result
                (tc/quick-check
                  1000
                  (prop/for-all
                    [n gen-inputs]
                    (let [factors (factors-of n)]
                      (every? is-prime? factors)))))))