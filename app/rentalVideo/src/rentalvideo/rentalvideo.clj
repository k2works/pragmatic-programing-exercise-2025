(ns rentalvideo.rentalvideo
  (:require [clojure.spec.alpha :as s]))

;; Customer functions
(defn make-customer [name]
  {:name name})

;; Movie functions
(defn make-movie [title category]
  {:title title
   :category category})

;; Rental functions
(defn make-rental [movie days]
  {:movie movie
   :days days})

;; Rental order functions
(defn make-rental-order [customer rentals]
  {:customer customer
   :rentals rentals})

;; Fee calculation
(defn calculate-rental-fee [rental]
  (let [movie (:movie rental)
        days (:days rental)
        category (:category movie)]
    (case category
      :new-release (* 3.0 days)
      :children (if (<= days 3) 1.5 (+ 1.5 (* 1.5 (- days 3))))
      :regular (if (<= days 2) 2.0 (+ 2.0 (* 1.5 (- days 2))))
      0.0)))

;; Statement generation
(defn make-statement [rental-order]
  (let [customer (:customer rental-order)
        rentals (:rentals rental-order)
        customer-name (:name customer)
        rental-lines (map (fn [rental]
                            (let [movie (:movie rental)
                                  fee (calculate-rental-fee rental)]
                              (str "\t" (:title movie) "\t" fee)))
                          rentals)
        total-fee (reduce + (map calculate-rental-fee rentals))
        frequent-renter-points (reduce + (map (fn [rental]
                                               (if (and (= (:category (:movie rental)) :new-release)
                                                        (> (:days rental) 1))
                                                 2
                                                 1))
                                             rentals))]
    (str "Rental Record for " customer-name "\n"
         (clojure.string/join "\n" rental-lines) "\n"
         "You owed " total-fee "\n"
         "You earned " frequent-renter-points " frequent renter points\n")))
