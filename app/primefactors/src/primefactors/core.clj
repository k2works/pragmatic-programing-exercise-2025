(ns primefactors.core)

(defn prime-factors-of [n]
  (loop [n n divisor 2 factors []]
    (if (> n 1)
      (if (zero? (rem n divisor))
        (recur (quot n divisor) divisor (conj factors divisor))
        (recur n (inc divisor) factors))
      factors)))

(defn factors-of [n]
  (loop [factors [] n n divisor 2]
    (if (> n 1)
      (cond
        (> divisor (Math/sqrt n))
        (conj factors n)
        (= 0 (mod n divisor))
        (recur (conj factors divisor)
               (quot n divisor)
               divisor)
        :else
        (recur factors n (inc divisor)))
      factors)))

(defn is-prime? [n]
  (if (= 2 n)
    true
    (loop [candidates (range 2 (inc (Math/sqrt n)))]
      (if (empty? candidates)
        true
        (if (zero? (rem n (first candidates)))
          false
          (recur (rest candidates)))))))