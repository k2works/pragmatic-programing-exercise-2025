(ns rentalvideo.rentalvideo-test
  (:require [clojure.test :refer :all]
            [rentalvideo.rentalvideo :refer :all]))

(deftest video-store-test
  (testing "makes statement for a single new release"
    (let [customer (make-customer "Fred")]
      (is (= {:customer-name "Fred"
              :movies [{:title "The Cell" :price 9.0}]
              :owed 9.0
              :points 2}
             (make-statement-data
               (make-rental-order
                 customer
                 [(make-rental
                    (make-movie "The Cell" :new-release)
                    3)]))))))

  (testing "makes statement for two new releases"
    (let [customer (make-customer "Fred")]
      (is (= {:customer-name "Fred"
              :movies [{:title "The Cell" :price 9.0}
                       {:title "The Tigger Movie" :price 9.0}]
              :owed 18.0
              :points 4}
             (make-statement-data
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
      (is (= {:customer-name "Fred"
              :movies [{:title "The Tigger Movie" :price 1.5}]
              :owed 1.5
              :points 1}
             (make-statement-data
               (make-rental-order
                 customer
                 [(make-rental
                    (make-movie "The Tigger Movie" :childrens)
                    3)]))))))

  (testing "makes statement for several regular movies"
    (let [customer (make-customer "Fred")]
      (is (= {:customer-name "Fred"
              :movies [{:title "Plan 9 from Outer Space" :price 2.0}
                       {:title "8 1/2" :price 2.0}
                       {:title "Eraserhead" :price 3.5}]
              :owed 7.5
              :points 3}
               (make-statement-data
                 (make-rental-order
                   customer
                   [(make-rental
                      (make-movie "Plan 9 from Outer Space" :regular)
                      1)
                    (make-rental
                      (make-movie "8 1/2" :regular)
                      2)
                    (make-rental
                      (make-movie "Eraserhead" :regular)
                      3)])))))))