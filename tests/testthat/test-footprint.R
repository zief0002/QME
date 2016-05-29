require(testthat)
require(QME)

data(math)
data(math_key)

math_qt = QMEtest(math, math_key)
oz = analyze(math, math_key)

## lapply(dir("R", full.names = T), source)

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

test_that("tercile output same as reference", {
  expect_equal_to_reference(QME:::getTerciles(oz),
                            "tests/testthat/math-terciles.rds")
})

test_that("report simple html is the same as reference", {
  expect_equal_to_reference(report(oz, simple_html = TRUE),
                            "tests/testthat/math-report.rds")
  
  
})


# Checks in response to bugs ----------------------------------------------
context("data import to QMEtest")

test_that("QMEtest changes id name in dataset to 'id'", {
  math2 = math
  names(math2)[1] = "Custom.Id.Name"
  
  math2_QMEtest = QMEtest(math2, math_key)
  expect_equal(names(QME:::getRawTest(math2_QMEtest))[1], "id")
  
})

test_that("QMEtest detects that id is missing and throws error", {
  math_no_id = math[-1]
  
  expect_error(QMEtest(math_no_id, math_key), regexp = "[Mm]issing")
  
  
})

test_that("Integers (not factored) as response options work the same as character input", {
  ## Integer input
  math_int = math
  math_int[-1] = apply(math[-1], 2, function(x) match(as.character(x), LETTERS))
  
  math_key_int = math_key
  math_key_int = apply(math_key, 2, function(x) match(as.character(x), LETTERS))
  
  oz_int = analyze(math_int, math_key_int)
  pr_int = report(oz_int, simple_html = TRUE)
  
  ## Integer-as-character input
  math_intchar = math
  math_intchar[-1] = apply(math[-1], 2, function(x) as.character(match(as.character(x), LETTERS)))
  
  math_key_intchar = math_key
  math_key_intchar = apply(math_key, 2, function(x) as.character(match(as.character(x), LETTERS)))
  
  oz_intchar = analyze(math_intchar, math_key_intchar)
  pr_intchar = report(oz_intchar, simple_html = TRUE)
  
  expect_equal(pr_int, pr_intchar)
})


# Not yet implemented -----------------------------------------------------

test_that("'full key' detected as valid", {
  goodkey = data.frame(response = c("A","B","C"),
                           Q1 = c(1,0,0),
                           Q2 = c(0,NA,1),
                           Q3 = c(0, .5, 1))
  badkey = data.frame(response = c("A","B","C"),
                      Q1 = c(1,0,"bum"),
                      Q2 = c(0,NA,1),
                      Q3 = c(0, .5, 1))
    expect_true(is_valid_full_key(goodkey))
    expect_false(is_valid_full_key(badkey))

})

test_that("'simple key' detected as valid", {
  goodkey_vector = c(1:5)
  goodkey_matrix = matrix(goodkey_vector, nrow = 1)
  goodkey_df = data.frame(goodkey_matrix)

  expect_true(is_valid_simple_key(goodkey_vector))
  expect_true(is_valid_simple_key(goodkey_matrix))
  expect_true(is_valid_simple_key(goodkey_df))
    
  badkey_vector = c()
  badkey_df = rbind(goodkey_df, goodkey_df) 
  badkey_matrix = as.matrix(badkey_df)
  
  expect_false(is_valid_simple_key(badkey_vector))
  expect_false(is_valid_simple_key(badkey_df))
  expect_false(is_valid_simple_key(badkey_matrix))
})


