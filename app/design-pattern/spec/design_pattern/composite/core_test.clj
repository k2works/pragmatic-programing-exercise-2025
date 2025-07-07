(ns design-pattern.composite.core-test
  (:require [clojure.test :refer :all]
            [design-pattern.composite.light :as l]
            [design-pattern.composite.variable-light :as v]
            [design-pattern.composite.switchable :as s]))

(deftest composite-switchable-test
  (testing "turns all on"
    (let [turn-on-light-called (atom false)
          set-light-intensity-called (atom false)
          set-light-intensity-value (atom nil)]
      (with-redefs [l/turn-on-light (fn [] (reset! turn-on-light-called true))
                    v/set-light-intensity (fn [intensity] 
                                            (reset! set-light-intensity-called true)
                                            (reset! set-light-intensity-value intensity))]
        (let [switchables [(l/make-light) (v/make-variable-light)]]
          (doseq [s-able switchables] (s/turn-on s-able))
          (is @turn-on-light-called "turn-on-light should have been called")
          (is @set-light-intensity-called "set-light-intensity should have been called")
          (is (= 100 @set-light-intensity-value) "set-light-intensity should have been called with 100"))))))