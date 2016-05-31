getTerciles = function(x) {
  ## Input analyze, output long df with terciles & proportions
  
  keyed = getKeyedTestNoID(x$test)
  rownames(keyed) = NULL
  
  raw = getRawTestNoID(x$test)
  rownames(raw) = NULL
  
  scores = data.frame(scores = x$test_level$descriptives$scores, check.names = FALSE)
  
  delscores = scores$scores - keyed
  
  ## Calculate deleted terciles
  terciles = vapply(delscores, function(x) {
    out = findInterval(x, 
                 quantile(x, probs = c(0, 1/3, 2/3, 1), type = 1),
                 all.inside = TRUE),
    if(!all(1:3 %in% out))
      warning("Some columns do not have values for all 3 terciles.")
    
    out
  },
    FUN.VALUE = rep(1, nrow(delscores))
  )
  
  terciles = as.data.frame(terciles)
  
  ## Calculate proportion choosing each distractor by tercile
  tercile_response = mapply(function(x, y) {
    
    df =  as.data.frame(prop.table(table(x, y, useNA = "ifany"), 
                                   margin = 1),
                        stringsAsFactors = TRUE)
    names(df) = c("tercile", "response", "prop")
    df$tercile = factor(df$tercile,
                        levels = 1:3,
                        labels = c("Low", "Medium", "High"))
    
    ## Relabel missing values as "Missing" for plots
    df$response =  addNA(df$response, ifany = TRUE)
    levels(df$response)[is.na(levels(df$response))] = "Missing"
    
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

tercile_plot = function(terciles) {
 # plot the tercile plot for a given item, given the summary component from
 # getTerciles()

  theplot = ggplot(terciles, aes(x = tercile, y = prop, group = response,
                                 colour = response)) +
    geom_line() +
    geom_point() + 
    ylim(c(0, 1)) + 
    ggtitle("Distractors by tercile") +
    labs(x = "Tercile",
         y = "Proportion")
  
  theplot
    
}
