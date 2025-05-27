(ns gossipingBusDrivers.core
  (:require [clojure.set :as set]))

(defn make-driver [name route rumors]
  (assoc {} :name name :route (cycle route) :rumors rumors))

(defn drive [world]
  (->> world
       (map (fn [driver]
              (let [current-route (:route driver)
                    next-route (rest current-route)]
                (assoc driver :route next-route))))
       (filter #(not-empty (:route %)))))