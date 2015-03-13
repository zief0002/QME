#' Guttman's Lambda_2 (L2) Reliability Coefficient
#' 
#' This function estimates the reliability coeffcient based on Guttman's
#' Lambda_2.
#' 
#' This computation is based on Guttman's second lower bound for reliability
#' (Guttman, 1945).
#' 
#' @param x is a data frame or matrix of the keyed items (0/1)
#' @return Returns a list with the estimate (\code{l2}), lower (\code{ll}) and
#'   upper (\code{ul}) confidence limits, and standard error of measurment (\code{sem})
#'   
#' @references Guttman, L. (1945). A basis for analyzing test-retest
#'   reliability. \emph{Psychometrika, 10} (4), 255--282.
#'   
#'@author University of Minnesota, Educational Psychology Computing Club
#'
#'@examples
#'#Load the test responses and the answer key
#'data(math)
#'data(math_key)
#'
#'#Put test and key into a QMEtest object
#'myTest = QMEtest(math, math_key)
#'
#'#Key the test and output as a data frame without IDs
#'keyedTest = getKeyedTestNoID(myTest)
#'
#'#Compute Guttman's L2
#'guttman_l2(keyedTest)


guttman_l2 = function(x, ...){
  
  # create covariance matrix of the data frame
  cov_matrix = cov(x, use = "pairwise.complete.obs")
  
  tot_var = sum(cov_matrix)
  obs_var = sum(diag(cov_matrix))
  err_var = sum(cov_matrix[row(cov_matrix) != col(cov_matrix)] ^ 2)
  k = nrow(cov_matrix)
  n = nrow(x)
  
  # Compute Guttman's L2
  l2 = (tot_var - obs_var + sqrt(k / (k-1) * err_var)) / tot_var
  
  # Compute CI based on Feldt's (1965) method
  df_1 = n - 1
  df_2 = (n - 1) * (k - 1)

  lower_limit = 1 - ((1 - l2) * qf(0.975, df_1, df_2))
  upper_limit = 1 - ((1 - l2) * qf(0.0255, df_1, df_2))

  sem = sqrt(tot_var * (1 - l2))

  return(list(l2 = l2, ll = lower_limit, ul = upper_limit, sem = sem))

}

# library(QME)
# data(math)
# data(math_key)
# out = QMEtest(math, math_key)
# x = getKeyedTestNoID(out)
# guttman_l2(x)

# Feldt, L. S. (1965). The approximate sampling distribution of Kuder-Richardson reliability coefficient twenty. Psychometrika, 30, 357-370.