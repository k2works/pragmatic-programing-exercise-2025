(ns payroll.payroll-spec
  (:require [clojure.spec.alpha :as s]
            [speclj.core :refer :all]
            [payroll.utils :refer [parse-date]]
            [payroll.payroll :refer [payroll]])
    (:import (java.time LocalDate)))

(describe "parse-date"
          (it "correctly parses date strings"
              (should= (LocalDate/of 2021 11 30) (parse-date "Nov 30 2021"))
              (should= (LocalDate/of 2021 11 26) (parse-date "Nov 26 2021"))
              (should= (LocalDate/of 2022 11 18) (parse-date "Nov 18 2022"))
              (should= (LocalDate/of 2023 1 15) (parse-date "Jan 15 2023"))
              (should= (LocalDate/of 2020 2 29) (parse-date "Feb 29 2020")) ; Leap year
              (should= (LocalDate/of 2022 12 31) (parse-date "Dec 31 2022"))))

(describe "Payroll"
          (it "pays one salaried employee at end of month by mail"
              (let [employees [{:id "emp1"
                                :schedule :monthly
                                :pay-class [:salaried 5000]
                                :disposition [:mail "name" "home"]}]
                    db {:employees employees}
                    today (parse-date "Nov 30 2021")]
                (should (s/valid? :payroll.specs/db db))
                (let [paycheck-directives (payroll today db)]
                  (should (s/valid? :payroll.specs/paycheck-directives paycheck-directives)))
                (should= [{:type :mail
                           :id "emp1"
                           :name "name"
                           :address "home"
                           :amount 5000}]
                         (payroll today db))))
          (it "pays one hourly employee on Friday by Direct Deposit"
              (let [employees [{:id "empid"
                                :schedule :weekly
                                :pay-class [:hourly 15]
                                :disposition [:deposit "routing" "account"]}]
                    time-cards {"empid" [["Nov 12 2022" 80/10]]}
                    db {:employees employees :time-cards time-cards}
                    friday (parse-date "Nov 18 2022")]
                (should= [{:type :deposit
                           :id "empid"
                           :routing "routing"
                           :account "account"
                           :amount 120}]
                         (payroll friday db))))
          (it "pays one commissioned employee on an even Friday by Paymaster"
              (let [employees [{:id "empid"
                                :schedule :biweekly
                                :pay-class [:commissioned 100 5/100]
                                :disposition [:paymaster "paymaster"]}]
                    sales-receipts {"empid" [["Now 12 2022" 15000]]}
                    db {:employees employees :sales-receipts sales-receipts}
                    friday (parse-date "Nov 18 2022")]
                (should= [{:type :paymaster
                           :id "empid"
                           :paymaster "paymaster"
                           :amount 850}]
                         (payroll friday db))))
          )
