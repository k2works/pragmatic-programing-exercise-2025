(ns design-pattern.core-spec
  (:require [speclj.core :refer :all]
            [design-pattern.core :refer :all]))

(describe "Design Pattern Core"
  (it "should say hello"
    (should= "Hello from Design Patterns in Clojure!\r\n"
             (with-out-str (hello)))))