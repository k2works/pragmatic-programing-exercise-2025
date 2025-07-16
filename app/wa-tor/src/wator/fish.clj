(ns wator.fish
  (:require [clojure.spec.alpha :as s]
            [wator.cell :as cell]
            [wator.animal :as animal]))

(s/def ::fish (s/and #(= :wator.fish/fish (::cell/type %)) ::animal/animal))

(defn is? [cell]
  (= :wator.fish/fish (::cell/type cell)))

(defn make []
  {:post [s/valid? ::fish %]}
  (merge {::cell/type :wator.fish/fish}
         (animal/make)))

(defmethod animal/make-child :wator.fish/fish [fish]
  (make))
