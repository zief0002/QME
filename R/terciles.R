terciles = function(x) {
  ## Input analyze, output long df with terciles & proportions

	keyed = getKeyedTestNoID(x$test)
	raw = getRawTestNoID(x$test)

	## persons by items matrix of corrected scores
	delscores = scores$scores - keyed

	## person by items matrix of terciles
	terciles = sapply(delscores, function(x)
		findInterval(x, 
			quantile(x, probs = c(0, 1/3, 2/3, 1)),
			all.inside = TRUE)
	  )


	## Correlation b/w item and corrected total for each tercile
	myCorrs = matrix(NA, ncol = 3, nrow = length(keyed))
	for(i in 1:length(keyed)){
		new = data.frame(cbind(keyed[ , i], delscores[ , i], terciles[ , i]))
		names(new) = c("keyed_item", "corrected_score", "tercile")
		myCor = new %>% group_by(tercile) %>% summarize(corr = cor(keyed_item, corrected_score))
		myCorrs[i, ] = myCor$corr
	}

	## Put raw responses in a data frame
	resp = oz$test$raw_test[2:length(oz$test$raw_test)]

	## data frame of responses to item i, ttem-deleted total score, tercile
	new = data.frame(resp[ , i], delscores[ , i], terciles[ , i])
	names(new) = c("response", "corrected_score", "tercile")

	## Loop through to create variables holding the 0/1 for each response
	j = length(levels(new$response))
	myCorrs = rep(NA, j)
	
	for(k in 1:j){
		new[ , (3+k)] = ifelse(new$response == levels(new$response)[k], 1, 0)
		names(new)[3+k] = levels(new$response)[k] 
		myCorrs[k] = cor(new$corrected_score, new[ ,(3+k)])
	}




	# myCorrs = data.frame(cbind(names(oz$test$key), myCorrs))
	# names(myCorrs) = c("Item", "Low", "Med", "High")


	## Calculate proportion choosing each distractor

	tercsummary = melt(terciles) %>% 
	  rename(tercile = value) %>% 
	  left_join(melt(as.matrix(raw)) %>%
	              rename(response = value)) %>%
	  rename(id = Var1, item = Var2) %>%
	  group_by(item, tercile, response) %>%
	  summarize(count = n()) %>%
	  group_by(item, tercile) %>%
	  mutate(total = sum(count),
	         prop = count/total) %>%
	  ungroup() %>%
	  mutate(tercile = ordered(tercile, labels = 
	                            c("Low", "Medium", "High")))

	## Filter on item number
	my_terc_summary = tercsummary %>% filter(item == paste("item", "1", sep =""))
	
	## Add column to denote if response is correct
	my_terc_summary$correct = ifelse(
		my_terc_summary$response == as.character(x$test$key[[1]]), "Correct", "Incorrect")

	## Plot of proportion of each response option by tercile
	ggplot(data = my_terc_summary, aes(x = tercile, y = prop, group = response, color = response)) +
		geom_line(aes(lty = correct)) +
		geom_text(aes(label = response)) +
  		scale_color_brewer(palette = "Set1") +
  		scale_linetype_manual(name = "Response", values = c(1, 3)) +
  		xlab("Tercile") +
  		ylab("Proportion") +
  		ggtitle("Proportion of Each Response Option by Tercile") +
  		theme_bw() +
  		guides(color = FALSE)

}
