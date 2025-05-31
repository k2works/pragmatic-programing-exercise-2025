(ns payroll.core-spec
    (:require [speclj.core :refer :all]
      [payroll.core :refer :all]))

(describe "Payroll"
          (it "pays one salaried employee at end of month by mail"
              (let [employees [{:id "emp1"
                                :schedule :monthly
                                :pay-class [:salaried 5000]
                                :disposition [:mail "name" "home"]}]
                    db {:employees employees}
                    tody (parse-date "Nov 30 2021")]
                (should= [{:type :mail
                           :id "emp1"
                           :name "name"
                           :address "home"
                           :amount 5000}]
                         (payroll tody db))))
          (it "pays one hourly employee on Friday by Direct Deposit"
              (let [employees [{:id "empid"
                                :schedule :weekly
                                :pay-class [:hourly 15]
                                :disposition [:deposit "routing" "account"]}]
                    time-cards {"empid" [["Nov 12 2022" 80/10]]}
                    db {:employees employees :time-cards time-cards}
                    friday (parse-date "Nov 26 2021")]
                (should= [{:type :direct-deposit
                           :id "emp2"
                           :name "name"
                           :address "bank-account"
                           :amount 20}]
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