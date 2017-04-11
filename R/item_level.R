#' Perform item level analysis for QMEtest object
#' 
#' Calculates item level analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the item level analysis

item_level = function(testQME, use) {
  keyed_test = getKeyedTestNoID(testQME)
  
  use_types = c("all.obs", "complete.obs", "pairwise.complete.obs", 
                "everything", "na.or.complete")
  
  na.method <- use_types[pmatch(use, use_types)]
  
  if (is.na(na.method)) 
    stop("invalid 'use' argument")
  
  if(na.method == "complete.obs") {
    keyed_test = na.omit(keyed_test)
    difficulty = colMeans(keyed_test, na.rm = FALSE)
  } else if(na.method == "pairwise.complete.obs")
    difficulty = colMeans(keyed_test, na.rm = TRUE)
  else
    difficulty = colMeans(keyed_test, na.rm = FALSE)
  
  point_bi = point_biserial(keyed_test, use = na.method)
  il = cbind(point_bi, difficulty)
  il = il[ ,c(3,2)]
  return(il)
}
