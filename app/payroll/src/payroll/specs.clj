(ns payroll.specs
  (:require [clojure.spec.alpha :as s]))

;; Database specs
(s/def ::id string?)
(s/def ::name string?)
(s/def ::employees (s/coll-of ::employee))
(s/def ::date string?)
(s/def ::time-cards (s/tuple ::date pos?))
(s/def ::time-cards (s/map-of ::id (s/coll-of ::sales-receipt)))
(s/def ::sales-receipt (s/tuple pos?))
(s/def ::sales-receipts (s/map-of ::id (s/coll-of ::sales-receipt)))
(s/def ::db (s/keys :req-un [::employees]
                    :opt-un [::time-cards ::sales-receipts]))

;; Employee specs
(s/def ::salaried-pay-class (s/tuple #{:salaried} pos?))
(s/def ::hourly-pay-class (s/tuple #{:hourly} pos?))
(s/def ::commissioned-pay-class (s/tuple #{:commissioned} pos? pos?))
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

(s/def ::employee (s/keys :req-un [::id ::schedule ::pay-class ::disposition]
                          :opt-un [::db]))

;; Paycheck specs
(s/def ::type #{:mail :deposit :paymaster})
(s/def ::amount pos?)
(s/def ::name string?)
(s/def ::address string?)
(s/def ::mail-directive (s/and #(= (:type %):mail)
                               (s/keys :req-un [::id
                                                ::name
                                                ::address
                                                ::amount []])))
(s/def ::routing string?)
(s/def ::account string?)
(s/def ::deposit-directive (s/and #(= (:type %) :deposit)
                                  (s/keys :req-un [::id
                                                   ::routing
                                                   ::account
                                                   ::amount []])))
(s/def ::paymaster string?)
(s/def ::paymaster-directive (s/and #(= (:type %) :paymaster)
                                  (s/keys :req-un [::id
                                                   ::paymaster
                                                   ::amount []])))

(s/def ::mail-paycheck (s/keys :req-un [::type ::id ::name ::address ::amount]))
(s/def ::deposit-paycheck (s/keys :req-un [::type ::id ::routing ::account ::amount]))
(s/def ::paymaster-paycheck (s/keys :req-un [::type ::id ::paymaster ::amount]))
(s/def ::paycheck (s/or :mail ::mail-paycheck
                        :deposit ::deposit-paycheck
                        :paymaster ::paymaster-paycheck))
(s/def ::paycheck-directives (s/coll-of ::paycheck))