getTerciles = function(x) {
  ## Input odin_zeus, output long df with terciles & proportions
  
  keyed = getKeyedTestNoID(x$test)
  raw = getRawTestNoID(x$test)
  scores = data.frame(scores = x$test_level$descriptives$scores)
  
  delscores = scores$scores - keyed
  
  ## Calculate deleted terciles
  terciles = sapply(delscores, function(x)
    findInterval(x, 
                 quantile(x, probs = c(0, 1/3, 2/3, 1)),
                 all.inside = TRUE)
  )
  
  ## Calculate proportion choosing each distractor
  
  tercsummary = melt(terciles) %>% 
    rename(tercile = value) %>% 
    left_join(melt(as.matrix(raw)) %>%
                rename(response = value)) %>%
    rename(id = Var1, item = Var2) %>%
    group_by(item, tercile, response) %>%
    summarize(count = n()) %>%
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
 # Loop over odin_zeus to generate item-level markdown
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
                     anti_join(this, by = c("item", "tercile", "response")))
  
  
  theplot = ggplot(thisfull, aes(x = tercile, y = prop, group = response,
                                 colour = response)) +
    geom_line() +
    geom_point() + 
    ggtitle("Distractors by tercile")
  
  theplot
    
}