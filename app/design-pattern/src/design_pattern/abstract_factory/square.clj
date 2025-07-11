(ns design-pattern.abstract-factory.square
  (:require [design-pattern.abstract-factory.shape :as shape]))

(defn make [top-left side]
  {::shape/type ::square
   ::top-left top-left
   ::side side})

(defmethod shape/translate ::square [square dx dy]
  (let [[x y] (::top-left square)]
    (assoc square ::top-left [(+ x dx) (+ y dy)])))

(defmethod shape/scale ::square [square factor]
  (let [side (::side square)]
    (assoc square ::side (* side factor))))

(defmethod shape/to-string ::square [square]
  (let [[x y] (::top-left square)
        side (::side square)]
    (str "Square top-left: [" x ", " y "] side: " side)))
