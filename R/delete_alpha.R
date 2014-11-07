################################################################################
## delete_reliability is aimed to calculate the reliability with each item removed from the test
delete_alpha<-function(x)
{
  delete_alpha<-c()
  for (j in 1:ncol(x))
  {
    delete_alpha[j]<-coef_alpha(x[,-j])$alpha
  }
}
