## Internal functions for QMEtest objects

getKeyedTest = function(QMEtest)
  QMEtest$keyed_test

hasKey = function(QMEtest)
  !is.null(QMEtest$key)

getRawTest = function(QMEtest)
  QMEtest$raw_test
    