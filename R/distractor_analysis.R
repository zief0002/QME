#' Perform distractor analysis for QMEtest object
#' 
#' Calculates distractor analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the distractor analysis

distractor_analysis = function(testQME, ...) {
  test = getKeyedTestNoID(testQME)
  distractors_difficulty = vector("list", length = ncol(test))
    for(i in 1:(ncol(test))){
      distractors_difficulty[[i]] = prop.table(table(test[i]))
    }
  names(distractors_difficulty)<-sprintf("Dist_diff of Item%i",1:(ncol(test)))
  return(distractors_difficulty)
}