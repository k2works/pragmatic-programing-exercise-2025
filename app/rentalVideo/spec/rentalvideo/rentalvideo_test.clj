(ns rentalvideo.rentalvideo-test
  (:require [clojure.test :refer :all]
            [rentalvideo.rentalvideo :refer [make-customer make-movie make-rental make-rental-order make-statement]]))

(deftest video-store-test
  (testing "makes statement for a single new release"
    (let [customer (make-customer "Fred")]
      (is (= (str "Rental Record for Fred\n"
                  "\tThe Cell\t9.0\n"
                  "You owed 9.0\n"
                  "You earned 2 frequent renter points\n")
             (make-statement
               (make-rental-order
                 customer  ; @を削除
                 [(make-rental
                    (make-movie "The Cell" :new-release)
                    3)]))))))

  (testing "makes statement for two new releases"
    (let [customer (make-customer "Fred")]
      (is (= (str "Rental Record for Fred\n"
                  "\tThe Cell\t9.0\n"
                  "\tThe Tigger Movie\t9.0\n"
                  "You owed 18.0\n"
                  "You earned 4 frequent renter points\n")
             (make-statement
               (make-rental-order
                 customer
                 [(make-rental
                    (make-movie "The Cell" :new-release)
                    3)
                  (make-rental
                    (make-movie "The Tigger Movie" :new-release)
                    3)]))))))

  (testing "make statement for one children's movie"
    (let [customer (make-customer "Fred")]
      (is (= (str "Rental Record for Fred\n"
                  "\tThe Tigger Movie\t1.5\n"
                  "You owed 1.5\n"
                  "You earned 1 frequent renter points\n")
             (make-statement
               (make-rental-order
                 customer
                 [(make-rental
                    (make-movie "The Tigger Movie" :children)
                    3)])))))))