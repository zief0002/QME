################################################################################
## delete_reliability is aimed to calculate the reliability with each item removed from the test
delete_alpha<-function(x)
{
  deleted_alpha<-c()
  for (j in 1:ncol(x))
  {
    deleted_alpha[j]<-coef_alpha(x[,-j])[["alpha"]]
  }
  names(deleted_alpha) = names(x)
  deleted_alpha
}
