(ns design-pattern.abstract-factory.shape-factory)

(defmulti make-circle
          (fn [factory center radius] (::type factory)))

(defmulti make-square
          (fn [factory top-left side] (::type factory)))
