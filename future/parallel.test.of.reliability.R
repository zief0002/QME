##############################
#Parallel test of reliability#
##############################
function(x1,x2, ...){
          p1 <- apply(x1, 1, sum)
          p2 <- apply(x2, 1, sum)
          para<-sqrt(var(p1,p2))/sqrt(var(p1)*var(p2))
          return(para)
} 





