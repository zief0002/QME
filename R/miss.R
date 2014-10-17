#################################################################################
# Function to compute number and proportion of missing data for each item
#################################################################################


miss = function(x, order = FALSE,...){
  
  # x is a data frame with and ID variable column of raw responses
  # assume that missing can be detected; so no blank spaces as levels
  missingness = apply(x[ , 1:length(x)], MARGIN = 2, function(x) sum(is.na(x)))
  
  # store data into a single data frame 
	missData = data.frame(
		item = names(missingness),
		numMiss = missingness,
		propMiss = missingness/nrow(x)
		)


  # when option=T, this inner function will be applied to data frame
	if(order == TRUE){
		missData = missData[order(missData$numMiss), ]

		}
  
  return(missData[,-1])

	}


#item.response.data <- read.csv("C:/Users/Kory/Desktop/R group/code a thon/math.csv", na.strings="")
#item.response.data1 <- item.response.data[,-1]
#miss(item.response.data, order=F)


