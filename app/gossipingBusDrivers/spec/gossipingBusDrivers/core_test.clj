(ns gossipingBusDrivers.core-test
  (:require [clojure.test :refer :all]
            [gossipingBusDrivers.core :refer :all]))

(deftest gossipingBusDrivers-test
  (testing "drives one bus at one stop")
    (let [driver (make-driver "d1" [:s1] #{:r1})
          world [driver]
          new-world (drive world)]
      (is (= 1 (count new-world)))
      (is (= :s1 (-> new-world first :route first))))
  (testing "drives one bus at two stops")
  (let [driver (make-driver "d1" [:s1 :s2] #{:r1})
          world [driver]
          new-world (drive world)]
      (is (= 1 (count new-world)))
      (is (= :s2 (-> new-world first :route first)))))