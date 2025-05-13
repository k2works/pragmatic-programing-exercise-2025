(ns app.core)

(defn hello-world
  "Returns a hello world message"
  []
  "Hello, World!")

(defn -main
  "Application entry point"
  [& args]
  (println (hello-world)))