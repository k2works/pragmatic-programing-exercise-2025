(ns video-store.html-statement-formatter
  (:require [video-store.statement-formatter :refer :all]))

(defn make-html-formatter [] {:type ::html})

(defmethod format-rental-statement ::html
  [formatter statement-data]
  (let [customer-name (:customer-name statement-data)
        movies (:movies statement-data)
        owed (:owed statement-data)
        points (:points statement-data)]
    (str
      (format "<h1>Rental Record for %s</h1>\n" customer-name)
      "<table>"
      (apply str
             (for [movie movies]
               (format "<tr><td>%s</td><td>%.1f</td></tr>\n"
                       (:title movie)
                       (:price movie))))
      "</table>"
      (format "<p>You owed %.1f</p>\n" owed)
      (format "<p>You earned <b>%d</b> frequent renter points</p>\n"
              points))))
