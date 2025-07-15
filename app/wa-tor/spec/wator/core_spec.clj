(ns wator.core-spec
  (:require [speclj.core :refer :all]
            [wator.animal :as animal]
            [wator.core :refer :all]
            [wator.cell :as cell]
            [wator.water :as water]
            [wator.fish :as fish]
            [wator.world :as world]
            [wator.water-imp]
            [wator.fish-imp]))

(describe "Wator"
          (with-stubs)
          (context "Water"
                   (it "usually remains water"
                       (with-redefs [rand (stub :rand {:return 0.0})]
                         (let [water (water/make)
                               evolved (cell/tick water)]
                           (should= ::water/water (::cell/type evolved)))))
                   (it "occasionally evolves into a fish"
                       (with-redefs [rand (stub :rand {:return 1.0})]
                         (let [water (water/make)
                               evolved (cell/tick water)]
                           (should= ::fish/fish (::cell/type evolved))))))
          (context "world"
                   (it "creates a world full of water cells"
                       (let [world (world/make 2 2)
                             cells (:cells world)
                             positions (set (keys cells))]
                         (should= #{[0 0] [0 1]
                                    [1 0] [1 1]} positions)
                         (should (every? #(= ::water/water (::cell/type %))
                                          (vals cells))))))
          (context "animal"
                   (it "moves"
                       (let [fish (fish/make)
                             world (-> (world/make 3 3)
                                       (world/set-cell [1 1] fish))
                             [loc cell] (animal/move fish [1 1] world)]
                         (should= cell fish)
                         (should (#{[0 0] [0 1] [0 2]
                                    [1 0] [1 2]
                                    [2 0] [2 1] [2 2]} loc))))))