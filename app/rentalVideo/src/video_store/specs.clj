(ns video-store.specs
  (:require [clojure.spec.alpha :as s]
            [clojure.spec.gen.alpha :as gen]
            [video-store.normal-statement-policy :refer [make-normal-policy]]
            [video-store.buy-two-get-one-free-policy :refer [make-buy-two-get-one-free-policy]]))

(s/def ::name string?)
(s/def ::customer (s/keys :req-un [::name]))
(s/def ::title string?)
(s/def ::type #{:regular :childrens :new-release})
(s/def ::days pos-int?)
(s/def ::movie (s/keys :req-un [::title ::type]))
(s/def ::rental (s/keys :req-un [::days ::movie]))
(s/def ::rentals (s/coll-of ::rental))
(s/def ::rental-order (s/keys :req-un [::customer ::rentals]))
(s/def ::customer-name string?)
(s/def ::price pos?)
(s/def ::owed pos?)
(s/def ::points pos-int?)
(s/def ::statement-data (s/keys :req-un [::customer-name
                                         ::movies
                                         ::owed
                                         ::points]))
(def gen-customer-name
  (gen/such-that not-empty (gen/string-alphanumeric) 100))

(def gen-customer
  (gen/fmap (fn [name] {:name name}) gen-customer-name))

(def gen-days (gen/elements (range 1 100)))

(def gen-movie-type
  (gen/elements [:regular :childrens :new-release]))

(def gen-movie
  (gen/fmap (fn [[title type]] {:title title :type type})
            (gen/tuple (gen/string-alphanumeric) gen-movie-type)))

(def gen-rental
  (gen/fmap (fn [[movie days]] {:movie movie :days days})
            (gen/tuple gen-movie gen-days)))

(def gen-rentals
  (gen/such-that not-empty (gen/vector gen-rental)))

(def gen-rental-order
  (gen/fmap (fn [[customer rentals]]
             {:customer customer :rentals rentals})
           (gen/tuple gen-customer gen-rentals)))

(def gen-policy (gen/elements
                  [(make-normal-policy)
                   (make-buy-two-get-one-free-policy)]))
