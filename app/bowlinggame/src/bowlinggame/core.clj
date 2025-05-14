(ns bowlinggame.core)

(defn new-game
  "Creates a new bowling game with empty rolls."
  []
  {:rolls []})

(defn roll
  "Records a roll in the game, adding the number of pins knocked down."
  [game pins]
  (update game :rolls conj pins))

(defn- is-spare?
  "Checks if the frame is a spare."
  [rolls frame-index]
  (= 10 (+ (nth rolls frame-index)
           (nth rolls (inc frame-index)))))

(defn- is-strike?
  "Checks if the frame is a strike."
  [rolls frame-index]
  (= 10 (nth rolls frame-index)))

(defn- spare-bonus
  "Returns the bonus for a spare."
  [rolls frame-index]
  (nth rolls (+ frame-index 2)))

(defn- strike-bonus
  "Returns the bonus for a strike."
  [rolls frame-index]
  (+ (nth rolls (inc frame-index))
     (nth rolls (+ frame-index 2))))

(defn- score-frame
  "Calculates the score for a single frame."
  [rolls frame-index]
  (cond
    (is-strike? rolls frame-index)
    (+ 10 (strike-bonus rolls frame-index))
    
    (is-spare? rolls frame-index)
    (+ 10 (spare-bonus rolls frame-index))
    
    :else
    (+ (nth rolls frame-index)
       (nth rolls (inc frame-index)))))

(defn score
  "Calculates the total score for a bowling game."
  [game]
  (let [rolls (:rolls game)]
    (loop [frame 0
           frame-index 0
           total-score 0]
      (if (>= frame 10)
        total-score
        (let [frame-score (score-frame rolls frame-index)
              next-frame-index (if (is-strike? rolls frame-index)
                                 (inc frame-index)
                                 (+ frame-index 2))]
          (recur (inc frame)
                 next-frame-index
                 (+ total-score frame-score)))))))