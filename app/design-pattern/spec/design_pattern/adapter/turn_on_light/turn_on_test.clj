(ns design-pattern.adapter.turn-on-light.turn-on-test
  (:require [clojure.test :refer :all]
            [design-pattern.adapter.turn-on-light.engage-switch :refer :all]
            [design-pattern.adapter.turn-on-light.variable-light :as v-l]
            [design-pattern.adapter.turn-on-light.variable-light-adapter :as v-l-adapter]
            [design-pattern.adapter.turn-on-light.switchable :as s]))

(deftest adapter-test
  (testing "turns light on and off"
    (let [turn-on-light-calls (atom [])]
      (with-redefs [v-l/turn-on-light (fn [intensity] (swap! turn-on-light-calls conj intensity))]
        (engage-switch (v-l-adapter/make-adapter 5 90))
        (is (= [90 5] @turn-on-light-calls) "turn-on-light should have been called with correct intensities")
        (is (= 90 (first @turn-on-light-calls)) "turn-on-light should have been called with 90 first")
        (is (= 5 (second @turn-on-light-calls)) "turn-on-light should have been called with 5 second")))))

(deftest variable-light-adapter-test
  (testing "turns light on and off using adapter"
    (let [turn-on-light-calls (atom [])]
      (with-redefs [v-l/turn-on-light (fn [intensity] (swap! turn-on-light-calls conj intensity))]
        (engage-switch (v-l-adapter/make-adapter 5 90))
        (is (= [90 5] @turn-on-light-calls) "turn-on-light should have been called with correct intensities"))))

  (testing "dispatches switchable multimethods correctly"
    (let [turn-on-light-calls (atom [])]
      (with-redefs [v-l/turn-on-light (fn [intensity] (swap! turn-on-light-calls conj intensity))]
        (let [adapter (v-l-adapter/make-adapter 10 80)]
          (s/turn-on adapter)
          (is (= [80] @turn-on-light-calls) "turn-on-light should have been called with max intensity")

          (s/turn-off adapter)
          (is (= [80 10] @turn-on-light-calls) "turn-on-light should have been called with min intensity")))))

  (testing "creates adapter with correct properties"
    (let [adapter1 (v-l-adapter/make-adapter 0 100)
          adapter2 (v-l-adapter/make-adapter 20 75)]
      (is (= :variable-light (:type adapter1)) "adapter1 should have correct type")
      (is (= 0 (:min-intensity adapter1)) "adapter1 should have correct min-intensity")
      (is (= 100 (:max-intensity adapter1)) "adapter1 should have correct max-intensity")

      (is (= :variable-light (:type adapter2)) "adapter2 should have correct type")
      (is (= 20 (:min-intensity adapter2)) "adapter2 should have correct min-intensity")
      (is (= 75 (:max-intensity adapter2)) "adapter2 should have correct max-intensity")))

  (testing "calls turn-on and turn-off in sequence when engaging switch"
    (let [operations (atom [])]
      (with-redefs [s/turn-on (fn [switchable] (swap! operations conj [:turn-on switchable]))
                    s/turn-off (fn [switchable] (swap! operations conj [:turn-off switchable]))]
        (engage-switch (v-l-adapter/make-adapter 5 90))
        (is (= 2 (count @operations)) "should have 2 operations")
        (is (= :turn-on (first (first @operations))) "first operation should be turn-on")
        (is (= :turn-off (first (second @operations))) "second operation should be turn-off")))))
