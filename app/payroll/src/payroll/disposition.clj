(ns payroll.disposition
  (:require [payroll.interface :refer :all]
            [clojure.spec.alpha :as s]
            [payroll.specs :as specs]))

(defn create-paycheck-directive [ids payments dispositions]
  "従業員ID、支払額、支払方法から給与支払指示を作成する"
  (map #(assoc {} :id %1 :amount %2 :disposition %3)
       ids payments dispositions))

(s/fdef create-paycheck-directive
  :args (s/cat :ids (s/coll-of ::specs/id)
               :payments (s/coll-of ::specs/amount)
               :dispositions (s/coll-of ::specs/disposition))
  :ret (s/coll-of ::specs/paycheck-directive))

(defn send-paychecks [ids payments dispositions]
  "各従業員の給与小切手を作成する"
  (for [paycheck-directive
        (create-paycheck-directive ids payments dispositions)]
    (dispose paycheck-directive)))

(s/fdef send-paychecks
  :args (s/cat :ids (s/coll-of ::specs/id)
               :payments (s/coll-of ::specs/amount)
               :dispositions (s/coll-of ::specs/disposition))
  :ret (s/coll-of ::specs/paycheck))

(defn get-dispositions [employees]
  "従業員の支払方法を取得する"
  (map :disposition employees))

(s/fdef get-dispositions
  :args (s/cat :employees (s/coll-of ::specs/employee))
  :ret (s/coll-of ::specs/disposition))

(defn get-ids [employees]
  "各従業員のIDを取得する"
  (map :id employees))

(s/fdef get-ids
  :args (s/cat :employees (s/coll-of ::specs/employee))
  :ret (s/coll-of ::specs/id))

(defmethod dispose :mail [paycheck-directive]
  "郵送による給与支払いを処理する"
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
  "銀行振込による給与支払いを処理する"
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
  "給与担当者による直接支払いを処理する"
  (let [id (:id paycheck-directive)
        amount (:amount paycheck-directive)
        paymaster (second (:disposition paycheck-directive))]
    {:type :paymaster
     :id id
     :paymaster paymaster
     :amount amount}))
