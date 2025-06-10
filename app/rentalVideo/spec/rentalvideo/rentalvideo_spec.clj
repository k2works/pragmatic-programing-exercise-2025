(ns rentalvideo.rentalvideo-spec
  (:require [speclj.core :refer :all]
            [rentalvideo.rentalvideo :refer [make-customer make-movie make-rental make-rental-order make-statement]]))

(describe "Video Store"
          (with customer (make-customer "Fred"))

          (it "makes statement for a single new release"
              (should= (str "Rental Record for Fred\n"
                            "\tThe Cell\t9.0\n"
                            "You owed 9.0\n"
                            "You earned 2 frequent renter points\n")
                       (make-statement
                         (make-rental-order
                           @customer
                           [(make-rental
                              (make-movie "The Cell" :new-release)
                              3)]))))
          (it "makes statement for two new releases"
              (should= (str "Rental Record for Fred\n"
                            "\tThe Cell\t9.0\n"
                            "\tThe Tigger Movie\t9.0\n"
                            "You owed 18.0\n"
                            "You earned 4 frequent renter points\n")
                       (make-statement
                         (make-rental-order
                           @customer
                           [(make-rental
                              (make-movie "The Cell" :new-release)
                              3)
                            (make-rental
                              (make-movie "The Tigger Movie" :new-release)
                              3)]))))
          (it "make statement for one childrens movie"
              (should= (str "Rental Record for Fred\n"
                            "\tThe Tigger Movie\t1.5\n"
                            "You owed 1.5\n"
                            "You earned 1 frequent renter points\n")
                       (make-statement
                         (make-rental-order
                           @customer
                           [(make-rental
                              (make-movie "The Tigger Movie" :children)
                              3)])))))
