(ns wator.core-test
  (:require [clojure.test :refer :all]
            [wator.core :refer :all]
            [wator
             [cell :as cell]
             [water :as water]
             [fish :as fish]]))

(deftest water-test
  (testing "water usually remains water"
    (with-redefs [rand (constantly 0.0)]
      (let [water (water/make)
            evolved (cell/tick water)]
        (is (= ::water/water (::cell/type evolved))))))

  (testing "water occasionally evolves into a fish"
    (with-redefs [rand (constantly 1.0)]
      (let [water (water/make)
            evolved (cell/tick water)]
        (is (= ::fish/fish (::cell/type evolved)))))))
