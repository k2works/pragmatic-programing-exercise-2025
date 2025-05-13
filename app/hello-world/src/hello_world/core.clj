(ns hello-world.core)

(defn hello
  "Returns a hello world message"
  []
  "Hello, World!")

(defn -main
  "Entry point for the application"
  [& args]
  (println (hello)))