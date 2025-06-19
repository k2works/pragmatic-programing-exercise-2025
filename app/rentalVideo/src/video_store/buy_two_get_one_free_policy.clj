(ns video-store.buy-two-get-one-free-policy
  (:require [video-store.statement-policy :refer :all]
            [video-store.normal-statement-policy :refer :all]))

(derive ::buy-two-get-one-free ::normal)

(defn make-buy-two-get-one-free-policy []
  {:type ::buy-two-get-one-free})

(defmethod determine-amount
  [::buy-two-get-one-free :regular]
  [_policy rental]
  (let [days (:days rental)]
    (if (> days 2)
      (+ 2.0 (* (- days 2) 1.5))
      2.0)))

(defmethod determine-amount
  [::buy-two-get-one-free :childrens]
  [_policy rental]
  (let [days (:days rental)]
    (if (> days 3)
      (+ 1.5 (* (- days 3) 1.5))
      1.5)))

(defmethod determine-amount
  [::buy-two-get-one-free :new-release]
  [_policy rental]
  (* 3.0 (:days rental)))

(defmethod total-amount
  ::buy-two-get-one-free
  [policy rentals]
  (let [amounts (map #(determine-amount policy %) rentals)]
       (if (> (count amounts) 2)
         (reduce + (drop 1 (sort amounts)))
         (reduce + amounts))))

(defmethod determine-points
  [::buy-two-get-one-free :regular]
  [_policy _rental]
  1)

(defmethod determine-points
  [::buy-two-get-one-free :childrens]
  [_policy _rental]
  1)

(defmethod determine-points
  [::buy-two-get-one-free :new-release]
  [_policy rental]
  (if (> (:days rental) 1) 2 1))

(defmethod determine-points
  [::buy-two-get-one-free nil]
  [_policy _rental]
  0)

(defmethod total-points
  ::buy-two-get-one-free
  [policy rentals]
  (reduce + (map #(determine-points policy %) rentals)))
