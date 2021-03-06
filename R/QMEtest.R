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
#' @param create_key For SCORED data only, creates a dummy key mapping input to
#'   output values.  This allows the distractor analysis to be used for scored
#'   data
#'@param id Whether an ID column has been provided.  If \code{id = FALSE}, an id
#'  will be created in the output object.
#'   @param na_to_0 When scoring, assume that NAs are scored as 0? Default is TRUE
#'@return A \code{QMEtest} object. This is a list with the following elements: 
#'  \describe{ \item{\code{raw_test}}{The raw test responses (\code{NULL} if the test is already scored).} 
#'  \item{\code{key}}{The key}
#'  \item{\code{keyed_test}}{The keyed/scored test, using the \code{right_wrong} function}
#'  }
#'  
#'@export
#'  
QMEtest = function(test, key = NULL, id = TRUE, na_to_0 = TRUE, create_key = FALSE) {
  
  ## Check keys
  if(is_valid_simple_key(key)) {
    n_items_key = length(key)
    key_simple = TRUE
    key_full = FALSE
  } else if(is_valid_full_key(key)) {
    n_items_key = ncol(key) - 1
    key_simple = FALSE
    key_full = TRUE
  } else if(is.null(key)) {
    key_simple = FALSE
    key_full = FALSE
  } else
    stop("Key not valid.  See `vignette('scoring')`.")
  
  ## Check column length of test
  
  if(id) {
    n_items_test = ncol(test) - 1
  } else if(!id) 
    n_items_test = ncol(test)
  else
    stop("`id` argument must be TRUE or FALSE")
  
  if(!is.null(key) && n_items_test != n_items_key)
    stop("Number of items in test, ", n_items_test,
         " must match number of items in key, ", n_items_key,
         ".", ifelse(id, " If test is missing id column, use `id = FALSE`.", ""))
  
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
  if(key_simple)
    key = refine_key(key, test_with_id)
  # Create dummy key for scored data, if requested
  if(create_key)
    key = create_key_fn(test_with_id)

  
  # If unscored, convert key and response to character
  if(!is.null(key)) {
    names(key)[1] = "response"
    key$response = as.character(key$response)
    
    # Convert all columns of test to character (causes problems if is integer otherwise)
    test_with_id[-1] = apply(test_with_id[-1], 2, as.character)
    
  }
  
  # If a key is included, call the right_wrong() function to score
  if(!is.null(key)){
    output = list(raw_test = test_with_id,
                  key = key,
                  keyed_test = right_wrong(test_with_id,
                                           key = key,
                                           na_to_0 = na_to_0)) 
  } else {
    # If first column of data (skipping id) are not numeric and there is no key, output an error message
    if(is.numeric(test_with_id[[2]]) == FALSE){
      stop("Your data have not been keyed. Please input an answer key using the key= argument.")
    } else{
      # If numeric, then the "keyed test" is simply the test and there is no key
      output = list(raw_test = test_with_id,
                key = NULL,
                keyed_test = test_with_id)
    }
    
  }
  
  ## Is test dichotomous?
  if(key_simple) {
    output$dichotomous = TRUE
  } else if(key_full | create_key) {
    # dichotomous iff all key cols only have 0 and 1
    output$dichotomous = all(apply(key[, -1], 2, function(x) x %in% 0:1))
  } else if(is.null(key))
    # dichotomous iff all raw responses (no key) only 0 and 1
    output$dichotomous = all(apply(test_with_id[, -1], 
                                   2, 
                                   function(x) x %in% c(0:1, NA)))
    
  
  class(output) = "QMEtest"
  
  return(output)  
  
}
