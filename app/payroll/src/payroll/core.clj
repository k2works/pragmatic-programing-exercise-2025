(ns payroll.core
  (:import (java.time LocalDate)
           (java.time.format DateTimeFormatter)
           (java.util Locale)))

(defn parse-date [date-str]
  "Parses a date string in the format 'MMM DD YYYY' (e.g., 'Nov 30 2021') into a LocalDate object.
   Returns the LocalDate object representing the parsed date."
  (let [formatter (DateTimeFormatter/ofPattern "MMM dd yyyy" Locale/ENGLISH)]
    (LocalDate/parse date-str formatter)))

(defn get-pay-class [employee]
  (first (:pay-class employee)))

(defn get-disposition [paycheck-directive]
  (first (:disposition paycheck-directive)))
(defn _get-dispositions [employees]
  "Extract the disposition of each employee"
  (map :disposition employees))

(defmulti is-tody-payday :schedule)
(defmulti calc-pay get-pay-class)
(defmulti dispose get-disposition)

(defn get-employees-to-be-paid-today [today employees]
  (filter #(is-tody-payday % today) employees))
(defn _get-employees-to-be-paid-today [tody employees]
  "Check the schedule of each employee based on the date"
  (cond
    (= tody (LocalDate/of 2021 11 30))
    (filter #(= (:schedule %) :monthly) employees)

    (= tody (LocalDate/of 2022 11 18))
    (concat
      (filter #(= (:schedule %) :weekly) employees)
      (filter #(= (:schedule %) :biweekly) employees))

    :else []))

(defn- build-employee [db employee]
  (assoc employee :db db))

(defn get-employees [db]
  (map (partial build-employee db) (:employees db)))
(defn _get-employees [db]
  (:employees db))

(defn create-paycheck-directive [ids payments dispositions]
  (map #(assoc {} :id %1 :amount %2 :disposition %3)
       ids payments dispositions))

(defn send-paychecks [ids payments dispositions]
  (for [paycheck-directive
        (create-paycheck-directive ids payments dispositions)]
    (dispose paycheck-directive)))
(defn _send-paychecks [ids amounts dispositions]
  "Create a paycheck for each employee"
  (map (fn [id amount disposition]
         (let [disp-type (first disposition)]
           (case disp-type
             :mail (let [name (second disposition)
                         address (nth disposition 2)]
                     {:type :mail
                      :id id
                      :name name
                      :address address
                      :amount amount})
             :deposit (let [routing (second disposition)
                            account (nth disposition 2)]
                        {:type :deposit
                         :id id
                         :routing routing
                         :account account
                         :amount amount})
             :paymaster (let [paymaster (second disposition)]
                          {:type :paymaster
                           :id id
                           :paymaster paymaster
                           :amount amount}))))
       ids amounts dispositions))

(defn get-paycheck-amounts [employees]
  (map calc-pay employees))
(defn _get-paycheck-amounts [employees db]
  "Calculate the amount based on the pay-class of each employee"
  (map (fn [employee]
         (let [pay-class (:pay-class employee)
               pay-type (first pay-class)
               id (:id employee)]
           (case pay-type
             :salaried (second pay-class)
             :hourly (let [time-cards (get-in db [:time-cards id])
                           hours (if time-cards
                                   (second (first time-cards))
                                   0)
                           hourly-rate (second pay-class)]
                       (* hours hourly-rate))
             :commissioned (let [base-salary (second pay-class)
                                 commission-rate (nth pay-class 2)
                                 sales-receipts (get-in db [:sales-receipts id])
                                 sales-amount (if sales-receipts
                                                (second (first sales-receipts))
                                                0)]
                             (+ base-salary (* sales-amount commission-rate))))))
       employees))


(defn get-dispositions [employees]
  (map :disposition employees))

(defn get-ids [employees]
  (map :id employees))
(defn _get-ids [employees]
  "Extract the id of each employee"
  (map :id employees))

;; 月給制の社員は月末に支払い
(defmethod is-tody-payday :monthly [_ today]
  (let [last-day-of-month (.lengthOfMonth today)
        day-of-month (.getDayOfMonth today)]
    (= day-of-month last-day-of-month)))

;; 週給制の社員は毎週金曜日に支払い
(defmethod is-tody-payday :weekly [_ today]
  (= (.getValue (.getDayOfWeek today)) 5)) ;; 5は金曜日

;; 隔週給制の社員は隔週金曜日に支払い
(defmethod is-tody-payday :biweekly [_ today]
  (and
    (= (.getValue (.getDayOfWeek today)) 5) ;; 金曜日
    (even? (quot (.getDayOfYear today) 7)))) ;; 偶数週

;; 郵送による給与支払い
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

;; 銀行振込による給与支払い
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

;; 給与管理者経由の給与支払い
(defmethod dispose :paymaster [paycheck-directive]
  (let [id (:id paycheck-directive)
        amount (:amount paycheck-directive)
        paymaster (second (:disposition paycheck-directive))]
    {:type :paymaster
     :id id
     :paymaster paymaster
     :amount amount}))
;; 固定給の社員の給与計算
(defmethod calc-pay :salaried [employee]
  (let [salary (second (:pay-class employee))]
    salary))

;; 時給制の社員の給与計算
(defmethod calc-pay :hourly [employee]
  (let [hourly-rate (second (:pay-class employee))
        db (:db employee)
        id (:id employee)
        time-cards (get-in db [:time-cards id])
        hours (if time-cards
                (second (first time-cards))
                0)]
    (* hours hourly-rate)))

;; 歩合制の社員の給与計算
(defmethod calc-pay :commissioned [employee]
  (let [base-salary (second (:pay-class employee))
        commission-rate (nth (:pay-class employee) 2)
        db (:db employee)
        id (:id employee)
        sales-receipts (get-in db [:sales-receipts id])
        sales-amount (if sales-receipts
                       (second (first sales-receipts))
                       0)]
    (+ base-salary (* sales-amount commission-rate))))

(defn payroll [tody db]
  (let [employees (get-employees db)
        employees-to-pay (get-employees-to-be-paid-today
                           tody employees)
        amounts (get-paycheck-amounts employees-to-pay)
        ids (get-ids employees-to-pay)
        dispositions (get-dispositions employees-to-pay)]
    (send-paychecks ids amounts dispositions)))
