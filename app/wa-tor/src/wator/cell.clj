(ns wator.cell)
(defmulti tick (fn [cell & _] (::type cell)))

