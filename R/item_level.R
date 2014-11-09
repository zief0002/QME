#' Perform item level analysis for QMEtest object
#' 
#' Calculates item level analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the item level analysis

item_level = function(keyed_test, ...) {
  difficulty = colSums(keyed_test[ , 2:ncol(keyed_test)])/nrow(keyed_test)
  point_bi = point_biserial(keyed_test)
  il = cbind(point_bi, difficulty)
  il = il[ ,c(4,2,3)]
  return(il)
}
