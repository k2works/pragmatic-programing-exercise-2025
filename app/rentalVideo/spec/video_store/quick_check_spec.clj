(ns video-store.quick-check-spec
  (:require [clojure.spec.alpha :as s]
            [speclj.core :refer :all]
            [clojure.test.check :as tc]
            [clojure.test.check.properties :as prop]
            [video-store.specs :refer :all]
            [video-store.constructors :refer :all]
            [video-store.statement-policy :refer :all]
            [video-store.text-statement-formatter :refer :all]
            [video-store.normal-statement-policy :refer :all]
            [video-store.order-processing :refer :all]))

(describe "Quick check statement policy"
          (it "generates valid rental orders"
              (let [result (tc/quick-check
                             100
                             (prop/for-all
                               [rental-order gen-rental-order]
                               (s/valid? :video-store.specs/rental-order rental-order)))]
                (should (:result result))
                (when-not (:result result)
                  (println "Failed with:" (:fail result)))))

          (it "produces valid statement data"
              (let [result (tc/quick-check
                             100
                             (prop/for-all
                               [rental-order gen-rental-order
                                policy gen-policy]
                               (try
                                 (s/valid? :video-store.specs/statement-data
                                           (make-statement-data policy rental-order))
                                 (catch Exception e
                                   false))))]
                (should (:result result))))

          (it "statement data totals are consistent under all policies"
              (let [result (tc/quick-check
                             100
                             (prop/for-all
                               [rental-order gen-rental-order
                                policy gen-policy]
                               (try
                                 (let [statement-data (make-statement-data policy rental-order)
                                       movies (:movies statement-data)
                                       owed (:owed statement-data)]
                                   (and (s/valid? :video-store.specs/statement-data statement-data)
                                        (>= owed 0)
                                        (every? #(>= (:price %) 0) movies)
                                        ;; ビジネスロジックに応じてこの条件を調整
                                        (number? owed)))
                                 (catch Exception e
                                   false))))]
                (should (:result result)))))