(ns gossipingBusDrivers.core-spec
  (:require [speclj.core :refer :all]
            [gossipingBusDrivers.core :refer :all]))

(describe "Gossiping Bus Drivers"
          (it "drives one bus at one stop"
              (let [driver (make-driver "d1" [:s1] #{:r1})
                    world [driver]
                    new-world (drive world)]
                (should= 1 (count new-world))
                (should= :s1 (-> new-world first :route first)))))