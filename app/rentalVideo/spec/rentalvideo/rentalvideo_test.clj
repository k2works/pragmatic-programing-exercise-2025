(ns rentalvideo.rentalvideo-test
  (:require [clojure.test :refer :all]
            [clojure.spec.alpha :as s]
            [rentalvideo.rentalvideo :refer [create-movie create-customer rent-movie calculate-rental-fee]])
  (:import (java.time LocalDate)))

(deftest movie-creation-test
  (testing "creates a movie with the correct attributes"
    (let [movie (create-movie "The Matrix" "Sci-Fi" :regular)]
      (is (= "The Matrix" (:title movie)))
      (is (= "Sci-Fi" (:genre movie)))
      (is (= :regular (:price-category movie)))
      (is (s/valid? :rentalvideo.rentalvideo/movie movie)))))

(deftest customer-creation-test
  (testing "creates a customer with the correct attributes"
    (let [customer (create-customer "John Doe" "john@example.com")]
      (is (= "John Doe" (:name customer)))
      (is (= "john@example.com" (:email customer)))
      (is (= [] (:rentals customer)))
      (is (s/valid? :rentalvideo.rentalvideo/customer customer)))))

(deftest movie-rental-test
  (testing "adds a rental to a customer's rentals"
    (let [movie (create-movie "The Matrix" "Sci-Fi" :regular)
          customer (create-customer "John Doe" "john@example.com")
          updated-customer (rent-movie customer movie 3)
          rental (first (:rentals updated-customer))]
      (is (= 1 (count (:rentals updated-customer))))
      (is (= movie (:movie rental)))
      (is (= 3 (:days rental)))
      (is (= (LocalDate/now) (:rented-on rental))))))

(deftest rental-fee-calculation-test
  (testing "calculates the correct fee for a new release"
    (let [movie (create-movie "New Movie" "Action" :new-release)]
      (is (= 12.0 (calculate-rental-fee movie 3)))))
  
  (testing "calculates the correct fee for a regular movie"
    (let [movie (create-movie "Regular Movie" "Drama" :regular)]
      (is (= 9.0 (calculate-rental-fee movie 3)))))
  
  (testing "calculates the correct fee for a children's movie"
    (let [movie (create-movie "Children's Movie" "Animation" :children)]
      (is (= 6.0 (calculate-rental-fee movie 3))))))