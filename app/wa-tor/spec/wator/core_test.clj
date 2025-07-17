(ns wator.core-test
  (:require [clojure.test :refer :all]
            [wator.core :refer :all]
            [wator.animal :as animal]
            [wator.cell :as cell]
            [wator.water :as water]
            [wator.fish :as fish]
            [wator.shark :as shark]
            [wator.world :as world]
            [wator.config :as config]
            [wator.water-imp]
            [wator.fish-imp]
            [wator.world-imp]))

(deftest water-test
  (testing "water usually remains water"
    (with-redefs [rand (constantly 0.0)]
      (let [water (water/make)
            world (world/make 1 1)
            [from to] (cell/tick water [0 0] world)]
        (is (nil? from))
        (is (water/is? (get to [0 0]))))))

  (testing "water occasionally evolves into a fish"
    (with-redefs [rand (constantly 1.0)]
      (let [water (water/make)
            world (world/make 1 1)
            [from to] (cell/tick water [0 0] world)]
        (is (nil? from))
        (is (fish/is? (get to [0 0])))))))

(deftest world-test
  (testing "creates a world full of water cells"
    (let [world (world/make 2 2)
          cells (::world/cells world)
          positions (set (keys cells))]
      (is (= #{[0 0] [0 1]
               [1 0] [1 1]} positions))
      (is (every? #(= ::water/water (::cell/type %))
                  (vals cells)))))
                  
  (testing "makes neighbors"
    (let [world (world/make 5 5)]
      (is (= [[0 0] [0 1] [0 2]
              [1 0] [1 2]
              [2 0] [2 1] [2 2]]
             (world/neighbors world [1 1])))
      (is (= [[4 4] [4 0] [4 1]
              [0 4] [0 1]
              [1 4] [1 0] [1 1]]
             (world/neighbors world [0 0])))
      (is (= [[3 3] [3 4] [3 0]
              [4 3] [4 0]
              [0 3] [0 4] [0 0]]
             (world/neighbors world [4 4]))))))

(deftest animal-test
  (testing "animal moves"
    (doseq [scenario [{:constructor fish/make :tester fish/is?}
                      {:constructor shark/make :tester shark/is?}]]
      (let [animal ((:constructor scenario))
            world (-> (world/make 3 3)
                      (world/set-cell [1 1] animal))
            [from to] (animal/move animal [1 1] world)
            loc (first (keys to))]
        (is (water/is? (get from [1 1])))
        (is ((:tester scenario) (get to loc)))
        (is (contains? #{[0 0] [0 1] [0 2]
                         [1 0] [1 2]
                         [2 0] [2 1] [2 2]} loc)))))
                       
  (testing "doesn't move if there are no space"
    (doseq [scenario [{:constructor fish/make :tester fish/is?}
                      {:constructor shark/make :tester shark/is?}]]
      (let [animal ((:constructor scenario))
            world (-> (world/make 1 1)
                      (world/set-cell [0 0] animal))
            [from to] (animal/move animal [0 0] world)]
        (is ((:tester scenario) (get to [0 0])))
        (is (nil? from)))))

  (testing "animal reproduces"
    (doseq [scenario [{:constructor fish/make :tester fish/is?}
                      {:constructor shark/make :tester shark/is?}]]
      (let [animal ((:constructor scenario))
            reproduction-age (animal/get-reproduction-age animal)
            animal (animal/set-age animal reproduction-age)
            world (-> (world/make 3 3)
                     (world/set-cell [1 1] animal))
            [from to] (animal/reproduce animal [1 1] world)
            from-loc (-> from keys first)
            from-cell (-> from vals first)
            to-loc (-> to keys first)
            to-cell (-> to vals first)]
        (is (= from-loc [1 1]))
        (is ((:tester scenario) from-cell))
        (is (= 0 (animal/age from-cell)))
        (is (contains? #{[0 0] [0 1] [0 2]
                         [1 0] [1 2]
                         [2 0] [2 1] [2 2]}
                       to-loc))
        (is ((:tester scenario) to-cell))
        (is (= 0 (animal/age to-cell))))))

  (testing "animal doesn't reproduce if there is no room"
    (doseq [scenario [{:constructor fish/make :tester fish/is?}
                      {:constructor shark/make :tester shark/is?}]]
      (let [animal ((:constructor scenario))
            reproduction-age (animal/get-reproduction-age animal)
            animal (animal/set-age animal reproduction-age)
            world (-> (world/make 1 1)
                      (world/set-cell [0 0] animal))
            failed (animal/reproduce animal [0 0] world)]
        (is (nil? failed)))))

  (testing "animal doesn't reproduce if too young"
    (doseq [scenario [{:constructor fish/make :tester fish/is?}
                      {:constructor shark/make :tester shark/is?}]]
      (let [animal ((:constructor scenario))
            reproduction-age (animal/get-reproduction-age animal)
            animal (animal/set-age animal (dec reproduction-age))
            world (-> (world/make 3 3)
                      (world/set-cell [1 1] animal))
            failed (animal/reproduce animal [1 1] world)]
        (is (nil? failed)))))
      
  (testing "moves a fish around each tick"
    (let [fish (fish/make)
          small-world (-> (world/make 1 2)
                          (world/set-cell [0 0] fish)
                          (world/tick))
          vacated-cell (world/get-cell small-world [0 0])
          occupied-cell (world/get-cell small-world [0 1])]
      (is (water/is? vacated-cell))
      (is (fish/is? occupied-cell))
      (is (= 1 (animal/age occupied-cell)))))
      
  (testing "moves a fish around each tick with multiple scenarios"
    (doseq [scenario
            [{:dimension [2 1] :starting [0 0] :ending [1 0]}
             {:dimension [2 1] :starting [1 0] :ending [0 0]}
             {:dimension [1 2] :starting [0 0] :ending [0 1]}
             {:dimension [1 2] :starting [0 1] :ending [0 0]}]]
      (let [fish (fish/make)
            {:keys [dimension starting ending]} scenario
            [h w] dimension
            small-world (-> (world/make h w)
                            (world/set-cell starting fish)
                            (world/tick))
            vacated-cell (world/get-cell small-world starting)
            occupied-cell (world/get-cell small-world ending)]
        (is (water/is? vacated-cell))
        (is (fish/is? occupied-cell))
        (is (= 1 (animal/age occupied-cell))))))
        
  (testing "move two fish who compete for the same spot"
    (let [fish (fish/make)
          competitive-world (-> (world/make 3 1)
                                (world/set-cell [0 0] fish)
                                (world/set-cell [2 0] fish)
                                (world/tick))
          start-00 (world/get-cell competitive-world [0 0])
          start-20 (world/get-cell competitive-world [2 0])
          end-10 (world/get-cell competitive-world [1 0])]
      (is (fish/is? end-10))
      (is (or (fish/is? start-00)
              (fish/is? start-20)))
      (is (or (water/is? start-00)
              (water/is? start-20)))))
              
  (testing "fills the world with reproducing fish"
    (loop [world (-> (world/make 10 10)
                     (world/set-cell [5 5] (fish/make)))
           n 100]
      (if (zero? n)
        (let [cells (-> world ::world/cells vals)
              fishies (filter fish/is? cells)
              fish-count (count fishies)]
          (is (< 50 fish-count)))
        (recur (world/tick world) (dec n))))))
