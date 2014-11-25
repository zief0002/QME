#' Perform distractor analysis for QMEtest object
#' 
#' Calculates distractor analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the distractor analysis

distractor_analysis = function(testQME, ...) {
  raw_test = getRawTestNoID(testQME)
  num_items = ncol(raw_test)
  
  distractors_difficulty = vector("list", length = num_items)
  for(i in 1:num_items){
    distractors_difficulty[[i]] = prop.table(table(raw_test[i]))
  }
  names(distractors_difficulty)<-sprintf("Dist_diff of Item%i",1:num_items)
  
  return(distractors_difficulty)
}