(ns video-store.order-processing
  (:require [video_store.statement-formatter :refer :all]
            [video_store.statement-policy :refer :all]))

(defn process-order [policy formatter order]
  (->> order
       (make-statement-data policy)
       (format-rental-statement formatter)))
