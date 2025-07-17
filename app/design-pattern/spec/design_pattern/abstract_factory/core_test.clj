(ns design-pattern.abstract-factory.core-test
  (:require [clojure.test :refer :all]
            [design-pattern.abstract-factory
             [shape :as shape]
             [shape-factory :as factory]
             [main :as main]]))

(deftest shape-factory-test
  (testing "Shape Factory"
    (main/init)
    
    (testing "creates a square"
      (let [square (factory/make
                     @main/shape-factory
                     :square
                     [100 100] 10)]
        (is (= "Square top-left: [100, 100] side: 10"
               (shape/to-string square)))))
    
    (testing "creates a circle"
      (let [circle (factory/make
                     @main/shape-factory
                     :circle
                     [100 100] 10)]
        (is (= "Circle center: [100, 100] radius: 10"
               (shape/to-string circle)))))))