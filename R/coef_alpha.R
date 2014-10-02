coef_alpha <- function(x){
  cov.matrix<-cov(x,use="p")
  k<-nrow(cov.matrix)
  return(k/(k-1) *(1- (sum(diag(cov.matrix)) / sum(cov.matrix) )))
}
