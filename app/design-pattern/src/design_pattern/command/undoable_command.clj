(ns design-pattern.command.undoable-command)

(defmulti execute :type)
(defmulti undo :type)

