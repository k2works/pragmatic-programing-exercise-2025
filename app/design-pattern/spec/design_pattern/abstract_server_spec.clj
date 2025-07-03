(ns design-pattern.abstract-server-spec
  (:require [speclj.core :refer :all]
            [design-pattern.abstract-server :refer :all]))

(describe "switch/light"
          (with-stubs)
          (it "turns light on and off using legacy multimethods"
              (with-redefs [turn-on-light (stub :turn-on-light)
                            turn-off-light (stub :turn-off-light)]
                (engage-switch {:type :light})
                (should-have-invoked :turn-on-light)
                (should-have-invoked :turn-off-light))))

(describe "SwitchStrategy protocol"
          (with-stubs)
          (it "LightStrategy implements SwitchStrategy protocol"
              (let [strategy (->LightStrategy)]
                (with-redefs [turn-on-light (stub :turn-on-light)
                              turn-off-light (stub :turn-off-light)]
                  (turn-on strategy {:type :light})
                  (should-have-invoked :turn-on-light)

                  (turn-off strategy {:type :light})
                  (should-have-invoked :turn-off-light)))))

(describe "create-strategy function"
          (it "returns correct strategy for type"
              (let [light-strategy (create-strategy {:type :light})]
                (should (instance? design_pattern.abstract_server.LightStrategy light-strategy))

                (let [unknown-strategy (create-strategy {:type :unknown})]
                  (should= nil unknown-strategy)))))

(describe "engage-switch with protocol"
          (with-stubs)
          (it "uses protocol methods when strategy is available"
              (let [mock-strategy (reify SwitchStrategy
                                    (turn-on [_ _] ((stub :protocol-turn-on)))
                                    (turn-off [_ _] ((stub :protocol-turn-off))))]
                (with-redefs [create-strategy (fn [_] mock-strategy)]
                  (engage-switch {:type :mock})
                  (should-have-invoked :protocol-turn-on)
                  (should-have-invoked :protocol-turn-off)))))
