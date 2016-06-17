######################################################################################
## Another way to get the point-biserial and the corrected point-biserial correlation:

point_biserial = function(x, ...) {
  
  total_score = rowSums(x)
  delscores = total_score - x
  
  ## Only calculate pbis and corrected pbis when sd > 0
  positive_sd = vapply(x,
                       function(y) length(unique(y)) > 1,
                       TRUE)
  
  if(any(!positive_sd))
    warning("The following item(s) have no variation, returning NA: ",
            paste(names(x)[!positive_sd], collapse = ", "))
  
  
  pbis_report = data.frame(Item = colnames(x),
                           point_biserial = NA_real_,
                           corrected_pbis = NA_real_)
  
  pbis_report$point_biserial[positive_sd] = cor(total_score, x[, positive_sd])[1,]
  pbis_report$corrected_pbis[positive_sd] = mapply(cor,
                                                   delscores[, positive_sd], 
                                                   x[, positive_sd])
  
  return(pbis_report)
}

