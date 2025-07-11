(ns concurrency.core-spec
  (:require [concurrency.core :refer :all]
            [speclj.core :refer :all]))

(describe "Concurrency"
          (it "should make and receive call"
              (let [caller (make-user "Bob")
                    callee (make-user "Alice")
                    telco (make-telco "telco")]
                (reset! log [])
                (send caller transition :call [telco caller callee])
                (Thread/sleep 100)
                (prn @log)
                (should= :idle (:state @caller))
                (should= :idle (:state @callee))
                (should= :idle (:state @telco))))
          (it "should race"
              (let [caller (make-user "Bob")
                    callee (make-user "Alice")
                    telco1 (make-telco "telco1")
                    telco2 (make-telco "telco2")]
                (reset! log [])
                (send caller transition :call [telco1 caller callee])
                (send caller transition :call [telco2 callee caller])
                (Thread/sleep 100)
                (prn @log)
                (should= :idle (:state @caller))
                (should= :idle (:state @callee))
                (should= :idle (:state @telco1))
                (should= :idle (:state @telco2))))
          (it "should handle caller-off-hook"
              (let [caller (make-user "Bob")
                    callee (make-user "Alice")
                    telco (make-telco "telco")]
                (reset! log [])
                (caller-off-hook caller [telco caller callee])
                (Thread/sleep 200)
                (prn @log)
                (should (contains? (set @log) "Bob goes off hook."))
                (should (contains? (set @log) "telco<-caller-off-hook")))))