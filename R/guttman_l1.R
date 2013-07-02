## Calculates Guttman's Lambda 1

guttman_l1 <- function(x) {

  var.x <- var(apply(x,1,sum))
  sum.var.i <- sum(apply(x,2,var))
  
  guttman.l1 <- (var.x - sum.var.i)/(var.x)
  return(guttman.l1)
}
