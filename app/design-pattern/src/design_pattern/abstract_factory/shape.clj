(ns design-pattern.abstract-factory.shape)

(defmulti translate (fn [shape dx dy] (::type shape)))
(defmulti scale (fn [shape factor] (::type shape)))
(defmulti to-string (fn [shape] (::type shape)))
