(ns design-pattern.visitor.core-spec
  (:require [design-pattern.visitor.circle :as circle]
            [design-pattern.visitor.square :as square]
            [design-pattern.visitor.json-shape-visitor :as jv]
            [design-pattern.visitor.main]
            [speclj.core :refer :all]))

(describe "shape-visitor"
          (it "makes json square"
              (should= "{\"top-left\":[0,0],\"side\": 1}"
                       (jv/to-json (square/make [0 0] 1))))
          (it "makes json circle"
              (should= "{\"center\":[3,4],\"radius\": 1}"
                       (jv/to-json (circle/make [3 4] 1)))))
