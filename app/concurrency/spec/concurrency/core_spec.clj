(ns concurrency.core-spec
  (:require [concurrency.core :refer :all]
            [speclj.core :refer :all]))

(describe "Concurrency"
          (it "should make and receive call"
              (let [caller (make-user "Bob")
                    callee (make-user "Alice")
                    telco (make-teloc "telco")]
                (reset! log [])
                (send caller transition :call [telco caller callee])
                (Thread/sleep 100)
                (prn @log)
                (should= :idle (:state @caller))
                (should= :idle (:state @callee))
                (should= :idle (:state @telco)))))