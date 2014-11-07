#' Perform item level analysis for QMEtest object
#' 
#' Calculates item level analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the item level analysis

item_level = function(test, keyed_test, ...) {
  difficulty = colSums(keyed_test[ , 2:ncol(keyed_test)])/nrow(keyed_test)
  il = matrix(c(difficulty))
  rownames(il) = colnames(keyed_test[ , 2:ncol(keyed_test)])
  colnames(il) = c("Difficulty")
  print(il)
  distractors_difficulty = vector("list", length = ncol(test)-1)
  for(i in 1:(ncol(test)-1)){
    distractors_difficulty[[i]] = prop.table(table(test[i+1]))
  }
  names(distractors_difficulty)<-sprintf("Dist_diff of Item%i",1:(length(math)-1))
  print(distractors_difficulty)
}



