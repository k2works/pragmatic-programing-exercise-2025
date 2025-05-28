(ns gossipingBusDrivers.core
  (:require [clojure.set :as set]))

(defn make-driver [name route rumors]
  (assoc {} :name name :route (cycle route) :rumors rumors))

(defn get-stops [world]
  (loop [world world
         stops {}]
    (if (empty? world)
      stops
      (let [driver (first world)
            stop (first (:route driver))
            stops (update stops stop conj driver)]
        (recur (rest world) stops)))))

(defn merge-rumors [drivers]
  (let [rumors (map :rumors drivers)
        all-rumors (apply set/union rumors)]
    (map #(assoc % :rumors all-rumors) drivers)))

(defn drive [world]
  (let [move-drivers (->> world
                          (map (fn [driver]
                                 (let [current-route (:route driver)
                                       next-route (rest current-route)]
                                   (assoc driver :route next-route))))
                          (filter #(not-empty (:route %))))

        stops (get-stops move-drivers)

        gossip-shared-drivers (reduce (fn [drivers [_ drivers-at-stop]]
                                        (if (> (count drivers-at-stop) 1)
                                          (let [updated (merge-rumors drivers-at-stop)]
                                            (concat (remove (fn [d] (some #(= (:name d) (:name %)) drivers-at-stop))
                                                            drivers)
                                                    updated))
                                          drivers))
                                      move-drivers
                                      stops)]
    gossip-shared-drivers))