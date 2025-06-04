(ns payroll.interface)

(defn get-pay-class [employee]
  "従業員の給与クラスを取得する"
  (first (:pay-class employee)))

(defn get-disposition [paycheck-directive]
  "各従業員の支払い方法を取得する"
  (first (:disposition paycheck-directive)))

(defmulti is-tody-payday :schedule
  "今日が給料日かどうかを判断する")
(defmulti calc-pay get-pay-class
  "給与クラスに基づいて給与を計算する")
(defmulti dispose get-disposition
  "支払い方法に基づいて給与を支払う")
