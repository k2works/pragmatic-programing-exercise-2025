(ns design-pattern.decorator.journaled-shape-test
  (:require [clojure.test :refer :all]
            [design-pattern.composite.shape.shape :as shape]
            [design-pattern.composite.shape.square :as square]
            [design-pattern.decorator.journaled-shape :as js]))

(deftest journaled-shape-decorator-test
  (testing "journals scale and translate operations"
    (let [jsd (-> (js/make (square/make-square [0 0] 1))
                  (shape/translate 2 3)
                  (shape/scale 5))]
      (is (= [[:translate 2 3] [:scale 5]]
             (::js/journal jsd))
          "Journal should record translate and scale operations in order")
      (is (= {::shape/type ::square/square
              ::square/top-left [2 3]
              ::square/side 5}
             (::js/shape jsd))
          "Decorated shape should be properly transformed"))))