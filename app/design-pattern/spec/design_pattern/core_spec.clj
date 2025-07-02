(ns design-pattern.core-spec
  (:require [speclj.core :refer :all]
            [design-pattern.core :refer :all]))

(describe "switch/light"
          (with-stubs)
          (it "turns light on and off"
              (with-redefs [turn-on-light (stub :turn-on-light)
                            turn-off-light (stub :turn-off-light)]
                (engage-switch {:type :light})
                (should-have-invoked :turn-on-light)
                (should-have-invoked :turn-off-light))))