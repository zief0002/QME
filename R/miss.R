#################################################################################
# Function to compute number and proportion of missing data for each item
#################################################################################


miss = function(x, order = FALSE, id = TRUE, ...){
  
	column_start = ifelse(id == TRUE, 2, 1)


  # x is a data frame with and ID variable column of raw responses
  # assume that missing can be detected; so no blank spaces as levels
  missingness = apply(x[column_start:length(x)], MARGIN = 2, function(x) sum(is.na(x)))
  
  # store data into a single data frame 
	missData = data.frame(
		item = names(missingness),
		numMiss = missingness,
		propMiss = missingness/nrow(x)
		)
  
  # prints the name of the items with ":" next to it for order=FALSE
	item.names = paste0(missData$item, ":")

  # when option=T, this inner function will be applied to data frame
	if(order == TRUE){
		missData = missData[order(missData$numMiss), ]
    # overwrites previous item.names so that item matches numMiss and propMiss in output for order=TRUE
    item.names = paste0(missData$item, ":")
		}
  
	# This will print the output (second and third column) using item.names (which varies from order=T/F) as row names
	# digits and print.gap makes the output look pretty
  return(print(missData[2:3], digits = 2, print.gap = 1L, row.names = item.names))

	}


#item.response.data <- read.csv("C:/Users/Kory/Desktop/R group/code a thon/math.csv", na.strings="")
#miss(item.response.data, order=F)


