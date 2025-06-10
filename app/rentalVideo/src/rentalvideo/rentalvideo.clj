(ns rentalvideo.rentalvideo
  (:require [clojure.spec.alpha :as s]
            [clojure.string :as string]))

(defn make-customer [name]
  {:name name})

(defn make-movie [title type]
  {:title title
   :type  type})

(defn make-rental [movie days]
  {:movie movie
   :days days})

(defn make-rental-order [customer rentals]
  {:customer customer
   :rentals rentals})

(defn determine-amount [rental]
  (let [{:keys [movie days]} rental
        type (:type movie)]
    (condp = type
      :regular
      (if (> days 2)
        (+ 2.0 (* (- days 2) 1.5))
        2.0)

      :new-release
      (* 3.0 days)

      :childrens
      (if (> days 3)
        (+ 1.5 (* (- days 3) 1.5))
        1.5))))

(defn determine-points [rental]
  (let [{:keys [movie days]} rental
        type (:type movie)]
    (if (and (= type :new-release)
      (> days 1))
    2
    1)))

(defn make-detail [rental]
  (let [title (:title (:movie rental))
        price (determine-amount rental)]
    (format "\t%s\t%.1f" title price)))

(defn make-details [rentals]
  (map make-detail rentals))

(defn make-footer [rentals]
  (let [owed (reduce + (map determine-amount rentals))
        points (reduce + (map determine-points rentals))]
    (format
      "\nYou owed %.1f\nYou earned %d frequent renter points\n"
      owed points)))

(defn make-statement [rental-order]
  (let [{:keys [name]} (:customer rental-order)
        {:keys [rentals]} rental-order
        header (format "Rental Record for %s\n" name)
        details (clojure.string/join "\n" (make-details rentals))
        footer (make-footer rentals)]
    (str header details footer)))