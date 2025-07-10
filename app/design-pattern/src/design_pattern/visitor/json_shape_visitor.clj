(ns design-pattern.visitor.json-shape-visitor
  (:require [design-pattern.visitor
             [shape :as shape]
             [circle :as circle]
             [square :as square]]))

(defmulti to-json ::shape/type)

(defmethod to-json ::square/square [square]
  (let [{:keys [::square/top-left ::square/side]} square
        [x y] top-left]
    (format "{\"top-left\":[%s,%s],\"side\": %s}" x y side)))

(defmethod to-json ::circle/circle [circle]
  (let [{:keys [::circle/center ::circle/radius]} circle
        [x y] center]
    (format "{\"center\":[%s,%s],\"radius\": %s}" x y radius)))
