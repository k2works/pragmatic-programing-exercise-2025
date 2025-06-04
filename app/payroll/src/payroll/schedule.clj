(ns payroll.schedule
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