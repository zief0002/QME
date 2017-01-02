#' Calculate reliability for QMEtest object
#' 
#' Calculates reliability functions for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A data frame with coefficent alpha, Guttman's L2 and L4,
#'   Feldt-Gilmer, and Feldt-Brennan reliabilities, CI limits and SEM

reliability = function(x, ...) {
  
  keyed_test_no_id = getKeyedTestNoID(x)
  
  rel_funs = list(
    guttman_l2 = guttman_l2,   # returns estimate, CI limits, and SEM
    guttman_l4 = guttman_l4,   # returns estimate, CI limits, and SEM
    feldt_gilmer = feldt_gilmer,   # returns estimate, CI limits, and SEM
    feldt_brennan = feldt_brennan,   # returns estimate, CI limits, and SEM
    coef_alpha = coef_alpha   # returns estimate, CI limits, and SEM
  )
  
  out = lapply(rel_funs, function(f) f(keyed_test_no_id))
  out = do.call(rbind, out)
  dimnames(out)[[2]] = c("Estimate", "95% LL", "95% UL", "SEM")
  dimnames(out)[[1]] = c("Guttman's L2", "Guttman's L4", "Feldt-Gilmer", "Feldt-Brennan","Coefficient Alpha")

  return(as.data.frame(out))
  
}

# reliability(out)