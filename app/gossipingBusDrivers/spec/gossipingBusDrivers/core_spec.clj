(ns gossipingBusDrivers.core-spec
  (:require [speclj.core :refer :all]
            [gossipingBusDrivers.core :refer :all]))

(describe "Gossiping Bus Drivers"
          (it "drives one bus at one stop"
              (let [driver (make-driver "d1" [:s1] #{:r1})
                    world [driver]
                    new-world (drive world)]
                (should= 1 (count new-world))
                (should= :s1 (-> new-world first :route first))))
          (it "drive one bus at two stops"
              (let [driver (make-driver "d1" [:s1 :s2] #{:r1})
                    world [driver]
                    new-world (drive world)]
                (should= 1 (count new-world))
                (should= :s2 (-> new-world first :route first)))))