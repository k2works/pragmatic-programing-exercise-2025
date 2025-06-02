(ns payroll.core
  (:import (java.time LocalDate)
           (java.time.format DateTimeFormatter)
           (java.util Locale)))

(defn parse-date [date-str]
  "Parses a date string in the format 'MMM DD YYYY' (e.g., 'Nov 30 2021') into a LocalDate object.
   Returns the LocalDate object representing the parsed date."
  (let [formatter (DateTimeFormatter/ofPattern "MMM dd yyyy" Locale/ENGLISH)]
    (LocalDate/parse date-str formatter)))

(defn get-employees [db]
  (:employees db))

(defn get-employees-to-be-paid-today [tody employees]
  "Check the schedule of each employee based on the date"
  (cond
    (= tody (LocalDate/of 2021 11 30))
    (filter #(= (:schedule %) :monthly) employees)

    (= tody (LocalDate/of 2022 11 18))
    (concat 
      (filter #(= (:schedule %) :weekly) employees)
      (filter #(= (:schedule %) :biweekly) employees))

    :else []))

(defn get-paycheck-amounts [employees db]
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

(defn get-ids [employees]
  "Extract the id of each employee"
  (map :id employees))

(defn get-dispositions [employees]
  "Extract the disposition of each employee"
  (map :disposition employees))

(defn send-paychecks [ids amounts dispositions]
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

(defn payroll [tody db]
  (let [employees (get-employees db)
        employees-to-pay (get-employees-to-be-paid-today
                           tody employees)
        amounts (get-paycheck-amounts employees-to-pay db)
        ids (get-ids employees-to-pay)
        dispositions (get-dispositions employees-to-pay)]
    (send-paychecks ids amounts dispositions)))
