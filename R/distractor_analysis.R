#' Perform distractor analysis for QMEtest object
#' 
#' Calculates distractor analysis for QMEtest objects
#' 
#' @param x a \code{QMEtest} object
#' @return A list with various aspects of the distractor analysis

distractor_analysis = function(testQME, ...) {
  raw_test = getRawTestNoID(testQME)
  num_items = ncol(raw_test)

  keyed = getKeyedTestNoID(testQME)

	## persons by items matrix of corrected scores
  scores = rowSums(keyed)
  delscores = scores - keyed
  
  distractors_difficulty = vector("list", length = num_items)
  distractors_discrim = vector("list", length = num_items)

  for(i in 1:num_items){
    
    distractors_difficulty[[i]] = prop.table(table(raw_test[i]))

    ## data frame of responses to item i, item-deleted total score
		new = data.frame(response = raw_test[ , i], 
		                 corrected_score = delscores[ , i],
		                 keyed = keyed[, i])
		new = na.omit(new)

		## Calculate 0-1 indicators for each distractor Other distractors (e.g. key =
		## 0) are considered MISSING and EXCLUDED (Attali, 2000)
		indicators = model.matrix(corrected_score ~ 0 + response, data = new)
		
		to_exclude = apply(indicators, 2, function(x) {
		  ## Check if column is distractor
		  ## THIS IS INEFFICIENT, SHOULD CHECK KEY INSTEAD
		  if(any(x[new$keyed == 0] == 1))
		    ## return TRUE if not this distractor AND is incorrect
		    x == 0 & new$keyed == 0
		  else
		    rep(FALSE, length(x))
		})
		
		indicators[to_exclude] = NA

		
		## Calculate correlations of indicators with corrected score
		distractors_discrim[[i]] = cor(new$corrected_score, 
	                                 indicators,
		                               use = "pairwise.complete.obs")[1,]


  }
  names(distractors_difficulty) = sprintf("Dist_diff of Item%i",1:num_items)
  names(distractors_discrim) = sprintf("Dist_disc of Item%i",1:num_items)
  
  return(list(distractors_difficulty, distractors_discrim))
}