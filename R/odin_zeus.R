odin_zeus = function(test, key, id = TRUE, d = 2, plot = TRUE, group, focal_name, dif_type = "both", use = "pairwise.complete.obs"){


	test_level = test_summary(test, key, id = TRUE, d = 2, plot = FALSE)
	dif_out = dif(test_level$keyed_test, dif_type = "both", group, focal_name)
	c_alpha = coef_alpha(test_level$keyed_test_no_id)
	#prop_missing = miss(test_level$raw_test)
	pb = point_biserial(test_level$keyed_test_no_id, use = "pairwise.complete.obs")

	oz = list(
		test_level = test_level,
		dif_out = dif_out,
		c_alpha = c_alpha,
		#prop_missing = prop_missing,
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