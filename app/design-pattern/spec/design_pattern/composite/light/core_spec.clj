(ns design-pattern.composite.light.core-spec
  (:require [speclj.core :refer :all]
            [design-pattern.composite.light.light :as l]
            [design-pattern.composite.light.variable-light :as v]
            [design-pattern.composite.light.switchable :as s]
            [design-pattern.composite.light.composite-switchable :as cs]))

(describe "composite-switchable"
          (with-stubs)
          (it "turns all on"
              (with-redefs
                [l/turn-on-light (stub :turn-on-light)
                 v/set-light-intensity (stub :set-light-intensity)]
                (let [switchables [(l/make-light) (v/make-variable-light)]]
                  (doseq [s-able switchables] (s/turn-on s-able))
                  (should-have-invoked :turn-on-light)
                  (should-have-invoked :set-light-intensity
                                       {:with [100]})))))
(describe "composite-switchable"
          (with-stubs)
          (it "turns all on"
              (with-redefs
                [l/turn-on-light (stub :turn-on-light)
                 v/set-light-intensity (stub :set-light-intensity)]
                (let [group (-> (cs/make-composite-switchable)
                                (cs/add (l/make-light))
                                (cs/add (v/make-variable-light)))]
                  (s/turn-on group)
                  (should-have-invoked :turn-on-light)
                  (should-have-invoked :set-light-intensity
                                       {:with [100]})))))
