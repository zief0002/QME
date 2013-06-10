
function(x, k=NA , ...){
  
  k<-ifelse(is.na(k),length(x), k)  
  var.x <- var(apply(x,1,sum))
  sum.var.i <- sum(apply(x,2,var))
  
  coef.alpha <- (k/(k-1))* ((var.x - sum.var.i)/(var.x))
  return(coef.alpha)
}
