odin_zeus = function(test, key, id = TRUE, d = 2, plot = TRUE, group, focal_name, dif_type = "both", use = "pairwise.complete.obs"){
  
  # Preliminaries: score & get keyed test
  q1 = QMEtest(test, key = key, id = id)
  keyed_test = getKeyedTest(q1)
  keyed_test_no_id = getKeyedTestNoID(q1)

  # Get various basic descriptives
	test_level = summary(q1, d = d)
	c_alpha = coef_alpha(keyed_test_no_id)
	prop_missing = miss(keyed_test_no_id)
	pb = point_biserial(keyed_test_no_id, use = "pairwise.complete.obs")

  # Gather it all up in a list
	oz = list(
		test_level = test_level,
		c_alpha = c_alpha,
		prop_missing = prop_missing,
		point_biserial = pb
		)
	return(oz)
}







#library(difR)

# Add group
#group = sample(c(1, 0), size = 30, replace = TRUE)


#oz = odin_zeus(math, key = mathKey, group = group, focal_name = 0)
#oz


#odin_zeus(math_correct, group = group, focal_name = 0)
