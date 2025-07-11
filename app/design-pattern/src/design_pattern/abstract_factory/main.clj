(ns design-pattern.abstract-factory.main
  (:require [design-pattern.abstract-factory.shape-factory-implementation :as imp]))

(def shape-factory (atom nil))

(defn init []
  (reset! shape-factory (imp/make)))
