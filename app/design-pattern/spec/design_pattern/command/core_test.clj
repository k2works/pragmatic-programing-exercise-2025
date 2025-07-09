(ns design-pattern.command.core-test
  (:require [clojure.test :refer :all]
            [design-pattern.command.core :refer :all]))

(deftest command-test
  (testing "executes the command"
    (let [execute-called (atom false)]
      (with-redefs [execute (fn [] (reset! execute-called true))]
        (some-app execute)
        (is @execute-called "execute should have been called")))))

(deftest command-with-argument-test
  (testing "executes the command with an argument"
    (let [execute-arg (atom nil)]
      (with-redefs [execute (fn [arg] (reset! execute-arg arg))]
        (some-app (partial execute :the-argument))
        (is (= :the-argument @execute-arg) "execute should have been called with :the-argument")))))