(ns design-pattern.abstract-server)

;; Helper functions for light operations
(defn turn-on-light []
  ;turn on the bloody light!
  )

(defn turn-off-light []
  ;Criminy! just turn it off!
  )

;; Define the SwitchStrategy protocol
(defprotocol SwitchStrategy
  (turn-on [this switchable] "Turn on the switchable object")
  (turn-off [this switchable] "Turn off the switchable object"))

;; Define the LightStrategy record that implements SwitchStrategy
(defrecord LightStrategy []
  SwitchStrategy
  (turn-on [_ switchable]
    (turn-on-light))
  (turn-off [_ switchable]
    (turn-off-light)))

;; For backward compatibility with existing code
(defmulti legacy-turn-on :type)
(defmulti legacy-turn-off :type)

(defmethod legacy-turn-on :light [switchable]
  (turn-on (->LightStrategy) switchable))

(defmethod legacy-turn-off :light [switchable]
  (turn-off (->LightStrategy) switchable))

;; Function to create a strategy based on switchable type
(defn create-strategy [switchable]
  (case (:type switchable)
    :light (->LightStrategy)
    nil))

;; Main function to engage the switch
(defn engage-switch [switchable]
  ;Some other stuff...
  (let [strategy (create-strategy switchable)]
    (if strategy
      (do
        (turn-on strategy switchable)
        ;Some more other stuff...
        (turn-off strategy switchable))
      (do
        (legacy-turn-on switchable)
        ;Some more other stuff...
        (legacy-turn-off switchable))))
  )
