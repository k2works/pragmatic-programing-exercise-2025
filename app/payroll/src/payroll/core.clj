(ns payroll.core
  (:require [payroll.interface :refer :all])
  (:import (java.time LocalDate)
           (java.time.format DateTimeFormatter)
           (java.util Locale)))

(defn parse-date [date-str]
  "Parses a date string in the format 'MMM DD YYYY' (e.g., 'Nov 30 2021') into a LocalDate object.
   Returns the LocalDate object representing the parsed date."
  (let [formatter (DateTimeFormatter/ofPattern "MMM dd yyyy" Locale/ENGLISH)]
    (LocalDate/parse date-str formatter)))

(defn get-employees-to-be-paid-today [today employees]
  "Check the schedule of each employee based on the date"
  (filter #(is-tody-payday % today) employees))

(defn- build-employee [db employee]
  (assoc employee :db db))

(defn get-employees [db]
  (map (partial build-employee db) (:employees db)))

(defn create-paycheck-directive [ids payments dispositions]
  (map #(assoc {} :id %1 :amount %2 :disposition %3)
       ids payments dispositions))

(defn send-paychecks [ids payments dispositions]
  "Create a paycheck for each employee"
  (for [paycheck-directive
        (create-paycheck-directive ids payments dispositions)]
    (dispose paycheck-directive)))

(defn get-paycheck-amounts [employees]
  "Calculate the amount based on the pay-class of each employee"
  (map calc-pay employees))

(defn get-dispositions [employees]
  (map :disposition employees))

(defn get-ids [employees]
  "Extract the id of each employee"
  (map :id employees))

(defmethod is-tody-payday :monthly [_ today]
  (let [last-day-of-month (.lengthOfMonth today)
        day-of-month (.getDayOfMonth today)]
    (= day-of-month last-day-of-month)))

(defmethod is-tody-payday :weekly [_ today]
  (= (.getValue (.getDayOfWeek today)) 5)) ;; 5は金曜日

(defmethod is-tody-payday :biweekly [_ today]
  (and
    (= (.getValue (.getDayOfWeek today)) 5) ;; 金曜日
    (even? (quot (.getDayOfYear today) 7)))) ;; 偶数週

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

(defn- get-salary [employee]
  (second (:pay-class employee)))

(defmethod calc-pay :salaried [employee]
  (get-salary employee))

(defmethod calc-pay :hourly [employee]
  (let [db (:db employee)
        time-cards (:time-cards db)
        my-time-cards (get time-cards (:id employee))
        [_ hourly-rate] (:pay-class employee)
        hours (map second my-time-cards)
        total-hours (reduce + hours)]
    (* total-hours hourly-rate)))

(defmethod calc-pay :commissioned [employee]
  (let [db (:db employee)
        sales-receipts (:sales-receipts db)
        my-sales-receipts (get sales-receipts (:id employee))
        [_ base-pay commission-rate] (:pay-class employee)
        sales (map second my-sales-receipts)
        total-sales (reduce + sales)]
    (+ (* total-sales commission-rate) base-pay)))

(defn payroll [tody db]
  (let [employees (get-employees db)
        employees-to-pay (get-employees-to-be-paid-today
                           tody employees)
        amounts (get-paycheck-amounts employees-to-pay)
        ids (get-ids employees-to-pay)
        dispositions (get-dispositions employees-to-pay)]
    (send-paychecks ids amounts dispositions)))
