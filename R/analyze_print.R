# This will print the test-level output
# The print function for class 'analyze' is just pretty_output, basically.
#' @export
print.analyze = function(x, ...) {
  added = as.matrix(c(`Number of Items` = x$number_items, 
                      `Number of Examinees` = x$number_examinees),
                    ncol = 1)
  descriptives = x$test_level$descriptives
  colnames(descriptives) = colnames(added) = ""
  cat("QME 'analyze' object.\n\nTest name: ", x$test_name, "\n")
  print(added, digits = 0, print.gap = 1L)
  cat("\nDescriptives\n")
  cat("-------------------------------")
  
  print(descriptives, digits = 2, print.gap = 1L)

  cat("\n\nReliabilities\n")
  cat("-------------------------------\n")
  print(getReliability(x), digits = 2, print.gap = 1L)

}

