(ns design-pattern.command.core-spec
  (:require [speclj.core :refer :all]
            [design-pattern.command.core :refer :all]))

(describe "command"
          (with-stubs)
          (it "executes the command"
              (with-redefs [execute (stub :execute)]
                (some-app execute)
                (should-have-invoked :execute))))
