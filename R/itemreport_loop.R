getTerciles = function(x) {
  ## Input analyze, output long df with terciles & proportions
  
  keyed = getKeyedTestNoID(x$test)
  rownames(keyed) = NULL
  
  raw = getRawTestNoID(x$test)
  rownames(raw) = NULL
  
  scores = data.frame(scores = x$test_level$descriptives$scores, check.names = FALSE)
  
  delscores = scores$scores - keyed
  
  ## Calculate deleted terciles
  terciles = vapply(delscores, function(x)
    findInterval(x, 
                 quantile(x, probs = c(0, 1/3, 2/3, 1)),
                 all.inside = TRUE),
    FUN.VALUE = rep(1, nrow(delscores))
  )
  
  terciles = as.data.frame(terciles)
  
  ## Calculate proportion choosing each distractor by tercile
  tercile_response = mapply(function(x, y) {
    
    df =  as.data.frame(prop.table(table(x, y, useNA = "ifany"), 
                                   margin = 1))
    names(df) = c("tercile", "response", "prop")
    df$tercile = factor(df$tercile,
                        labels = c("Low", "Medium", "High"))
    
    
    df
    
    },
    terciles, 
    raw,
    SIMPLIFY = FALSE)
  
  tercile_response
}

item_names = function(x) {
  # Get the item names.  This should really be preserved & consistently applied in the 
  # item-level methods
  names(getRawTestNoID(x$test))
}  

##' @import ggplot2

itemreport_loop = function(x, itemnum = 1) {
 # Loop over analyze to generate item-level markdown
  tercsummary = getTerciles(x)
  
  thisitem = item_names(x)[itemnum]
  
  this = tercsummary[[thisitem]]
  
  this$response = addNA(this$response, ifany = TRUE)
    
  ## Relabel missing values as "Missing" for plots
  levels(this$response)[is.na(levels(this$response))] = "Missing"
  
  theplot = ggplot(this, aes(x = tercile, y = prop, group = response,
                                 colour = response)) +
    geom_line() +
    geom_point() + 
    ylim(c(0, 1)) + 
    ggtitle("Distractors by tercile") +
    labs(x = "Tercile",
         y = "Proportion")
  
  theplot
    
}
