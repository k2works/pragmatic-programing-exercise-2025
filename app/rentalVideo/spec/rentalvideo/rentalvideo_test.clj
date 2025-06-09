(ns rentalvideo.rentalvideo-test
  (:require [clojure.test :refer :all]
            [rentalvideo.rentalvideo :refer [make-customer make-movie make-rental make-rental-order make-statement]]))

(deftest video-store-test
  (let [customer (atom (make-customer "Fred"))]
    (testing "makes statement for a single new release"
      (is (= (str "Rental Record for Fred\n"
                  "\tThe \t9.0\n"
                  "You owed 9.0\n"
                  "You earned 2 frequent renter points\n")
             (make-statement
               (make-rental-order
                 @customer
                 [(make-rental
                    (make-movie "The Cell" :new-release)
                    3)])))))))