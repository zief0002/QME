#######################################################################################
#
#     An R Routine for Item Analysis
#
#     Cengiz Zopluoglu
#     Assistant Professor
#     Research, Measurement, and Evaluation
#     University of Miami
#
#     Please report any programming bug: c.zopluoglu1@miami.edu
# 
#     09/23/2013
#
#     Depends on: "ggplot"
##########################################################################################

library(R6)

#########################################################################################
# data, a data frame with N rows and n columns, where N denotes the number of subjects 
# and n denotes the number of items. All items should be scored using nominal 
# response categories. All variables (columns) must be "character". 
# Missing values ("NA") are allowed and scored as incorrect in item analysis
# key, a character vector of length n, where n denotes the number of items. 
# options, number of possible nominal options for items (e.g., "A","B","C","D")
# make sure each item is consistent, and includes the same response options
# ngroup, number of score groups
# correction, TRUE or FALSE, if TRUE item and distractor discrimination is corrected for
# spuriousnes by removing the item score from the total score
#########################################################################################
ITEMAN <- R6Class(
  "ITEMAN",
  public = list(
    itemanEnv = NA,
    initialize = function(data, key, options,ngroup=ncol(data),correction=TRUE) {
      private$data = data
      private$correction = correction
      private$options = options
      
      ## turning data into characters
      ## lapply(data, as.character)
      for (i in 1:ncol(private$data)) {
        if (is.character(private$data[ ,i]) != TRUE) {
          private$data[ ,i]=as.character(private$data[,i])
        }
      }
      #################################
      #Our rightWrong function will do this section
      
      ### creating blank dataframe  
      private$scored.data <- as.data.frame(matrix(nrow = nrow(private$data), ncol = ncol(private$data)))
      ## To be filled with the rescored data
      for (i in 1:ncol(private$scored.data)) {
        private$scored.data[,i] <- ifelse(private$data[,i] == key[i],1,0)
        if(length(which(is.na(private$scored.data[,i])))!=0) {
          private$scored.data[which(is.na(private$scored.data[,i])==TRUE),i]=0
        }
      }
      #######################
      #Report student score summary information
      total.score <- rowSums(private$scored.data)
      
      ybar <- mean(total.score) #mean student score
      sdt <- sd(total.score) #standard deviation of student scores
      p <- colMeans(private$scored.data) #item difficulty
      sdi <- sqrt(p*(1-p)) #
      t <- qnorm(1-p)
      ord <- dnorm(t)
      ################
      #
      pbis <- c()
      pbis.corrected <- c()
      bis  <- c()
      
      ## 
      for(k in 1:ncol(private$data)) { 
        
        y=mean(total.score[which(private$scored.data[,k]==1)]) #mean student score of students who answerd item k correctly
        pbis[k]=((y-ybar)/sdt)*sqrt(p[k]/(1-p[k]))  #point biserial correlations 
        #Use existing function to do point biserial correlations with and without corrections
        pbis.corrected[k]=((pbis[k]*sdt)-sdi[k])/sqrt(sdt^2+sdi[k]^2-(2*pbis[k]*sdt*sdi[k]))
        bis[k]=((y-ybar)/sdt)*(p[k]/ord[k])
      }
      
      ############
      #Creating output presentation
      private$item.stat <- matrix(nrow=ncol(private$data),ncol=4)
      if(correction==TRUE) {
        colnames(private$item.stat) <- c("Item Difficulty","Item Threshold","Corrected Point-Biserial","Biserial")
      } else  colnames(private$item.stat) <- c("Item Difficulty","Item Threshold","Uncorrected Point-Biserial","Biserial")
      
      
      rnames <- ("Item 1")
      for(i in 2:ncol(private$data)){ rnames <- c(rnames,paste("Item ",i,sep=""))}
      rownames(private$item.stat) <- rnames  
      private$item.stat[,1]=p #item difficulty
      private$item.stat[,2]=qnorm(1-p) #normal distribution from incorrect answers
      if(correction==TRUE){ private$item.stat[,3]=pbis.corrected } else { private$item.stat[,3]=pbis }
      private$item.stat[,4]=bis
      
      
      sgroups <- cut(total.score,breaks=ngroup)
      slevels <- levels(sgroups)
      
      sgnum <- rowMeans(cbind(lower = as.numeric( sub("\\((.+),.*", "\\1", slevels) ),
                              upper = as.numeric( sub("[^,]*,([^]]*)\\]","\\1",slevels))))
      
      
      
      SG <- vector("list",ngroup)
      
      for(j in 1:ngroup){
        SG[[j]]=which(sgroups==slevels[j])
      }
      
      prop <- vector("list",ncol(private$data))
      names(prop) <- rnames
      
      for(i in 1:ncol(private$data)) {
        
        dist <- matrix(nrow=length(private$options),ncol=ngroup)
        colnames(dist) <- slevels
        rownames(dist) <- private$options 
        
        for(g in 1:ngroup){
          for(o in 1:length(private$options)){
            dist[o,g]=length(which(private$data[SG[[g]],i]==private$options[o]))/length(SG[[g]])
          }
        }
        
        prop[[i]]=dist
        
      }
      
      dist.sel <- matrix(nrow=ncol(private$data),ncol=length(private$options))  
      dist.disc <- matrix(nrow=ncol(private$data),ncol=length(private$options))
      dist.disc2 <- matrix(nrow=ncol(private$data),ncol=length(private$options))
      colnames(dist.disc) <- private$options
      rownames(dist.disc) <- rnames
      colnames(dist.disc2) <- private$options
      rownames(dist.disc2) <- rnames
      colnames(dist.sel) <- private$options
      rownames(dist.sel) <- rnames
      
      for(i in 1:ncol(private$data)){
        for(o in 1:length(private$options)) {
          yk <- mean(total.score[which(private$data[,i]==private$options[o])])
          pk <- length(which(private$data[,i]==private$options[o]))/nrow(private$data)
          sdpk <- sqrt(pk*(1-pk))
          dist.sel[i,o]=pk
          dist.disc[i,o]=((yk-ybar)/sdt)*sqrt(pk/(1-pk))
          dist.disc2[i,o]=((dist.disc[i,o]*sdt)-sdpk)/sqrt(sdt^2+sdpk^2-(2*dist.disc[i,o]*sdt*sdpk))
        }
      }
      
      #             private$buildPlots()
      
      private$plots <- vector("list",ncol(private$data))
      
      for(i in 1:ncol(private$data)) {
        
        private$options.d <- c()
        for(u in 1:length(private$options)){ 
          if(private$correction==TRUE){
            private$options.d[u] <- paste(private$options[u],"( ",round(dist.disc2[i,u],2)," )",sep="")
          } else { private$options.d[u] <- paste(private$options[u],"( ",round(dist.disc[i,u],2)," )",sep="") }
        }
        
        d <- as.data.frame(cbind(sg=sgnum,p=prop[[i]][1,]))
        for(u in 2:length(private$options)){ d <- rbind(d,cbind(sg=sgnum,p=prop[[i]][u,]))}
        optt <- c()
        for(u in 1:length(private$options)){ optt <- c(optt,rep(private$options.d[u],ngroup))}
        d$opt <- optt
        
        
        p <- ggplot(d,aes(x=sg,y=p,group=opt,shape=opt))+
          geom_line()+
          geom_point(size=3)+
          ggtitle(paste("Item ",i,sep=""))+
          theme(panel.background = element_blank(),legend.title=element_blank(),legend.key = element_blank())+
          theme(legend.justification=c(0,1),legend.position=c(0,1),legend.text=element_text(size=12,face="bold"))+
          scale_x_continuous(limits = c(0,ncol(private$data)),breaks=0:ncol(private$data))+
          scale_y_continuous(limits = c(0,1))+xlab("Score Groups")+ylab("Proporion of Being Selected")
        
        private$plots[[i]] <- p
      } 
      
      cat("************************************************************************","\n")
      cat("ITEMAN: An R routine for Classical Item Analysis","\n")
      cat("","\n")
      cat("Cengiz Zopluoglu","\n")
      cat("","\n")
      cat("University of Miami","\n")
      cat("Department of Educational and Psychological Studies","\n")
      cat("Research, Measurement, and Evaluation Program","\n")
      cat("","\n")
      cat("c.zopluoglu@miami.edu","\n")
      cat("","\n")
      cat("Please report any programming bug or problem you experience to improve the code.","\n")
      cat("*************************************************************************","\n")
      
      cat("Processing Date: ",date(),"\n")
      
      cat(sprintf("%50s","ITEM STATISTICS"),"\n")
      cat("","\n")
      print(round(private$item.stat,3))
      cat("","\n")
      cat("","\n")
      cat("","\n")
      
      cat(sprintf("%50s","DISTRACTOR SELECTION PROPORTIONS"),"\n")
      cat("","\n")
      print(round(dist.sel,3))
      cat("","\n")
      cat("","\n")
      cat("","\n")
      
      if(correction==TRUE) {
        cat(sprintf("%50s","DISTRACTOR DISCRIMINATION - CORRECTED"),"\n")
      } else {cat(sprintf("%50s","DISTRACTOR DISCRIMINATION - UNCORRECTED"),"\n")}
      cat("","\n")
      if(correction==TRUE) {  print(round(dist.disc2,3)) } else {print(round(dist.disc,3))}
      cat("","\n")
      cat("","\n")
      cat("","\n")
      
#       return(list(plots=private$plots))
      
      #             return(self)
      self$itemanEnv = as.list(environment())
    },
    showReport = function() {
      
    }
  )
  ,
  private = list(
    correction = TRUE,
    data = NA,
    scored.data = NA,
    options = NA,
    options.d = NA,
    plots = NA,
    item.stat = NA,
    buildPlots = function() {
      
    }
  ) 
)
