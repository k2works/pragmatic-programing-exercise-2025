(ns gossipingBusDrivers.core-test
  (:require [clojure.test :refer :all]
            [gossipingBusDrivers.core :refer :all]))

(deftest gossipingBusDrivers-test
  (testing "drives one bus at one stop"
    (let [driver (make-driver "d1" [:s1] #{:r1})
          world [driver]
          new-world (drive world)]
      (is (= 1 (count new-world)))
      (is (= :s1 (-> new-world first :route first)))))
  (testing "drives one bus at two stops"
    (let [driver (make-driver "d1" [:s1 :s2] #{:r1})
          world [driver]
          new-world (drive world)]
      (is (= 1 (count new-world)))
      (is (= :s2 (-> new-world first :route first)))))
  (testing "drives two buses at some stops"
    (let [d1 (make-driver "d1" [:s1 :s2] #{:r1})
          d2 (make-driver "d2" [:s1 :s3 :s2] #{:r2})
          world [d1 d2]
          new-1 (drive world)
          new-2 (drive new-1)]
      (is (= 2 (count new-1)))
      (is (= :s2 (-> new-1 first :route first)))
      (is (= :s3 (-> new-1 second :route first)))
      (is (= 2 (count new-2)))
      (is (= :s1 (-> new-2 first :route first)))
      (is (= :s2 (-> new-2 second :route first)))))
  (testing "gets stops"
    (let [drivers #{{:name "d1" :route [:s1]}
                    {:name "d2" :route [:s1]}
                    {:name "d3" :route [:s2]}}]
      (is (= {:s1 [{:name "d1" :route [:s1]}
                   {:name "d2" :route [:s1]}]
              :s2 [{:name "d3" :route [:s2]}]}
             (get-stops drivers)))))
  (testing "merges rumors"
    (is (= [{:name "d1" :rumors #{:r2 :r1}}
            {:name "d2" :rumors #{:r2 :r1}}]
           (merge-rumors [{:name "d1" :rumors #{:r1}}
                          {:name "d2" :rumors #{:r2}}]))))
  )