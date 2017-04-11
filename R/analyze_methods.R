## Utility functions for analyze objects
## @param x An \code{analyze} object

## Get the QMETest method for an analyze object
getQMEtest = function(x) 
  x$test


## Get the reliability from an \code{analyze} object
## 
getReliability = function(x) 
  x$test_level$reliability

## Get the deleted alphas from an \code{analyze} object
# getDelAlpha = function(x) {
#   dalph = data.frame(x$item_level$del_alphas)
#   names(dalph) = "Alpha (if Item Deleted)" 
#   dalph
# }

## Get the item overview for a \code{analyze} object
getItemOverview = function(x) {
  x_qt = getQMEtest(x)
  if(getDichotomous(x_qt)) {
    corrname = "Corrected PBiS"
    lim = c(0, 1)
  }
  else {
    corrname = "Corrected Item-Total"
    lim = range(getKeyedTestNoID(x_qt))
  }
  overview = data.frame(x$item_level$item_stats, x$item_level$missing)
  names(overview) = c("Difficulty", corrname, "Missing (N)", "Missing (p)")
  attr(overview, "lim") = lim
  overview
}

## Plot of item overview
plotItemOverview = function(overview) {
  lim = attr(overview, "lim")
  
  ggplot(overview, aes(x = Difficulty)) + 
    geom_dotplot() + 
    scale_y_continuous(name = "", breaks = NULL) +
    scale_x_continuous("Difficulty", lim = lim) +
    theme_bw() +
    ggtitle("Item Difficulties")
  
}

getTotalScoresAnalyze = function(x)
  x$total_scores