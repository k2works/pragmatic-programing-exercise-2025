(ns payroll.disposition
  (:require [payroll.interface :refer :all]))

(defn create-paycheck-directive [ids payments dispositions]
  (map #(assoc {} :id %1 :amount %2 :disposition %3)
       ids payments dispositions))

(defn send-paychecks [ids payments dispositions]
  "Create a paycheck for each employee"
  (for [paycheck-directive
        (create-paycheck-directive ids payments dispositions)]
    (dispose paycheck-directive)))

(defn get-dispositions [employees]
  (map :disposition employees))

(defn get-ids [employees]
  "Extract the id of each employee"
  (map :id employees))

(defmethod dispose :mail [paycheck-directive]
  (let [id (:id paycheck-directive)
        amount (:amount paycheck-directive)
        name (second (:disposition paycheck-directive))
        address (nth (:disposition paycheck-directive) 2)]
    {:type :mail
     :id id
     :name name
     :address address
     :amount amount}))

(defmethod dispose :deposit [paycheck-directive]
  (let [id (:id paycheck-directive)
        amount (:amount paycheck-directive)
        routing (second (:disposition paycheck-directive))
        account (nth (:disposition paycheck-directive) 2)]
    {:type :deposit
     :id id
     :routing routing
     :account account
     :amount amount}))

(defmethod dispose :paymaster [paycheck-directive]
  (let [id (:id paycheck-directive)
        amount (:amount paycheck-directive)
        paymaster (second (:disposition paycheck-directive))]
    {:type :paymaster
     :id id
     :paymaster paymaster
     :amount amount}))