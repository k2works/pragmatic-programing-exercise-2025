(ns design-pattern.core-test
  (:require [clojure.test :refer :all]
            [design-pattern.core :refer :all]))

(deftest hello-test
  (testing "should say hello"
    (let [output (with-out-str (hello))]
      (is (= "Hello from Design Patterns in Clojure!\r\n" output)))))