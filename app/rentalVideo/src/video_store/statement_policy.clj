(ns video-store.statement-policy)

(defn- policy-movie-dispatch [policy rental]
  [(:type policy) (-> rental :movie :type)])

(defmulti determine-amount policy-movie-dispatch)
(defmulti determine-points policy-movie-dispatch)
(defmulti total-amount (fn [policy _rentals] (:type policy)))
(defmulti total-points (fn [policy _rentals] (:type policy)))

(defmethod total-amount nil [_policy _rentals] 0)
(defmethod total-points nil [_policy _rentals] 0)

(defn make-default-policy [] {:type :default})

(defmethod determine-amount [:default :regular] [_policy rental]
  (let [days (:days rental)]
    (if (> days 2)
      (+ 2.0 (* (- days 2) 1.5))
      2.0)))

(defmethod determine-amount [:default :childrens] [_policy rental]
  (let [days (:days rental)]
    (if (> days 3)
      (+ 1.5 (* (- days 3) 1.5))
      1.5)))

(defmethod determine-amount [:default :new-release] [_policy rental]
  (* 3.0 (:days rental)))

(defmethod determine-amount [:default nil] [_policy _rental] 0)

(defmethod determine-points [:default :regular] [_policy _rental] 1)

(defmethod determine-points [:default :childrens] [_policy _rental] 1)

(defmethod determine-points [:default :new-release] [_policy rental]
  (if (> (:days rental) 1) 2 1))

(defmethod determine-points [:default nil] [_policy _rental] 0)

(defmethod total-amount :default [policy rentals]
  (reduce + (map #(determine-amount policy %) rentals)))

(defmethod total-points :default [policy rentals]
  (reduce + (map #(determine-points policy %) rentals)))

(defn make-statement-data
  ([arg] 
   (if (map? arg)
     (if (:type arg)
       (make-statement-data arg {})
       (make-statement-data (make-default-policy) arg))))
  ([policy rental-order]
   (let [{:keys [name]} (:customer rental-order)
         {:keys [rentals]} rental-order
         rentals (or rentals [])]
     {:customer-name name
      :movies (vec (for [rental rentals]
                {:title (:title (:movie rental))
                 :price (determine-amount policy rental)}))
      :owed (total-amount policy rentals)
      :points (total-points policy rentals)})))
