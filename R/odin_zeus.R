odin_zeus = function(test, key, id = TRUE, d = 2, plot = TRUE, use = "pairwise.complete.obs"){
  
  # Preliminaries: score & get keyed test
  q1 = QMEtest(test, key = key, id = id)
  keyed_test = getKeyedTest(q1)
  keyed_test_no_id = getKeyedTestNoID(q1)

  # Get output of middle manager functions
	test_level = list(
    descriptives = summary(q1, d = d),
    reliability = reliability(q1)
	)
  item_level = list(
    distractor_analysis = distractor_analysis(q1),
    item_stats = item_level(q1)
  )
    
	# prop_missing = miss(keyed_test_no_id): this should probably be in summary()

  # Gather it all up in a list
	oz = list(
		test_level = test_level,
		item_level = item_level
		)
  class(oz) = "oz"
  
	return(oz)
}







#library(difR)

# Add group
#group = sample(c(1, 0), size = 30, replace = TRUE)


#oz = odin_zeus(math, key = mathKey, group = group, focal_name = 0)
#oz


#odin_zeus(math_correct, group = group, focal_name = 0)
