#' Perform item level analysis for QMEtest object
#' 
#' Calculates item level analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the item level analysis

item_level = function(keyed_test, ...) {
  difficulty = colSums(keyed_test[ , 2:ncol(keyed_test)])/nrow(keyed_test)
  il = matrix(c(difficulty))
  rownames(il) = colnames(keyed_test[ , 2:ncol(keyed_test)])
  colnames(il) = c("Difficulty")
  print(il)
}

