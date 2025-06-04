(ns payroll.interface)

(defn get-pay-class [employee]
  (first (:pay-class employee)))

(defn get-disposition [paycheck-directive]
  "Extract the disposition of each employee"
  (first (:disposition paycheck-directive)))

(defmulti is-tody-payday :schedule)
(defmulti calc-pay get-pay-class)
(defmulti dispose get-disposition)

