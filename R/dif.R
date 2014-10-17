#' Perform DIF
#'
#' Wrapper function to perform Mantel-Hanzel or Logistic DIF
#'
#' This function wraps the \code{difMH} and \code{difLogistic} from the \code{difR} package
#'
#' @param keyed_test A student (row) by item (columns) data frame of  numeric responses or of the raw
#' responses The first column in the data frame is an ID column.
#' @param group Vector of group membership, should be same length as \code{keyed_test}
#' @param focal_name Name of the focal group (string)
#' @param dif_type character, "mh", "logistic", or "both". Default is "both"
#' @param \dots Passed onto difMH and/or difLogistic
#' 
#' @export
#' 
dif = function(keyed_test, group, focal_name, dif_type = "both", ...) {
  
  if ("mh" == dif_type){
      
    output = list(mh = difMH (Data = keyed_test, 
                              group = group,
                              focal.name = focal_name, ...),
                  logistic = NULL)
    
    
  } else if ("logistic" == dif_type){
    output = list(mh = NULL,
        logistic = difLogistic (Data = keyed_test, group = group, focal.name = focal_name, ...))
    
    
  } else if ("both" == dif_type){
    output = list(mh = difMH (Data = keyed_test, group = group, focal.name = focal_name, ...),
    logistic = difLogistic (Data = keyed_test, group = group, focal.name = focal_name, ...))  
    }
               return (output)
}
