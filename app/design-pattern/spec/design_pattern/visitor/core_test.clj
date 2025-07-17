(ns design-pattern.visitor.core-test
  (:require [clojure.test :refer :all]
            [design-pattern.visitor.circle :as circle]
            [design-pattern.visitor.square :as square]
            [design-pattern.visitor.main]
            [design-pattern.visitor.json-shape-visitor :as jv]))

(deftest shape-visitor-test
  (testing "makes json square"
    (is (= "{\"top-left\":[0,0],\"side\": 1}"
           (jv/to-json (square/make [0 0] 1)))))
  
  (testing "makes json circle"
    (is (= "{\"center\":[3,4],\"radius\": 1}"
           (jv/to-json (circle/make [3 4] 1))))))