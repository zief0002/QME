#' Create QMEtest objects
#' 
#' Creates a \code{QMEtest} object from given test responses and (optional) key
#' 
#' @param test A \code{data.frame} containing the test responses.  If \code{key}
#'   is not provided, the test is assumed to be already scored. The data frame 
#'   should be formatted in the wide format, so that each row represents a 
#'   student, and each column represents an item. If \code{id = TRUE}, the 
#'   default, the first column is assumed to be the id.
#' @param key A vector or single-row \code{data.frame} indicating the keyed
#'   responses (i.e. the correct answers for cognitive tests).
#' @param id Whether an ID column has been provided.  If \code{id = FALSE}, an id will be created in the output object.
#' 
#' @return A \code{QMEtest} object. This is a list with the following elements:
#' \item This
#' \item That
#'
QMEtest = function(test, key = NULL, id = TRUE) {
  
  
  
  
}