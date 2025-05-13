(ns app.core-test
  (:require [clojure.test :refer :all]
            [app.core :as core]))

(deftest hello-world-test
  (testing "hello-world function returns the expected greeting"
    (is (= "Hello, World!" (core/hello-world)))))