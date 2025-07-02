(ns design-pattern.abstract-server-test
  (:require [clojure.test :refer :all]
            [design-pattern.abstract-server :refer :all]))

(deftest switch-light-test
  (testing "turns light on and off using legacy multimethods"
    (let [turn-on-light-called (atom false)
          turn-off-light-called (atom false)]
      (with-redefs [turn-on-light (fn [] (reset! turn-on-light-called true))
                    turn-off-light (fn [] (reset! turn-off-light-called true))]
        (engage-switch {:type :light})
        (is @turn-on-light-called "turn-on-light should have been called")
        (is @turn-off-light-called "turn-off-light should have been called")))))

(deftest protocol-light-strategy-test
  (testing "LightStrategy implements SwitchStrategy protocol"
    (let [strategy (->LightStrategy)
          turn-on-light-called (atom false)
          turn-off-light-called (atom false)]
      (with-redefs [turn-on-light (fn [] (reset! turn-on-light-called true))
                    turn-off-light (fn [] (reset! turn-off-light-called true))]
        (turn-on strategy {:type :light})
        (is @turn-on-light-called "turn-on-light should have been called")

        (turn-off strategy {:type :light})
        (is @turn-off-light-called "turn-off-light should have been called")))))

(deftest create-strategy-test
  (testing "create-strategy returns correct strategy for type"
    (let [light-strategy (create-strategy {:type :light})]
      (is (instance? design_pattern.abstract_server.LightStrategy light-strategy) "Should return LightStrategy for :light type")

      (let [unknown-strategy (create-strategy {:type :unknown})]
        (is (nil? unknown-strategy) "Should return nil for unknown type")))))

(deftest engage-switch-with-protocol-test
  (testing "engage-switch uses protocol methods when strategy is available"
    (let [protocol-turn-on-called (atom false)
          protocol-turn-off-called (atom false)
          mock-strategy (reify SwitchStrategy
                          (turn-on [_ _] (reset! protocol-turn-on-called true))
                          (turn-off [_ _] (reset! protocol-turn-off-called true)))]
      (with-redefs [create-strategy (fn [_] mock-strategy)]
        (engage-switch {:type :mock})
        (is @protocol-turn-on-called "Protocol turn-on should have been called")
        (is @protocol-turn-off-called "Protocol turn-off should have been called")))))
