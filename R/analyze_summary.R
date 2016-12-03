
#' @export
summary.analyze = function(x, ...) {
  print(x)
  cat("\n")
  # print(getDelAlpha(x), digits = 2, print.gap = 1L)
  cat("\nItem overview\n")
  cat("-------------------------------\n")
  print(getItemOverview(x), digits = 2, print.gap = 1L)
  
  
}
