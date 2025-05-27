(ns gossipingBusDrivers.core-test
  (:require [clojure.test :refer :all]
            [gossipingBusDrivers.core :refer :all]))

(deftest gossipingBusDrivers-test
  (testing "Gossiping Bus Drivers")
    (let [driver (make-driver "d1" [:s1] #{:r1})
          world [driver]
          new-world (drive world)]
      (is (= 1 (count new-world)))
      (is (= :s1 (-> new-world first :route first)))))