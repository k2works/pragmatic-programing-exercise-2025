(ns design-pattern.visitor.json-shape-visitor
  (:require (design-pattern.visitor
              [shape :as shape])))

(defmulti to-json ::shape/type)
