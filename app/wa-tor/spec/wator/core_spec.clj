(ns wator.core-spec
  (:require [speclj.core :refer :all]
            [wator.animal :as animal]
            [wator.core :refer :all]
            [wator.cell :as cell]
            [wator.water :as water]
            [wator.fish :as fish]
            [wator.world :as world]
            [wator.config :as config]
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
                                    [2 0] [2 1] [2 2]} loc))))
                   (it "reproduces"
                       (let [fish (fish/make)
                             world (-> (world/make 3 3)
                                      (world/set-cell [1 1] fish))
                             result (animal/reproduce fish [1 1] world)
                             _ (println "[DEBUG_LOG] Result of animal/reproduce:" result)
                             [loc1 cell1 loc2 cell2] (if (nil? result) 
                                                      (do 
                                                        (println "[DEBUG_LOG] Result is nil, using default values")
                                                        [[1 1] nil nil nil])
                                                      result)
                             _ (println "[DEBUG_LOG] loc1:" loc1)
                             _ (println "[DEBUG_LOG] cell1:" cell1)
                             _ (println "[DEBUG_LOG] loc2:" loc2)
                             _ (println "[DEBUG_LOG] cell2:" cell2)]
                         (should= loc1 [1 1])
                         (should (fish/is? cell1))
                         (should= 0 (animal/age cell1))
                         (should (#{[0 0] [0 1] [0 2]
                                    [1 0] [1 2]
                                    [2 0] [2 1] [2 2]}
                                  loc2))
                         (should (fish/is? cell2))
                         (should= 0 (animal/age cell2))))
                   (it "doesn't reproduce if there is no room"
                       (let [fish (-> (fish/make)
                                      (animal/set-age config/fish-reproduction-age))
                             world (-> (world/make 1 1)
                                       (world/set-cell [0 0] fish))
                             failed (animal/reproduce fish [0 0] world)]
                         (should-be-nil failed)))
                   (it "doesn't reproduce if too young"
                       (let [fish (-> (fish/make)
                                      (animal/set-age
                                        (dec config/fish-reproduction-age)))
                             world (-> (world/make 3 3)
                                       (world/set-cell [1 1] fish))
                             failed (animal/reproduce fish [1 1] world)]
                         (should-be-nil failed)))))
