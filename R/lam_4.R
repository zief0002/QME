



lam_4 <-function(xa,xb)
{
  
  var.xa <- var(apply(xa,1,sum))
  var.xb <- var(apply(xb,1,sum))
  c.ab <- cov(xa,xb)
  
  lam.4 <- 4*c.ab/(var.xa +var.xb+2*c.ab%*%var.xa%*%var.xb)
  return(lam.4)
}




library(devtools)



