


# have the ... so I need to call the split half function
lam_4 = function(x,oddEven=TRUE,...)
{
  
  if(oddEven == TRUE){         #I had a 1 but verify this
    even.items = x[ , 1:length(x)%%2 == 0]
    odd.items = x[ , 1:length(x)%%2 == 1]
    even.score = rowSums(even.items)
    odd.score = rowSums(odd.items)
    varOdd = var(odd.score)
    varEven = var(even.score)
    covEO = cov(even.score, odd.score)
    lam.4 <- 4*cov/(varOdd +varEven+2*cov%*%varOdd%*%varEven)
    
  } else{
    samp.items = sample(1:length(x), length(x)/2, replace = FALSE)
    form.a = x[ , samp.items]
    form.b = x[ , -samp.items]
    form.a.score = rowSums(form.a)
    form.b.score = rowSums(form.b)
    varA = var(form.a.score)
    varB = var(form.b.score)
    covAB = cov(form.a.score,form.b.score)
    lav.4 = 4*cov/(varA + varB + 2*covAB%*%varA%*%varB)
  }	
  
  


  return(lam.4)
}
# 
# 
# 
# 
# library(devtools)
# 
# 
# 
# m2 <- cbind(1, 1:4)
# colnames(m2, do.NULL = FALSE)
# colnames(m2) <- c("x","Y")
# rownames(m2) <- rownames(m2, do.NULL = FALSE, prefix = "Obs.")
# m2