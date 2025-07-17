(ns payroll.payroll
  (:require [payroll.schedule :refer [get-employees-to-be-paid-today]]
            [payroll.classification :refer [get-employees get-paycheck-amounts]]
            [payroll.disposition :refer [get-ids get-dispositions send-paychecks]]
            [clojure.spec.alpha :as s]
            [payroll.specs :as specs]))

(defn payroll [tody db]
  "指定された日付に基づいて給与計算を実行し、給与を支払う"
  (let [employees (get-employees db)
        employees-to-pay (get-employees-to-be-paid-today
                           tody employees)
        amounts (get-paycheck-amounts employees-to-pay)
        ids (get-ids employees-to-pay)
        dispositions (get-dispositions employees-to-pay)]
    (send-paychecks ids amounts dispositions)))

(s/fdef payroll
  :args (s/cat :tody any? :db ::specs/db)
  :ret (s/coll-of ::specs/paycheck))
