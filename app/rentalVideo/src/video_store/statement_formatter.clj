(ns video-store.statement-formatter)

(defmulti format-rental-statement
          (fn [formatter statement-data]
            (:type formatter)))
