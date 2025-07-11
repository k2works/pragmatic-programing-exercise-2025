(ns design-pattern.abstract-factory.shape-factory)

(defmulti make (fn [factory type & args] (::type factory)))

