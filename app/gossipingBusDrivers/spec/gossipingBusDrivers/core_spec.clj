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
                (should= :s2 (-> new-world first :route first))))
          (it "drives two buses at some stops"
              (let [d1 (make-driver "d1" [:s1 :s2] #{:r1})
                    d2 (make-driver "d2" [:s1 :s3 :s2] #{:r2})
                    world [d1 d2]
                    new-1 (drive world)
                    new-2 (drive new-1)]
                (should= 2 (count new-1))
                (should= :s2 (-> new-1 first :route first))
                (should= :s3 (-> new-1 second :route first))
                (should= 2 (count new-2))
                (should= :s1 (-> new-2 first :route first))
                (should= :s2 (-> new-2 second :route first)))))