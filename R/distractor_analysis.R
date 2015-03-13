#' Perform distractor analysis for QMEtest object
#' 
#' Calculates distractor analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the distractor analysis

distractor_analysis = function(testQME, ...) {
  raw_test = getRawTestNoID(testQME)
  num_items = ncol(raw_test)
  
  distractors_difficulty = vector("list", length = num_items)
  distractors_discrim = vector("list", length = num_items)

  for(i in 1:num_items){
    distractors_difficulty[[i]] = prop.table(table(raw_test[i]))

    ## data frame of responses to item i, ttem-deleted total score, tercile
		new = data.frame(resp[ , i], delscores[ , i])
		names(new) = c("response", "corrected_score")

		## Loop through to create variables holding the 0/1 for each response
		j = length(levels(new$response))
		myCorrs = rep(NA, j)
	
		for(k in 1:j){
			new[ , (2+k)] = ifelse(new$response == levels(new$response)[k], 1, 0)
			names(new)[2+k] = levels(new$response)[k] 
			myCorrs[k] = cor(new$corrected_score, new[ ,(2+k)])
		}
	distractors_discrim[[i]] = myCorrs 	


  }
  names(distractors_difficulty) = sprintf("Dist_diff of Item%i",1:num_items)
  names(distractors_discrim) = sprintf("Dist_disc of Item%i",1:num_items)
  
  return(list(distractors_difficulty, distractors_discrim))
}