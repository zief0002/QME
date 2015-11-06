analyze = function(test, key = NULL, id = TRUE, d = 2, plot = TRUE, use = "pairwise.complete.obs"){
  
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
    item_stats = item_level(q1),
    missing = miss(getRawTestNoID(q1)),
    del_alphas = delete_alpha(keyed_test_no_id)
  )
  
  ## Add distractor analysis only if test is unkeyed
  
  if(is.null(key))
    item_level$distractor_analysis = NULL
  else
    item_level$distractor_analysis = distractor_analysis(q1)

  # Gather it all up in a list
	oz = list(
    test_name = deparse(substitute(test)),
		test_level = test_level,
		item_level = item_level,
    test = q1
		)
  class(oz) = "oz"
  
	return(oz)
}

