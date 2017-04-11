# initial setup -----------------------------------------------------------
require(testthat)
require(QME)

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

test_that("report simple html is the same as reference", {
  expect_equal_to_reference(report(oz, simple_html = TRUE),
                            "tests/testthat/math-report.rds")
})

## This test shouldn't be moved, depends on previous test
test_that("simple html doesn't leave files in working directory",
          expect_length(dir(pattern = "QME_report"), 0))
          

# Code for comparing

# old = readRDS("tests/testthat/math-report.rds")
# write(old, file = "old.html")
# write(report(oz, simple_html = TRUE), file = "new.html")

# QMEtest import ----------------------------------------------
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

test_that("Report works the same with stringsAsFactors = FALSE", {
  
  old = options(stringsAsFactors = FALSE)
  
  expect_equal_to_reference(report(analyze(math, math_key), simple_html = TRUE),
                            "tests/testthat/math-report.rds")
  
  options(old)
  
})

test_that("Integers (not factored) as response options work the same as character input", {
  ## Integer input
  math_int = math
  math_int[-1] = apply(math[-1], 2, function(x) match(as.character(x), LETTERS))
  
  math_key_int = match(math_key, LETTERS)
  
  oz_int = analyze(math_int, math_key_int)
  pr_int = report(oz_int, simple_html = TRUE)
  
  ## Integer-as-character input
  math_intchar = math
  math_intchar[-1] = apply(math[-1], 2, function(x) as.character(match(as.character(x), LETTERS)))
  
  math_key_intchar = as.character(match(math_key, LETTERS))
  
  oz_intchar = analyze(math_intchar, math_key_intchar)
  pr_intchar = report(oz_intchar, simple_html = TRUE)
  
  expect_equal(pr_int, pr_intchar)
})


# Tests of keys -----------------------------------------------------

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





# Analyze -----------------------------------------------------------------

context("analyze")


# Terciles ----------------------------------------------------------

## the following dfs will not produce 3 tercile values for item 7 if using the
## default type 7 quantile algorithm

mystery = 
  data.frame(id = 1:15, item1 = c(1L, 1L, 1L, 1L, 1L, 4L, 2L, 
  1L, 3L, 1L, 1L, 2L, 1L, 3L, 1L), item2 = c(1L, 1L, 1L, 1L, 1L, 
  3L, 4L, 1L, 1L, 1L, 1L, 3L, 1L, 3L, 1L), item3 = c(2L, 2L, 3L, 
  3L, 3L, 2L, 1L, 2L, 1L, 3L, 2L, 1L, 2L, 4L, 2L), item4 = c(4L, 
  4L, 4L, 4L, 4L, 3L, 1L, 1L, 1L, 4L, 4L, 4L, 2L, 1L, 3L), item5 = c(4L, 
  4L, 4L, 4L, 4L, 4L, 1L, 4L, 1L, 4L, 4L, 1L, 4L, 1L, 4L), item6 = c(1L, 
  1L, 1L, 1L, 1L, 3L, 1L, 1L, 1L, 1L, 1L, 4L, 1L, 2L, 1L), item7 = c(2L, 
  2L, 2L, 2L, 2L, 2L, 4L, 4L, 2L, 2L, 2L, 4L, 2L, 2L, 2L), item8 = c(3L, 
  3L, 3L, 3L, 3L, 3L, 3L, 3L, 2L, 3L, 3L, 3L, 3L, 4L, 3L))
mystery_key = c(1L, 1L, 2L, 4L, 4L, 1L, 2L, 3L)

mystery_qt = QMEtest(mystery, mystery_key)
summary(mystery_qt)
an = analyze(mystery, mystery_key)
## Tercile fn should NOT produce warning if all three levels are present
test_that("tercile does not produce warning for not all 3 levels using type 1 algorithm", {
  expect_silent(getTerciles(an))
})


tercile_test = data.frame(id = 1:3, item1 = c(TRUE, FALSE, FALSE),
                          item2 = c(FALSE, TRUE, FALSE),
                          item3 = TRUE)
tercile_key = data.frame(response = c("TRUE", "FALSE"), item1 = c(1, 0), 
                         item2 = c(1, 0), item3 = c(1, 0))

tercile_oz = analyze(tercile_test, tercile_key)

test_that("When not 3 terciles, produces warning", {
  expect_warning(getTerciles(tercile_oz), "do not have values")
})


test_that("tercile output same as reference", {
  expect_equal_to_reference(getTerciles(oz),
                            "tests/testthat/math-terciles.rds")
})


# Scored test -------------------------------------------------------------
test_that("Pre-scored test is analyzed correctly")

comparable_scored = function(x) {
  # create oz object comparable between scored and unscored tests
  out = x
  out$test_name = NULL
  out$test$raw_test = NULL # test object is not comparable
  out$test$key = NULL
  out$item_level$distractor_analysis = NULL  
  out$test_level$reliability = 
    out$test_level$reliability[order(rownames(out$test_level$reliability)),] # for some reason the order gets mixed up

  out
}

math_no_na = na.omit(math)
math_no_na_qt = QMEtest(math_no_na, math_key)
prescored_math = math_no_na_qt$keyed_test

scored_qt = QMEtest(prescored_math)
scored_oz = analyze(prescored_math)
no_na_oz = analyze(math_no_na, math_key)
expect_equal(comparable_scored(no_na_oz), comparable_scored(scored_oz))

## Item values greater than 1

pres_math_2 = (prescored_math + 1)*3


math2_oz = analyze(pres_math_2)
math2_over = QME:::getItemOverview(math2_oz)
QME:::plotItemOverview(math2_over)

## New functionality to NOT map NA to 0
math_na_qt = QMEtest(math, math_key, na_to_0 = FALSE)
math_na_oz = analyze(math, math_key, na_to_0 = FALSE)
scored_na_oz = analyze(math_na_qt$keyed_test, na_to_0 = FALSE)
expect_equal(comparable_scored(math_na_oz), comparable_scored(scored_na_oz))

## test dummy key
dum = pres_math_2[-1]
dum[3, 6] = 7
dum_qt = QMEtest(dum, create_key = TRUE)
expect_equal(apply(dum_qt$raw_test, 2, as.numeric), 
             apply(dum_qt$keyed_test, 2, as.numeric))

expect_false(dum_qt$dichotomous)

## 

# Report with missing values ----------------------------------------------
getTerciles(scored_na_oz)

report(scored_na_oz)

