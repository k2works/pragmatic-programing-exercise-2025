(ns design-pattern.composite.shape.core-spec
  (:require [speclj.core :refer :all]
            [design-pattern.composite.shape
             [square :as square]
             [shape :as shape]
             [circle :as circle]
             [composite-shape :as cs]]))


(describe "square"
          (it "translates"
              (let [s (square/make-square [3 4] 1)
                    translated-square (shape/translate s 1 1)]
                (should= [4 5] (::square/top-left translated-square))
                (should= 1 (::square/side translated-square))))
          (it "scales"
              (let [s (square/make-square [1 2] 2)
                    scaled-square (shape/scale s 5)]
                (should= [1 2] (::square/top-left scaled-square))
                (should= 10 (::square/side scaled-square)))))

(describe "circle"
          (it "translates"
              (let [c (circle/make-circle [3 4] 10)
                    translated-circle (shape/translate c 2 3)]
                (should= [5 7] (::circle/center translated-circle))
                (should= 10 (::circle/radius translated-circle))))
          (it "scales"
              (let [c (circle/make-circle [1 2] 2)
                    scaled-circle (shape/scale c 5)]
                (should= [1 2] (::circle/center scaled-circle))
                (should= 10 (::circle/radius scaled-circle)))))
