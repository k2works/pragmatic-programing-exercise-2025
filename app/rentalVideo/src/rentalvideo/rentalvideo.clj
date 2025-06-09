(ns rentalvideo.rentalvideo
  (:require [clojure.spec.alpha :as s]))

;; Define a simple data model for a rental video system
(defn create-movie
  "Create a new movie with the given title, genre, and price category"
  [title genre price-category]
  {:title title
   :genre genre
   :price-category price-category})

(defn create-customer
  "Create a new customer with the given name and email"
  [name email]
  {:name name
   :email email
   :rentals []})

(defn rent-movie
  "Rent a movie to a customer"
  [customer movie rental-days]
  (let [rental {:movie movie
                :days rental-days
                :rented-on (java.time.LocalDate/now)}]
    (update customer :rentals conj rental)))

(defn calculate-rental-fee
  "Calculate the rental fee for a movie based on its price category and rental days"
  [movie rental-days]
  (let [base-price (case (:price-category movie)
                     :new-release 4.0
                     :regular 3.0
                     :children 2.0)]
    (* base-price rental-days)))

;; Define specs for validation
(s/def ::title string?)
(s/def ::genre string?)
(s/def ::price-category #{:new-release :regular :children})
(s/def ::movie (s/keys :req-un [::title ::genre ::price-category]))

(s/def ::name string?)
(s/def ::email string?)
(s/def ::rentals (s/coll-of map?))
(s/def ::customer (s/keys :req-un [::name ::email ::rentals]))

;; Function specs
(s/fdef create-movie
  :args (s/cat :title string? :genre string? :price-category #{:new-release :regular :children})
  :ret ::movie)

(s/fdef create-customer
  :args (s/cat :name string? :email string?)
  :ret ::customer)

(s/fdef rent-movie
  :args (s/cat :customer ::customer :movie ::movie :rental-days pos-int?)
  :ret ::customer)

(s/fdef calculate-rental-fee
  :args (s/cat :movie ::movie :rental-days pos-int?)
  :ret number?)