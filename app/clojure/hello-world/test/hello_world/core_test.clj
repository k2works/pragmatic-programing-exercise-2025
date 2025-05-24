(ns hello-world.core-test
  (:require [clojure.test :refer :all]
            [hello-world.core :as core]))

(deftest hello-test
  (testing "Hello function returns the correct greeting"
    (is (= "Hello, World!" (core/hello)))))