################################################################################
## delete_reliability is aimed to calculate the reliability with each item removed from the (scored) text x
delete_alpha<-function(x) {
  deleted_alpha = vapply(1:ncol(x), 
                         function(j)
                           coef_alpha(x[,-j])[["alpha"]],
                         NA_real_)
  names(deleted_alpha) = names(x)
  deleted_alpha
}
