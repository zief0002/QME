#' Perform distractor analysis for QMEtest object
#' 
#' Calculates distractor analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the distractor analysis

distractor_analysis = function(test, keyed_test, ...) {
  distractors_difficulty = vector("list", length = ncol(test)-1)
    for(i in 1:(ncol(test)-1)){
      distractors_difficulty[[i]] = prop.table(table(test[i+1]))
    }
  names(distractors_difficulty)<-sprintf("Dist_diff of Item%i",1:(length(math)-1))
  return(distractors_difficulty)
}