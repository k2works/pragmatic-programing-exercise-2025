(ns video-store.statement-policy-test
  (:require [clojure.test :refer :all]
            [video-store.constructors :refer :all]
            [video-store.statement-policy :refer :all]
            [video-store.normal-statement-policy :refer :all]
            [video-store.buy-two-get-one-free-policy :refer :all]))

(deftest normal-policy-test
  (let [customer (make-customer "CUSTOMER")
        normal-policy (make-normal-policy)
        new-release-1 (make-movie "new release 1" :new-release)
        new-release-2 (make-movie "new release 2" :new-release)
        childrens (make-movie "childrens" :childrens)
        regular-1 (make-movie "regular 1" :regular)
        regular-2 (make-movie "regular 2" :regular)
        regular-3 (make-movie "regular 3" :regular)]
    
    (testing "makes statement for a single new release"
      (is (= {:customer-name "CUSTOMER"
              :movies [{:title "new release 1"
                        :price 9.0}]
              :owed 9.0
              :points 2}
             (make-statement-data
               (make-rental-order
                 customer
                 [(make-rental new-release-1 3)])))))
    
    (testing "makes statement for two new releases"
      (is (= {:customer-name "CUSTOMER"
              :movies [{:title "new release 1" :price 9.0}
                       {:title "new release 2" :price 9.0}]
              :owed 18.0
              :points 4}
             (make-statement-data
               (make-rental-order
                 customer
                 [(make-rental new-release-1 3)
                  (make-rental new-release-2 3)])))))
    
    (testing "makes statement for one childrens movie"
      (is (= {:customer-name "CUSTOMER",
              :movies [{:title "childrens", :price 1.5}],
              :owed 1.5,
              :points 1}
             (make-statement-data
               normal-policy
               (make-rental-order
                 customer
                 [(make-rental childrens 3)])))))
    
    (testing "make statement for several regular movies"
      (is (= {:customer-name "CUSTOMER",
              :movies [{:title "regular 1", :price 2.0}
                       {:title "regular 2", :price 2.0}
                       {:title "regular 3", :price 3.5}],
              :owed 7.5,
              :points 3}
             (make-statement-data
               normal-policy
               (make-rental-order
                 customer
                 [(make-rental regular-1 1)
                  (make-rental regular-2 2)
                  (make-rental regular-3 3)])))))))

(deftest buy-two-get-one-free-policy-test
  (let [customer (make-customer "CUSTOMER")
        regular-1 (make-movie "regular 1" :regular)
        regular-2 (make-movie "regular 2" :regular)
        new-release-1 (make-movie "new release 1" :new-release)]
    
    (testing "makes statement for several regular movies"
      (is (= {:customer-name "CUSTOMER",
              :movies [{:title "regular 1", :price 2.0}
                       {:title "regular 2", :price 2.0}
                       {:title "new release 1", :price 3.0}],
              :owed 5.0,
              :points 3}
             (make-statement-data
               (make-buy-two-get-one-free-policy)
               (make-rental-order
                 customer
                 [(make-rental regular-1 1)
                  (make-rental regular-2 1)
                  (make-rental new-release-1 1)])))))))