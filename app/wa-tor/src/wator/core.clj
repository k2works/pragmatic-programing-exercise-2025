(ns wator.core)

;; Wator is a population dynamics simulation devised by A. K. Dewdney
;; This is the core namespace for the Wator simulation

(defn create-world
  "Creates a new Wator world with the specified dimensions"
  [width height]
  {:width width
   :height height
   :cells (vec (repeat (* width height) nil))})

(defn get-cell
  "Gets the cell at the specified coordinates"
  [world x y]
  (let [{:keys [width cells]} world
        index (+ x (* y width))]
    (get cells index)))

(defn set-cell
  "Sets the cell at the specified coordinates"
  [world x y value]
  (let [{:keys [width cells]} world
        index (+ x (* y width))
        new-cells (assoc cells index value)]
    (assoc world :cells new-cells)))

(defn -main
  "Main entry point for the Wator simulation"
  [& args]
  (println "Starting Wator simulation..."))