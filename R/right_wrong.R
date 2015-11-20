#########################################
# Function to produce a data frame of correct/incorrect
#########################################
right_wrong = function(test_with_id, key) {
  
  score_column = function(itemcol, colname, new_key) {
    ## Scores a single column
    scores = new_key[match(itemcol, new_key$response), colname]
    scores[is.na(scores)] = 0 #maybe put a warning here?
    
    scores
  }
  
  test_no_id = test_with_id[,-1]
  
  scored_matrix = vapply(names(test_no_id), function(colname) {
    score_column(test_no_id[[colname]], colname, new_key)
  }, FUN.VALUE = rep(0, nrow(test_no_id)))
  
  data.frame(id = test_with_id$id, scored_matrix)

}
