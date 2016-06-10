## Internal functions for QMEtest objects

getKeyedTest = function(x)
  x$keyed_test

hasKey = function(x)
  !is.null(x$key)

getRawTest = function(x)
  x$raw_test

getKeyedTestNoID = function(x)
  x$keyed_test[, -1]

getRawTestNoID = function(x)
  x$raw_test[, -1]
  
  
getTotalScores = function(x) 
  rowSums(getKeyedTestNoID(x), na.rm = TRUE)
    