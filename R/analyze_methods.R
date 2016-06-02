## Utility functions for analyze objects
#' @param x An \code{analyze} object

## Get the QMETest method for an analyze object
getQMEtest = function(x) 
  x$test


#' Get the reliability from an \code{analyze} object
#' 
getReliability = function(x) 
  x$test_level$reliability

#' Get the deleted alphas from an \code{analyze} object
getDelAlpha = function(x) {
  dalph = data.frame(x$item_level$del_alphas)
  names(dalph) = "Alpha (if Item Deleted)" 
  dalph
}

#' Get the item overview for a \code{analyze} object
getItemOverview = function(x) {
  
  overview = data.frame(x$item_level$item_stats, x$item_level$missing)
  names(overview) = c("Difficulty", "PBiS", "Corrected PBiS", "Missing (N)", "Missing (p)")
  overview
}

#' Plot of item overview
plotItemOverview = function(overview) {
  ggplot(overview, aes(x = Difficulty)) + 
    geom_dotplot() + 
    scale_y_continuous(name = "", breaks = NULL) +
    scale_x_continuous("Difficulty", lim = c(0,1)) +
    theme_bw() +
    ggtitle("Item Difficulties")
  
}