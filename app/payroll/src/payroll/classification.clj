(ns payroll.classification
  (:require [payroll.interface :refer :all]
            [clojure.spec.alpha :as s]
            [payroll.specs :as specs]))

(defn- build-employee [db employee]
  "従業員データにデータベース参照を関連付ける"
  (assoc employee :db db))

(s/fdef build-employee
  :args (s/cat :db ::specs/db :employee ::specs/employee)
  :ret ::specs/employee)

(defn get-employees [db]
  "データベースから全従業員を取得する"
  (map (partial build-employee db) (:employees db)))

(s/fdef get-employees
  :args (s/cat :db ::specs/db)
  :ret (s/coll-of ::specs/employee))

(defn get-paycheck-amounts [employees]
  "各従業員の給与クラスに基づいて給与額を計算する"
  (map calc-pay employees))

(s/fdef get-paycheck-amounts
  :args (s/cat :employees (s/coll-of ::specs/employee))
  :ret (s/coll-of ::specs/amount))

(defn- get-salary [employee]
  "従業員の給与額を取得する"
  (second (:pay-class employee)))

(s/fdef get-salary
  :args (s/cat :employee ::specs/employee)
  :ret ::specs/amount)

(defmethod calc-pay :salaried [employee]
  "給与制従業員の給与を計算する"
  (get-salary employee))

(defmethod calc-pay :hourly [employee]
  "時給制従業員の給与を計算する（勤務時間×時給）"
  (let [db (:db employee)
        time-cards (:time-cards db)
        my-time-cards (get time-cards (:id employee))
        [_ hourly-rate] (:pay-class employee)
        hours (map second my-time-cards)
        total-hours (reduce + hours)]
    (* total-hours hourly-rate)))

(defmethod calc-pay :commissioned [employee]
  "歩合制従業員の給与を計算する（基本給＋売上×歩合率）"
  (let [db (:db employee)
        sales-receipts (:sales-receipts db)
        my-sales-receipts (get sales-receipts (:id employee))
        [_ base-pay commission-rate] (:pay-class employee)
        sales (map second my-sales-receipts)
        total-sales (reduce + sales)]
    (+ (* total-sales commission-rate) base-pay)))
