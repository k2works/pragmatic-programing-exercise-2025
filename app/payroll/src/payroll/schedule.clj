(ns payroll.schedule
  (:require [payroll.interface :refer :all]
            [clojure.spec.alpha :as s]
            [payroll.specs :as specs]))

(defn get-employees-to-be-paid-today [today employees]
  "日付に基づいて各従業員のスケジュールを確認し、今日給料日の従業員を取得する"
  (filter #(is-tody-payday % today) employees))

(s/fdef get-employees-to-be-paid-today
  :args (s/cat :today any? :employees (s/coll-of ::specs/employee))
  :ret (s/coll-of ::specs/employee))

(defmethod is-tody-payday :monthly [_ today]
  "月次給与の場合、月の最終日が給料日"
  (let [last-day-of-month (.lengthOfMonth today)
        day-of-month (.getDayOfMonth today)]
    (= day-of-month last-day-of-month)))

(defmethod is-tody-payday :weekly [_ today]
  "週次給与の場合、金曜日が給料日"
  (= (.getValue (.getDayOfWeek today)) 5)) ;; 5は金曜日

(defmethod is-tody-payday :biweekly [_ today]
  "隔週給与の場合、偶数週の金曜日が給料日"
  (and
    (= (.getValue (.getDayOfWeek today)) 5) ;; 金曜日
    (even? (quot (.getDayOfYear today) 7)))) ;; 偶数週
