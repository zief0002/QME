######################
# Length of the Test #
######################

function (x,k,r=split_hlaf...){ 
  r_tt<-split_half(x)
  
  increase.item<-(k*r_tt)/(1+(k-1)*r_tt)
  return(increase.item)
   
  
} 



