(ns payroll.specs
  (:require [clojure.spec.alpha :as s]))

;; Database specs
(s/def ::id integer?)
(s/def ::name string?)
(s/def ::employees (s/coll-of ::employee))
(s/def ::time-cards (s/map-of ::id (s/coll-of (s/tuple any? number?))))
(s/def ::sales-receipts (s/map-of ::id (s/coll-of (s/tuple any? number?))))
(s/def ::db (s/keys :req-un [::employees]
                    :opt-un [::time-cards ::sales-receipts]))

;; Employee specs
(s/def ::salaried-pay-class (s/tuple #{:salaried} number?))
(s/def ::hourly-pay-class (s/tuple #{:hourly} number?))
(s/def ::commissioned-pay-class (s/tuple #{:commissioned} number? number?))
(s/def ::pay-class (s/or :salaried ::salaried-pay-class
                         :hourly ::hourly-pay-class
                         :commissioned ::commissioned-pay-class))

(s/def ::schedule #{:monthly :weekly :biweekly})

(s/def ::mail-disposition (s/tuple #{:mail} string? string?))
(s/def ::deposit-disposition (s/tuple #{:deposit} string? string?))
(s/def ::paymaster-disposition (s/tuple #{:paymaster} string?))
(s/def ::disposition (s/or :mail ::mail-disposition
                           :deposit ::deposit-disposition
                           :paymaster ::paymaster-disposition))

(s/def ::employee (s/keys :req-un [::id ::name ::pay-class ::schedule ::disposition]
                          :opt-un [::db]))

;; Paycheck specs
(s/def ::amount number?)
(s/def ::type #{:mail :deposit :paymaster})
(s/def ::address string?)
(s/def ::routing string?)
(s/def ::account string?)
(s/def ::paymaster string?)

(s/def ::mail-paycheck (s/keys :req-un [::type ::id ::name ::address ::amount]))
(s/def ::deposit-paycheck (s/keys :req-un [::type ::id ::routing ::account ::amount]))
(s/def ::paymaster-paycheck (s/keys :req-un [::type ::id ::paymaster ::amount]))
(s/def ::paycheck (s/or :mail ::mail-paycheck
                        :deposit ::deposit-paycheck
                        :paymaster ::paymaster-paycheck))

(s/def ::paycheck-directive (s/keys :req-un [::id ::amount ::disposition]))