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
#'  
#'@export
#'  
QMEtest = function(test, key = NULL, id = TRUE) {
  

  
  # If no id column, add one.  
  if(id) {
    ## Rename id column to 'id'
    test_with_id = test
    names(test_with_id)[1] = "id"
  } else {
    message("Adding id column.")
    test_with_id = data.frame(id = 1:nrow(test),
                              test)
  }
  
  # Check if key is in "old" form and put into new data frame format
  if(!is.data.frame(key) || nrow(key) == 1)
    key = refine_key(key, test_with_id)
  
  # Convert all columns of test to character (causes problems if is integer otherwise)
  test_with_id[-1] = apply(test_with_id[-1], 2, as.character)
  
  # Convert key "response" column to character, also avoid problems
  key$response = as.character(key$response)
  
  # Create empty output QMEtest object
  output = list(raw_test = NULL,
                key = NULL,
                keyed_test = NULL)

  
  # If a key is included, call the right_wrong() function to score
  if(!is.null(key)){
    output = list(raw_test = test_with_id,
                  key = key,
                  keyed_test = right_wrong(test_with_id, key = key)) 
  } else {
    # If first column of data (skipping id) are not numeric and there is no key, output an error message
    if(is.numeric(test_with_id[ , 2]) == FALSE){
      stop("Your data have not been keyed. Please input an answer key using the key= argument.")
    } else{
      # If numeric, then the "keyed test" is simply the test and there is no key
      output = list(raw_test = test_with_id,
                key = NULL,
                keyed_test = test_with_id)
    }
    
  }
  class(output) = "QMEtest"
  
  return(output)  
  
}
