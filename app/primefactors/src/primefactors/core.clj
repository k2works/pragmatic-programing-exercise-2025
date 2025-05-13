(ns primefactors.core)

(defn prime-factors
  "Returns a sequence of prime factors of n in ascending order."
  [n]
  (loop [factors []
         n n
         divisor 2]
    (cond
      (> divisor n) factors
      (zero? (mod n divisor)) (recur (conj factors divisor) (/ n divisor) divisor)
      :else (recur factors n (inc divisor)))))