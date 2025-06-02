(ns payroll.core-test
 (:require [clojure.test :refer :all]
           [payroll.core :refer :all])
 (:import (java.time LocalDate)))

(deftest parse-date-test
  (testing "parse-date correctly parses date strings"
    (is (= (LocalDate/of 2021 11 30) (parse-date "Nov 30 2021")))
    (is (= (LocalDate/of 2021 11 26) (parse-date "Nov 26 2021")))
    (is (= (LocalDate/of 2022 11 18) (parse-date "Nov 18 2022")))
    (is (= (LocalDate/of 2023 1 15) (parse-date "Jan 15 2023")))
    (is (= (LocalDate/of 2020 2 29) (parse-date "Feb 29 2020"))) ; Leap year
    (is (= (LocalDate/of 2022 12 31) (parse-date "Dec 31 2022")))))

(deftest payroll-test
  (testing "pays one salaried employee at end of month by mail"
    (let [employees [{:id "emp1"
                      :schedule :monthly
                      :pay-class [:salaried 5000]
                      :disposition [:mail "name" "home"]}]
          db {:employees employees}
          tody (parse-date "Nov 30 2021")]
      (is (= [{:type :mail
               :id "emp1"
               :name "name"
               :address "home"
               :amount 5000}]
             (payroll tody db)))))

  (testing "pays one hourly employee on Friday by Direct Deposit"
    (let [employees [{:id "empid"
                      :schedule :weekly
                      :pay-class [:hourly 15]
                      :disposition [:deposit "routing" "account"]}]
          time-cards {"empid" [["Nov 12 2022" 80/10]]}
          db {:employees employees :time-cards time-cards}
          friday (parse-date "Nov 18 2022")]
      (is (= [{:type :deposit
               :id "empid"
               :rounding "routing"
                :account "account"
               :amount 120}]
             (payroll friday db)))))
  (testing "pays one commissioned employee on an even Friday by Paymaster"
    (let [employees [{:id "empid"
                      :schedule :biweekly
                      :pay-class [:commissioned 100 5/100]
                      :disposition [:paymaster "paymaster"]}]
          sales-receipts {"empid" [["Now 12 2022" 15000]]}
          db {:employees employees :sales-receipts sales-receipts}
          friday (parse-date "Nov 18 2022")]
    (is (= [{:type :paymaster
             :id "empid"
             :paymaster "paymaster"
             :amount 850}]))))
  )
