(ns payroll.payroll
  (:require [payroll.interface :refer :all]
            [payroll.core :refer [get-employees
                                  get-employees-to-be-paid-today
                                  get-paycheck-amounts
                                  get-ids
                                  get-dispositions
                                  send-paychecks]]))

(defn payroll [tody db]
  (let [employees (get-employees db)
        employees-to-pay (get-employees-to-be-paid-today
                           tody employees)
        amounts (get-paycheck-amounts employees-to-pay)
        ids (get-ids employees-to-pay)
        dispositions (get-dispositions employees-to-pay)]
    (send-paychecks ids amounts dispositions)))