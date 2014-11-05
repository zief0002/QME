## Internal functions for QMEtest objects

getKeyedTest = function(QMEtest)
  QMEtest$keyed_test

hasKey = function(QMEtest)
  !is.null(QMEtest$key)

getRawTest = function(QMEtest)
  QMEtest$raw_test

getKeyedTestNoID = function(QMEtest)
  QMEtest$keyed_test[, -1]
  
  
getTotalScores = function(QMEtest) 
  rowSums(getKeyedTestNoID(QMEtest), na.rm = TRUE)
    