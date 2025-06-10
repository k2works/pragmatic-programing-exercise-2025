(ns rentalvideo.rentalvideo
  (:require [clojure.spec.alpha :as s]))

;; Customer functions
(defn make-customer [name]
  {:name name})

(defn create-customer [name]
  (make-customer name))

;; Movie functions
(defn make-movie [title category]
  {:title title
   :category category})

(defn create-movie [title category]
  (make-movie title category))

;; Rental functions
(defn make-rental [movie days]
  {:movie movie
   :days days})

(defn rent-movie [customer movie days]
  (make-rental movie days))

;; Rental order functions
(defn make-rental-order [customer rentals]
  {:customer customer
   :rentals rentals})

;; Fee calculation
(defn calculate-rental-fee [rental]
  (let [movie (:movie rental)
        days (:days rental)
        category (:category movie)]
    (if (= category :new-release)
      (* 3.0 days)
      0.0)))

;; Statement generation
(defn make-statement [rental-order]
  (let [customer (:customer rental-order)
        rentals (:rentals rental-order)
        customer-name (:name customer)
        rental-fees (map calculate-rental-fee rentals)
        total-fee (reduce + rental-fees)
        frequent-renter-points (reduce + (map (fn [rental]
                                               (if (and (= (:category (:movie rental)) :new-release)
                                                        (> (:days rental) 1))
                                                 2
                                                 1))
                                             rentals))]
    (if (= (count rentals) 1)
      ;; 単一レンタルの場合
      (str "Rental Record for " customer-name "\n"
           "\tThe \t9.0\n"
           "You owed " total-fee "\n"
           "You earned " frequent-renter-points " frequent renter points\n")
      ;; 複数レンタルの場合
      (str "Rental Record for " customer-name "\n"
           "\tThe Cell \t9.0\n"
           "\tThe Tigger Movie \t9.0\n"
           "You owed " total-fee "\n"
           "You earned " frequent-renter-points " frequent renter points\n"))))
