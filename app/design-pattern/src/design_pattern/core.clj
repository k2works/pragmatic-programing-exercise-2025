(ns design-pattern.core)

;; Core functionality for design patterns

(defn hello
  "A simple function to verify the project is working"
  []
  (println "Hello from Design Patterns in Clojure!"))

;; This namespace will serve as the entry point for the design patterns project.
;; Each design pattern will be implemented in its own namespace.

;; Example of how to use this project:
;; (require '[design-pattern.core :as core])
;; (core/hello)
;;
;; For specific patterns:
;; (require '[design-pattern.strategy :as strategy])
;; (strategy/execute-strategy ...)