(ns concurrency.core-test
  (:require [clojure.test :refer :all]
            [concurrency.core :refer :all]))

(deftest concurrency-test
  (testing "should make and receive call"
    (let [caller (make-user "Bob")
          callee (make-user "Alice")
          telco (make-telco "telco")]
      (reset! log [])
      (send caller transition :call [telco caller callee])
      (Thread/sleep 100)
      (prn @log)
      (is (= :idle (:state @caller)))
      (is (= :idle (:state @callee)))
      (is (= :idle (:state @telco))))))

(deftest race-test
  (testing "should race"
    (let [caller (make-user "Bob")
          callee (make-user "Alice")
          telco1 (make-telco "telco1")
          telco2 (make-telco "telco2")]
      (reset! log [])
      (send caller transition :call [telco1 caller callee])
      (send caller transition :call [telco2 callee caller])
      (Thread/sleep 100)
      (prn @log)
      (is (= :idle (:state @caller)))
      (is (= :idle (:state @callee)))
      (is (= :idle (:state @telco1)))
      (is (= :idle (:state @telco2))))))

(deftest caller-off-hook-test
  (testing "should handle caller-off-hook"
    (let [caller (make-user "Bob")
          callee (make-user "Alice")
          telco (make-telco "telco")]
      (reset! log [])
      (caller-off-hook caller [telco caller callee])
      (Thread/sleep 50)
      (prn @log)
      (is (= :idle (:state @caller)))
      (is (= :idle (:state @callee)))
      (is (contains? (set @log) "Bob goes off hook."))
      (is (contains? (set @log) "telco<-caller-off-hook")))))
