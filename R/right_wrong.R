#########################################
# Function to produce a data frame of correct/incorrect
#########################################

right_wrong = function(test, key, id = TRUE, ...){

	column_start = ifelse(id == TRUE, 2, 1)
	id_col = test[, 1]
  
	# Coerce the item variables to characters
	test[ , column_start:length(test)] = lapply(test[ , column_start:length(test)], as.character)
	working_key = lapply(key, as.character)
  
	# Convert NA's to blanks ("")
	test[is.na(test)] = ""

	#Create an empty list
	keyed_test = vector("list", nrow(test))

	# Check if each item is correct or incorrect and store that in the appropriate list element
	for(i in 1:nrow(test)){
		keyed_test[[i]] = as.numeric(test[i , column_start:length(test)] == working_key)
		}

	# Bind the results into a data frame
	keyed_test = as.data.frame(do.call(rbind, keyed_test))
	
	# Get the variable names
	names(keyed_test) = names(test)[column_start:length(test)]
	
	# Bind the IDs and the 1/0s together
	if(id == TRUE){
		raw_test = test
    names(raw_test)[1] = "id"   # change raw test first column to "id" for clarity
    keyed_test = data.frame(id = id_col, keyed_test)
    
	}	
		

	test_data = list(
		raw_test = raw_test,
		key = key,
		keyed_test = keyed_test
		)

	return(test_data)

}
