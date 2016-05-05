require(testthat)

data(math)
data(math_key)

math_qt = QMEtest(math, math_key)

test_that("odin_zeus runs without errors", {
  oz = analyze(math, math_key)
print("yo")
  })

test_that("distractor analysis is corrected pearson with attali 2000 correction", {
  expect_equal_to_reference(distractor_analysis(math_qt),
                            "tests/testthat/distractor_attali.rds")
  
})


test_that("Is the key a valid dataframe", {
  goodkey = data.frame(response = c("A","B","C"),
                           Q1 = c(1,0,0),
                           Q2 = c(0,NA,1),
                           Q3 = c(0, .5, 1))
  badkey = data.frame(response = c("A","B","C"),
                      Q1 = c(1,0,"bum"),
                      Q2 = c(0,NA,1),
                      Q3 = c(0, .5, 1))
    expect_true(is_valid_key(goodkey))
    expect_false(is_valid_key(badkey))

})

test_that("QMEtest changes id name in dataset to 'id'", {
  math2 = math
  names(math2)[1] = "Custom.Id.Name"
  
  math2_QMEtest = QMEtest(math2, math_key)
  
})


# test_that("Convert key vector into key dataframe")
