require(testthat)
require(QME)

data(math)
data(math_key)

math_qt = QMEtest(math, math_key)
oz = analyze(math, math_key)


# Checks against reference dfs --------------------------------------------
context("reference")

test_that("distractor analysis is corrected pearson with attali 2000 correction", {
  expect_equal_to_reference(QME:::distractor_analysis(math_qt),
                            "tests/testthat/distractor_attali.rds")
  
})

test_that("analyze output for 'math' dataset is the same as reference", {
  expect_equal_to_reference(oz,
                            "tests/testthat/math-analyze.rds")
  
})

test_that("psycho_report simple html is the same as reference", {
  expect_equal_to_reference(psycho_report(oz, simple_html = TRUE),
                            "tests/testthat/math-psycho_report.rds")
  
  
})



# Checks in response to bugs ----------------------------------------------
context("data import to QMEtest")

test_that("QMEtest changes id name in dataset to 'id'", {
  math2 = math
  names(math2)[1] = "Custom.Id.Name"
  
  math2_QMEtest = QMEtest(math2, math_key)
  expect_equal(names(QME:::getRawTest(math2_QMEtest))[1], "id")
  
})

test_that("Integers (not factored) as response options work the same as character input", {
  ## Integer input
  math_int = math
  math_int[-1] = apply(math[-1], 2, function(x) match(as.character(x), LETTERS))
  
  math_key_int = math_key
  math_key_int = apply(math_key, 2, function(x) match(as.character(x), LETTERS))
  
  oz_int = analyze(math_int, math_key_int)
  pr_int = psycho_report(oz_int, simple_html = TRUE)
  
  ## Integer-as-character input
  math_intchar = math
  math_intchar[-1] = apply(math[-1], 2, function(x) as.character(match(as.character(x), LETTERS)))
  
  math_key_intchar = math_key
  math_key_intchar = apply(math_key, 2, function(x) as.character(match(as.character(x), LETTERS)))
  
  oz_intchar = analyze(math_intchar, math_key_intchar)
  pr_intchar = psycho_report(oz_intchar, simple_html = TRUE)
  
  expect_equal(pr_int, pr_intchar)
})


# Not yet implemented -----------------------------------------------------

# test_that("Is the key a valid dataframe", {
#   goodkey = data.frame(response = c("A","B","C"),
#                            Q1 = c(1,0,0),
#                            Q2 = c(0,NA,1),
#                            Q3 = c(0, .5, 1))
#   badkey = data.frame(response = c("A","B","C"),
#                       Q1 = c(1,0,"bum"),
#                       Q2 = c(0,NA,1),
#                       Q3 = c(0, .5, 1))
#     expect_true(is_valid_key(goodkey))
#     expect_false(is_valid_key(badkey))
# 
# })


## Should test logical items as well

# test_that("Dichotomous items tercile plots work", {
#   math_dich = math_qt$keyed_test
#   math_dich_key = math_dich[1, -1]
#   
#   x = analyze(math_dich, math_dich_key)
#   
#   psycho_report(x)
# })

# test_that("Convert key vector into key dataframe")
