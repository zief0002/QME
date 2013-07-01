#' Estimate generalizability study variance components.
#'
#' This function estimates variance components for the object of measurement (e.g., person) and facets (e.g., rater) from a generalizability study.  The variance components can then be used to conduct generalizability (G) and decision (D) studies.  Note that the data must be in long format (one item score per row) and factors must be classified as such.
#'
#' @param data.g data frame in long format with a column for item scores and columns for sources of variance
#' @param formula.g a formula specifying the model to be estimated by \code{\link{lmer}}
#' @references Brennan, R. L. (2001). \emph{Generalizability theory}. New York: Springer.
#' @export
#' @examples
#' #Load Brennan's (2001) synthetic data set number 4.
#' data(Brennan.4)
#' head(Brennan.4)
#' sapply(Brennan.4, class)
#' 
#' #Estimate generalizability study variance components.
#' formula.Brennan.4 <- as.formula("Score ~ (1 | Person) + (1 | Item) + (1 | Rater:Item) + (1 | Person:Item)")
#' gVar.out <- gVar(data.g = Brennan.4, formula.g = formula.Brennan.4)
#' gVar.out
#' 
#' #lmer object is an attribute.
#' attr(gVar.out, "mer")
#' 
gVar <- function(data.g, formula.g) {
  lmer.out <- lmer(data = data.g, formula = formula.g)
  var.comp <- ldply(VarCorr(lmer.out))
  names(var.comp) <- c("Source", "Variance")
  var.comp <- rbind(var.comp, data.frame("Source" = "Residual", "Variance" = attr(VarCorr(lmer.out), "sc") ^ 2))
  var.comp$Percent <- round(var.comp$Variance / sum(var.comp$Variance) * 100, 1)
  attr(var.comp, "mer") <- lmer.out
  class(var.comp) <- c("data.frame", "G")
  var.comp
}
