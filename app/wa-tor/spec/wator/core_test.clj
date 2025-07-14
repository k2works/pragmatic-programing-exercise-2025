(ns wator.core-test
  (:require [clojure.test :refer :all]
            [wator.core :refer :all]))

(deftest create-world-test
  (testing "Creating a world with specified dimensions"
    (let [world (create-world 10 10)]
      (is (= 10 (:width world)))
      (is (= 10 (:height world)))
      (is (= 100 (count (:cells world)))))))

(deftest get-cell-test
  (testing "Getting a cell at specified coordinates"
    (let [world (create-world 5 5)
          world-with-cell (set-cell world 2 3 :fish)]
      (is (= :fish (get-cell world-with-cell 2 3)))
      (is (nil? (get-cell world-with-cell 0 0))))))

(deftest set-cell-test
  (testing "Setting a cell at specified coordinates"
    (let [world (create-world 5 5)
          world-with-fish (set-cell world 1 2 :fish)
          world-with-shark (set-cell world-with-fish 3 4 :shark)]
      (is (= :fish (get-cell world-with-fish 1 2)))
      (is (= :shark (get-cell world-with-shark 3 4))))))