#' Perform distractor analysis for QMEtest object
#' 
#' Calculates distractor analysis for QMEtest objects
#' 
#' @param testQME a \code{QMEtest} object
#' @return A list with various aspects of the distractor analysis

distractor_analysis = function(testQME, ...) {
  raw_test = getRawTestNoID(testQME)
  num_items = ncol(raw_test)

  keyed = getKeyedTestNoID(testQME)
  
  key = getKey(testQME)

	## persons by items matrix of corrected scores
  scores = rowSums(keyed)
  delscores = scores - keyed
  
  
  distractor = lapply(1:num_items, function(i) { 
  ## Calculate distractor analysis table
    
    difficulty = prop.table(table(raw_test[i]))
    choices = rownames(difficulty)
    keys = key[match(choices, key$response), 1 + i]
    names(keys) = choices

    ## data frame of responses to item i, item-deleted total score
		new = data.frame(response = raw_test[ , i], 
		                 corrected_score = delscores[ , i],
		                 keyed = keyed[, i])
		new = na.omit(new)

		## Calculate 0-1 indicators for each distractor Other distractors (e.g. key =
		## 0) are considered MISSING and EXCLUDED (Attali, 2000)
		if(length(choices) > 1) {
		  indicators = model.matrix(corrected_score ~ 0 + response, data = new)
		  ## rm "response" prefix 
		  colnames(indicators) = sub("response", "", colnames(indicators))
		  
		  indicators = data.frame(indicators, check.names = FALSE)
		} else {
		  ## model.matrix fails when there is no variability
		  indicators = data.frame(rep(NA, nrow(new)))
		  names(indicators) = choices
		}
		
		stopifnot(choices == names(indicators))
		
		distractors = names(keys)[keys == 0]
		
		## Exclude other incorrect distractors from calculation
		if(length(distractors) > 0) {
  		to_exclude = apply(indicators[, distractors, drop = FALSE], 2, function(x) {
  		    ## return TRUE if not this distractor AND is incorrect
  		    x == 0 & new$keyed == 0
  		})
  		
  		indicators[, distractors][to_exclude] = NA
		}
		
		## Calculate correlations of indicators with corrected score
		distractors_discrim = cor(new$corrected_score, 
	                                 indicators,
		                               use = "pairwise.complete.obs")[1,]
		
		out = data.frame(Choice = choices,
		                 Key = keys,
		                 Proportions = as.numeric(difficulty),
		                 `Response Discrimination` = as.numeric(distractors_discrim),
		                 check.names = FALSE)
		
		row.names(out) = NULL
		
		out
  }) 
  
  names(distractor) = names(raw_test)
  
  return(distractor)
}