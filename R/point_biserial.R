######################################################################################
## Another way to get the point-biserial and the corrected point-biserial correlation:

point_biserial = function(x, ...) {
  
  total_score = rowSums(x)
  
  point_biserial = c()
  corrected_pbis = c()

  for(k in 1:ncol(x)) { 
    point_biserial[k] = cor(total_score, x[ , k], ...)
    corrected_pbis[k] = cor(total_score - x[ , k], x[ , k], ...)
  }
    
  pbis_report = data.frame(colnames(x), corrected_pbis)
  colnames(pbis_report)[1:2] = c("Item", "corrected_pbis")
    
  return(pbis_report)
}

#Trial run
#math_scored2 = math_scored[2:11]
#point_biserial(math_scored2)
