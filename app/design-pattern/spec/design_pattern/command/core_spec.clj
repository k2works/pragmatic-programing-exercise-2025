(ns design-pattern.command.core-spec
  (:require [speclj.core :refer :all]
            [design-pattern.command.core :refer :all]
            [design-pattern.command.add-room-command :as ar]))

(describe "command"
          (with-stubs)
          (it "executes the command"
              (with-redefs [execute (stub :execute)]
                (some-app execute)
                (should-have-invoked :execute))))

(describe "command"
          (with-stubs)
          (it "executes the command"
              (with-redefs [execute (stub :execute)]
                (some-app (partial execute :the-argument))
                (should-have-invoked :execute {:with [:the-argument]}))))

(describe "command"
          (with-stubs)
          (it "executes the command"
              (with-redefs [ar/add-room (stub :add-room {:return :a-room})
                            ar/delete-room (stub :delete-room)]
                (gui-app [:add-room-action :undo-action])
                (should-have-invoked :add-room)
                (should-have-invoked :delete-room {:with [:a-room]}))))