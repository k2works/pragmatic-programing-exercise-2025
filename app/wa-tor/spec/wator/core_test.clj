(ns wator.core-test
  (:require [clojure.test :refer :all]
            [wator.core :refer :all]
            [wator.animal :as animal]
            [wator.cell :as cell]
            [wator.water :as water]
            [wator.fish :as fish]
            [wator.world :as world]
            [wator.config :as config]
            [wator.water-imp]
            [wator.fish-imp]))

(deftest water-test
  (testing "water usually remains water"
    (with-redefs [rand (constantly 0.0)]
      (let [water (water/make)
            evolved (cell/tick water)]
        (is (= ::water/water (::cell/type evolved))))))

  (testing "water occasionally evolves into a fish"
    (with-redefs [rand (constantly 1.0)]
      (let [water (water/make)
            evolved (cell/tick water)]
        (is (= ::fish/fish (::cell/type evolved)))))))

(deftest world-test
  (testing "creates a world full of water cells"
    (let [world (world/make 2 2)
          cells (:cells world)
          positions (set (keys cells))]
      (is (= #{[0 0] [0 1]
               [1 0] [1 1]} positions))
      (is (every? #(= ::water/water (::cell/type %))
                  (vals cells))))))

(deftest animal-test
  (testing "animal moves"
    (let [fish (fish/make)
          world (-> (world/make 3 3)
                    (world/set-cell [1 1] fish))
          [loc cell] (animal/move fish [1 1] world)]
      (is (= cell fish))
      (is (contains? #{[0 0] [0 1] [0 2]
                       [1 0] [1 2]
                       [2 0] [2 1] [2 2]} loc))))

  (testing "animal reproduces"
    (let [fish (fish/make)
          world (-> (world/make 3 3)
                   (world/set-cell [1 1] fish))
          result (animal/reproduce fish [1 1] world)
          [loc1 cell1 loc2 cell2] result]
      (is (= loc1 [1 1]))
      (is (fish/is? cell1))
      (is (= 0 (animal/age cell1)))
      (is (contains? #{[0 0] [0 1] [0 2]
                       [1 0] [1 2]
                       [2 0] [2 1] [2 2]}
                     loc2))
      (is (fish/is? cell2))
      (is (= 0 (animal/age cell2)))))

  (testing "animal doesn't reproduce if there is no room"
    (let [fish (-> (fish/make)
                   (animal/set-age config/fish-reproduction-age))
          world (-> (world/make 1 1)
                    (world/set-cell [0 0] fish))
          failed (animal/reproduce fish [0 0] world)]
      (is (nil? failed))))

  (testing "animal doesn't reproduce if too young"
    (let [fish (-> (fish/make)
                   (animal/set-age
                     (dec config/fish-reproduction-age)))
          world (-> (world/make 3 3)
                    (world/set-cell [1 1] fish))
          failed (animal/reproduce fish [1 1] world)]
      (is (nil? failed)))))
