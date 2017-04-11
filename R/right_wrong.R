#########################################
# Function to produce a data frame of correct/incorrect
#########################################
right_wrong = function(test_with_id, key, na_to_0 = TRUE) {
  
  score_column = function(itemcol, colname, key, na_to_0) {
    ## Scores a single column
    scores = key[match(itemcol, key$response), colname]
    if(na_to_0) {
      scores[is.na(scores)] = 0 #maybe put a warning here?
    }
    scores
  }
  
  test_no_id = test_with_id[,-1]
  
  scored_matrix = vapply(names(test_no_id), function(colname) {
    score_column(test_no_id[[colname]], colname, key, na_to_0 = na_to_0)
  }, FUN.VALUE = rep(0.0, nrow(test_no_id)))
  
  keyed_test = data.frame(id = test_with_id$id, scored_matrix, check.names = FALSE)

  if(all(names(keyed_test) != names(test_with_id)))
    stop("Column names of keyed test do not equal names of original test")
  
  keyed_test
}
