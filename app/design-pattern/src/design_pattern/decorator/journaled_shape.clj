(ns design-pattern.decorator.journaled-shape
  (:require [clojure.spec.alpha :as s]
            [design-pattern.composite.shape.shape :as shape]))

(s/def ::journal-entry
  (s/or :translate (s/tuple #{:translate} number? number?)
        :scale (s/tuple #{:scale} number?)))
(s/def ::journal (s/coll-of ::journal-entry))
(s/def ::shape ::shape/shape-type)
(s/def ::journaled-shape (s/and
                         (s/keys :req [::shape/type
                                       ::journal
                                       ::shape])
                         #(= ::journal-shape
                             (::shape/type %))))

(defn make [shape]
  {:post [(s/valid? ::journaled-shape %)]}
  {::shape/type ::journal-shape
   ::journal []
   ::shape shape})

(defmethod shape/translate ::journal-shape [js dx dy]
  {:pre [(s/valid? ::journaled-shape js)
         (number? dx) (number? dy)]
   :post [(s/valid? ::journaled-shape %)]}
  (-> js (update ::journal conj [:translate dx dy])
      (assoc ::shape (shape/translate (::shape js) dx dy))))

(defmethod shape/scale ::journal-shape [js factor]
  {:pre [(s/valid? ::journaled-shape js)
         (number? factor)]
   :post [(s/valid? ::journaled-shape %)]}
  (-> js (update ::journal conj [:scale factor])
      (assoc ::shape (shape/scale (::shape js) factor))))
