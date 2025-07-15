(ns wator.fish-imp
  (:require [wator.cell :as cell]
            [wator.animal :as animal]))

(defmethod cell/tick :wator.fish/fish [fish]
  (animal/tick fish))

(defmethod animal/move :wator.fish/fish [fish loc world]
  (animal/do-move fish loc world))

(defmethod animal/reproduce :wator.fish/fish [fish]
  )