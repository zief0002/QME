getTerciles = function(x) {
  ## Input analyze, output long df with terciles & proportions
  
  keyed = getKeyedTestNoID(x$test) %>% set_rownames(NULL)
  raw = getRawTestNoID(x$test) %>% set_rownames(NULL)
  scores = data.frame(scores = x$test_level$descriptives$scores, check.names = FALSE)
  
  delscores = scores$scores - keyed
  
  ## Calculate deleted terciles
  terciles = sapply(delscores, function(x)
    findInterval(x, 
                 quantile(x, probs = c(0, 1/3, 2/3, 1)),
                 all.inside = TRUE)
  )
  
  ## Calculate proportion choosing each distractor
  ## THIS MERGE IS DEPENDENT ON ROWNAMES! This is why I had to remove them, above
  tercsummary = melt(terciles) %>% 
    dplyr::rename(tercile = value) %>% 
    left_join(melt(as.matrix(raw)) %>%
                dplyr::rename(response = value)) %>%
    dplyr::rename(id = Var1, item = Var2) %>%
    group_by(item, tercile, response) %>%
    dplyr::summarize(count = n()) %>%
    group_by(item, tercile) %>%
    mutate(total = sum(count),
           prop = count/total) %>%
    ungroup() %>%
    mutate(tercile = ordered(tercile, labels = 
                               c("Low", "Medium", "High")))
  
  tercsummary
}

item_names = function(x) {
  # Get the item names.  This should really be preserved & consistently applied in the 
  # item-level methods
  names(getRawTestNoID(x$test))
}  


itemreport_loop = function(x, itemnum = 1) {
 # Loop over analyze to generate item-level markdown
  tercsummary = getTerciles(x)
  
  thisitem = item_names(x)[itemnum]
  
  this = tercsummary[tercsummary$item %in% thisitem,]
  
  fillzeros = with(this, 
                   expand.grid(unique(item), unique(tercile), unique(response))) %>%
    set_names(names(tercsummary)[1:3]) %>%
    mutate(count = 0,
           total = 0,
           prop = 0)
  
  thisfull = rbind(this, 
                   fillzeros %>% 
                     anti_join(this, by = c("item", "tercile", "response"))) %>% 
    mutate(response = addNA(response, ifany = TRUE))  # add NA as level for relabeling
  
  ## Relabel missing values as "Missing" for plots
  levels(thisfull$response)[is.na(levels(thisfull$response))] = "Missing"
  
  theplot = ggplot(thisfull, aes(x = tercile, y = prop, group = response,
                                 colour = response)) +
    geom_line() +
    geom_point() + 
    ylim(c(0, 1)) + 
    ggtitle("Distractors by tercile") +
    labs(x = "Tercile",
         y = "Proportion")
  
  theplot
    
}
