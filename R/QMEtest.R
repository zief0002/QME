#'Create QMEtest objects
#'
#'Creates a \code{QMEtest} object from given test responses and (optional) key
#'
#'@param test A \code{data.frame} containing the test responses.  If \code{key} 
#'  is not provided, the test is assumed to be already scored. The data frame 
#'  should be formatted in the wide format, so that each row represents a 
#'  student, and each column represents an item. If \code{id = TRUE}, the 
#'  default, the first column is assumed to be the id.
#'@param key A vector or single-row \code{data.frame} indicating the keyed 
#'  responses (i.e. the correct answers for cognitive tests).
#'@param id Whether an ID column has been provided.  If \code{id = FALSE}, an id
#'  will be created in the output object.
#'  
#'@return A \code{QMEtest} object. This is a list with the following elements: 
#'  \describe{ \item{\code{raw_test}}{The raw test responses (\code{NULL} if the test is already scored).} 
#'  \item{\code{key}}{The key}
#'  \item{\code{keyed_test}}{The keyed/scored test, using the \code{right_wrong} function}
#'  }
QMEtest = function(test, key, id = TRUE) {
  
  # If no id column, add one.  
  if(id) {
    test_with_id = test
  } else {
    message("Adding id column.")
    test_with_id = data.frame(id = 1:nrow(test),
                              test)
  }
      
  # Create empty output QMEtest object
  output = list(raw_test = NULL,
                key = NULL,
                keyed_test = NULL)

  
  # If a key is included, call the right_wrong() function to score
  if(!missing(key)){
    output = right_wrong(test_with_id, key = key, id = TRUE) # returns list with the elements we want
  } else {
    # If first column of data are not numeric and there is no key, output an error message
    if(is.numeric(test_with_id[ , 1]) == FALSE){
      stop("Your data have not been keyed. Please input an answer key using the key= argument.")
    } else{
      # If numeric, then the "keyed test" is simply the test and other two items are blank
      output = list(raw_test = NULL,
                key = NULL,
                keyed_test = test_with_id)
    }
    
  }
  class(output) = "QMEtest"
  
  return(output)  
  
}