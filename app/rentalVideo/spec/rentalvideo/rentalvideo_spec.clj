(ns rentalvideo.rentalvideo-spec
  (:require [speclj.core :refer :all]
            [clojure.spec.alpha :as s]
            [rentalvideo.rentalvideo :refer [create-movie create-customer rent-movie calculate-rental-fee]])
  (:import (java.time LocalDate)))

(describe "Movie Creation"
  (it "creates a movie with the correct attributes"
    (let [movie (create-movie "The Matrix" "Sci-Fi" :regular)]
      (should= "The Matrix" (:title movie))
      (should= "Sci-Fi" (:genre movie))
      (should= :regular (:price-category movie))
      (should (s/valid? :rentalvideo.rentalvideo/movie movie)))))

(describe "Customer Creation"
  (it "creates a customer with the correct attributes"
    (let [customer (create-customer "John Doe" "john@example.com")]
      (should= "John Doe" (:name customer))
      (should= "john@example.com" (:email customer))
      (should= [] (:rentals customer))
      (should (s/valid? :rentalvideo.rentalvideo/customer customer)))))

(describe "Movie Rental"
  (it "adds a rental to a customer's rentals"
    (let [movie (create-movie "The Matrix" "Sci-Fi" :regular)
          customer (create-customer "John Doe" "john@example.com")
          updated-customer (rent-movie customer movie 3)
          rental (first (:rentals updated-customer))]
      (should= 1 (count (:rentals updated-customer)))
      (should= movie (:movie rental))
      (should= 3 (:days rental))
      (should= (LocalDate/now) (:rented-on rental)))))

(describe "Rental Fee Calculation"
  (it "calculates the correct fee for a new release"
    (let [movie (create-movie "New Movie" "Action" :new-release)]
      (should= 12.0 (calculate-rental-fee movie 3))))
  
  (it "calculates the correct fee for a regular movie"
    (let [movie (create-movie "Regular Movie" "Drama" :regular)]
      (should= 9.0 (calculate-rental-fee movie 3))))
  
  (it "calculates the correct fee for a children's movie"
    (let [movie (create-movie "Children's Movie" "Animation" :children)]
      (should= 6.0 (calculate-rental-fee movie 3)))))