##' Generate basic psychometrics from data and key
##' 
##' Returns object with basic psychometrics of a test from data and key
##' 
##' This takes a raw test and a key and creates an object that stores some basic
##' psychometrics for the test.
##' 
##' @param test A \code{data.frame} containing subjects as rows and items as 
##'   columns.  If \code{id = TRUE}, the first column should be an id column.
##' @param key Provides information on how to score the test.  If \code{NULL}, 
##'   the default, then test is assumed to be already scored.  Two formats are 
##'   accepted for the key.  A \emph{simple key} can be provided as a named 
##'   vector or single-row data frame, where the names are the names of the 
##'   items and the values are the correct answer (scored 1, and all other 
##'   responses scored 0).  If the scoring scheme is more complex, a \emph{full 
##'   key} can be provided; this must be provided as a \code{data.frame} where 
##'   the first column, \code{response}, contains all the possible responses to 
##'   any item, and the subsequent columns correspond to each item with each 
##'   value in that column representing that item's score for that row's 
##'   response.  See \code{vignette("scoring")} for more help on setting up the 
##'   key.
##' @param create_key For SCORED data only, creates a dummy key mapping input to
##'   output values.  This allows the distractor analysis to be used for scored
##'   data
##' @param id Is there an id column provided for the test? If \code{FALSE} an id
##'   column is automatically created and added.
##' @param d Number of digits for summary outputs
##' @param use Which observations to use (e.g. with or without missing values)
##'   for calculating difficulty and covariance-based measures?  See \code{use}
##'   argument in \code{\link{cov}}
##' @param na_to_0 When scoring, assume that NAs are scored as 0? Default is
##'   TRUE
##' @return Returns an \code{analyze} object with various psychometrics 
##'   calculated.  Primarily to be used with the \code{\link{report}} function 
##'   for viewing detailed output.
##' @export
analyze = function(test, key = NULL, create_key = FALSE, id = TRUE, d = 2, use = "pairwise.complete.obs", na_to_0 = TRUE){
  
  # Preliminaries: score & get keyed test
  q1 = QMEtest(test, key = key, id = id, na_to_0 = na_to_0, create_key = create_key)
  keyed_test = getKeyedTest(q1)
  keyed_test_no_id = getKeyedTestNoID(q1)

  # Get output of middle manager functions
	test_level = list(
    descriptives = summary(q1),
    reliability = reliability(q1, use = use)
	)
  item_level = list(
    item_stats = item_level(q1, use = use),
    missing = miss(getRawTestNoID(q1))
  )
  
  ## Add distractor analysis only if test is unkeyed
  
  if(is.null(key))
    item_level$distractor_analysis = NULL
  else
    item_level$distractor_analysis = distractor_analysis(q1)

  scores = getTotalScores(q1)

  # Gather it all up in a list
	oz = list(
    test_name = deparse(substitute(test)),
    number_items = ncol(keyed_test_no_id),
    number_examinees = nrow(keyed_test_no_id),
    total_scores = scores,
		test_level = test_level,
		item_level = item_level,
    test = q1
		)
  class(oz) = "analyze"
  
	return(oz)
}

