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
                         (payroll tody db)))))