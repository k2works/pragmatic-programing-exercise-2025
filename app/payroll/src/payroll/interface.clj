(ns payroll.interface
  (:require [clojure.spec.alpha :as s]
            [payroll.specs :as specs]))

(defn get-pay-class [employee]
  "従業員の給与クラスを取得する"
  (first (:pay-class employee)))

(s/fdef get-pay-class
  :args (s/cat :employee ::specs/employee)
  :ret keyword?)

(defn get-disposition [paycheck-directive]
  "各従業員の支払い方法を取得する"
  (first (:disposition paycheck-directive)))

(s/fdef get-disposition
  :args (s/cat :paycheck-directive (s/or :employee ::specs/employee
                                         :directive ::specs/paycheck-directive))
  :ret keyword?)

(defmulti is-tody-payday 
  "今日が給料日かどうかを判断する"
  :schedule)
(s/fdef is-tody-payday
  :args (s/cat :employee ::specs/employee :today any?)
  :ret boolean?)

(defmulti calc-pay 
  "給与クラスに基づいて給与を計算する"
  get-pay-class)
(s/fdef calc-pay
  :args (s/cat :employee ::specs/employee)
  :ret ::specs/amount)

(defmulti dispose 
  "支払い方法に基づいて給与を支払う"
  get-disposition)
(s/fdef dispose
  :args (s/cat :paycheck-directive ::specs/paycheck-directive)
  :ret ::specs/paycheck)
