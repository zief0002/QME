#' Calculate reliability for QMEtest object
#' 
#' Calculates reliability functions for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with a bunch of tasty reliabilities

reliability = function(x, ...) {
  
  keyed_test_no_id = getKeyedTestNoID(x)
  
  rel_funs = list(
    coef_alpha = coef_alpha,   # returns estimate, CI limits, and SEM
    guttman_l2 = guttman_l2,   # returns estimate, CI limits, and SEM
    feldt_gilmer = feldt_gilmer   # returns estimate, CI limits, and SEM
    # lam_4: Not currently included (does not work)
  )
  
  out = lapply(rel_funs, function(f) f(keyed_test_no_id))
  
  return(out)
  
}

# reliability(out)