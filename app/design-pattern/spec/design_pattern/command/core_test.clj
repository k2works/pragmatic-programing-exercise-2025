(ns design-pattern.command.core-test
  (:require [clojure.test :refer :all]
            [design-pattern.command.core :refer :all]
            [design-pattern.command.add-room-command :as ar]))

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

(deftest gui-app-test
  (testing "executes the command and undoes it"
    (let [add-room-called (atom false)
          delete-room-called (atom false)
          test-room :a-room]
      (with-redefs [ar/add-room (fn [] (reset! add-room-called true) test-room)
                    ar/delete-room (fn [room] (reset! delete-room-called true) (is (= test-room room)))]
        (gui-app [:add-room-action :undo-action])
        (is @add-room-called "add-room should have been called")
        (is @delete-room-called "delete-room should have been called")))))
