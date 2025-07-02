(ns design-pattern.abstract-server-test
  (:require [clojure.test :refer :all]
            [design-pattern.abstract-server :refer :all]))

(deftest switch-light-test
  (testing "turns light on and off"
    (let [turn-on-light-called (atom false)
          turn-off-light-called (atom false)]
      (with-redefs [turn-on-light (fn [] (reset! turn-on-light-called true))
                    turn-off-light (fn [] (reset! turn-off-light-called true))]
        (engage-switch {:type :light})
        (is @turn-on-light-called "turn-on-light should have been called")
        (is @turn-off-light-called "turn-off-light should have been called")))))
