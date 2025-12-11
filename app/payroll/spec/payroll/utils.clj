(ns payroll.utils
  (:require [payroll.interface :as interface]
            [clojure.spec.alpha :as s]
            [payroll.specs :as specs])
  (:import (java.time LocalDate)
           (java.time.format DateTimeFormatter)
           (java.util Locale)))

(defn parse-date [date-str]
  "Parses a date string in the format 'MMM DD YYYY' (e.g., 'Nov 30 2021') into a LocalDate object.
   Returns the LocalDate object representing the parsed date."
  (let [formatter (DateTimeFormatter/ofPattern "MMM dd yyyy" Locale/ENGLISH)]
    (LocalDate/parse date-str formatter)))

(s/def ::date-str string?)
(s/def ::local-date #(instance? LocalDate %))

(s/fdef parse-date
  :args (s/cat :date-str ::date-str)
  :ret ::local-date)
