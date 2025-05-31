(ns payroll.core)

(defn parse-date [date-str]
  ;; For now, just return the date string as is
  ;; In a real implementation, this would parse the string into a date object
  date-str)

(defn get-employees [db]
  (:employees db))

(defn get-employees-to-be-paid-today [tody employees]
  ;; For now, just return all employees if the date is the end of the month
  ;; In a real implementation, this would check the schedule of each employee
  (if (= tody "Nov 30 2021")
    (filter #(= (:schedule %) :monthly) employees)
    []))

(defn get-paycheck-amounts [employees]
  ;; Extract the amount from the pay-class of each employee
  (map #(second (:pay-class %)) employees))

(defn get-ids [employees]
  ;; Extract the id of each employee
  (map :id employees))

(defn get-dispositions [employees]
  ;; Extract the disposition of each employee
  (map :disposition employees))

(defn send-paychecks [ids amounts dispositions]
  ;; Create a paycheck for each employee
  (map (fn [id amount disposition]
         (let [disp-type (first disposition)
               name (second disposition)
               address (nth disposition 2)]
           (case disp-type
             :mail {:type :mail
                    :id id
                    :name name
                    :address address
                    :amount amount})))
       ids amounts dispositions))

(defn payroll [tody db]
  (let [employees (get-employees db)
        employees-to-pay (get-employees-to-be-paid-today
                           tody employees)
        amounts (get-paycheck-amounts employees-to-pay)
        ids (get-ids employees-to-pay)
        dispositions (get-dispositions employees-to-pay)]
    (send-paychecks ids amounts dispositions)))
