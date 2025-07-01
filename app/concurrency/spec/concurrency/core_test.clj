(ns concurrency.core-test
  (:require [clojure.test :refer :all]
            [concurrency.core :refer :all]))

(deftest concurrency-test
  (testing "should make and receive call"
    (let [caller (make-user "Bob")
          callee (make-user "Alice")
          telco (make-teloc "telco")]
      (reset! log [])
      (send caller transition :call [telco caller callee])
      (Thread/sleep 100)
      (prn @log)
      (is (= :idle (:state @caller)))
      (is (= :idle (:state @callee)))
      (is (= :idle (:state @telco))))))
