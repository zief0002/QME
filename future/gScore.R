#' Obtain and plot universe scores.
#'
#' This function facillitates obtaining estimates/predictions of universe scores for any potential object of measurement not nested in another facet (Brennan, 2001; i.e., the random main effects) and plotting them on a common vertical ruler/Wright map.
#'
#' @param gVar.out an object of class "G" produced by \code{\link{gVar}}.
#' @param score.universe logical if TRUE (default), then plot or return estimated universe scores; random effects otherwise.
#' @param plot.ruler a character string specifying either "dotplot" with 2-standard-error bars or "histogram" if a plot is desired; if NULL (default), then return a data frame containing estimates.
#' @param significant logical if TRUE, then the output will only contain scores or effects that are significantly different from the mean; otherwise (default) plot or return all estimates.
#' @details The histogram feature is necessary when the sources of variation contain a large number of levels.  Note that estimated/predicted universe scores and random effects are shrunk toward the mean based on \emph{generalizability} (i.e., not dependability at this time).  That is, universe scores provided by this function are simply the conditional modes of the random main effects (extracted by \code{\link{ranef}}) plus the fixed intercept (see Cronbach et al., 1950, equation 3.5).  A potential benefit of this function is that it will provide conditional universe scores arising from unbalanced situations (e.g., if persons were observed by different numbers of raters in the G study), which is common practice in multilevel modeling (Snijders & Bosker, 1999).
#' @references Brennan, R. L. (2001). \emph{Generalizability theory}. New York: Springer.
#' @references Cronbach, L. J., Gleser, G, C., Nanda, H., & Rajaratnam, N. (1972). \emph{The dependability of behavioral measurements}.  New York: John Wiley & Sons.
#' @references Snijders, T. A. B., & Bosker, R. J. (1999). \emph{Multilevel analysis: An introduction to basic and advanced multilevel modeling}. London: Sage Publications. 
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
#' #Estimated universe scores.
#' gScore(gVar.out)
#' 
#' #Plot vertical rulers.
#' gScore(gVar.out, plot.ruler = "dotplot")
#' gScore(gVar.out, plot.ruler = "histogram")
#' gScore(gVar.out, plot.ruler = "histogram", score.universe = FALSE)
#' 
gScore <- function(gVar.out, plot.ruler = NULL, score.universe = TRUE, significant = FALSE) {
  lmer.out <- attr(gVar.out, "mer")
  funk <- function(x) {
    data.frame(
      "ID" = row.names(x), 
      "Estimate" = x$"(Intercept)"
    )
  }
  data.plot <- data.frame(ldply(ranef(lmer.out), funk), "se" = unlist(se.ranef(lmer.out)))
  data.plot <- rename(data.plot, c(".id" = "Source"))
  if(significant == TRUE) {
      data.plot <- subset(data.plot, fixef(lmer.out) - 2 * se > 0 | fixef(lmer.out) + 2 * se < 0)
    if(nrow(data.plot) == 0) stop("Evidence is lacking that any universe score differs significantly from the mean.  Consider changing significant to TRUE to see all estimates.")
  }
  if(score.universe == TRUE) data.plot$Estimate <- fixef(lmer.out) + data.plot$Estimate
  data.plot$Lower <- with(data.plot, Estimate - 2 * se)
  data.plot$Upper <- with(data.plot, Estimate + 2 * se)
  data.plot$Name <- str_replace_all(paste(paste(str_split_fixed(data.plot$Source, ":", 2)[, 1], str_split_fixed(data.plot$ID, ":", 2)[, 1]), paste(str_split_fixed(data.plot$Source, ":", 2)[, 2], str_split_fixed(data.plot$ID, ":", 2)[, 2]), sep = ", "), ",  ", "")
  data.plot <- subset(data.plot, str_detect(Source, ":") == FALSE)
  data.plot$ID <- factor(data.plot$ID, levels = unique(data.plot$ID), ordered = TRUE)
  if(is.null(plot.ruler)) {
    data.plot
  } else {
    if(plot.ruler %in% c("histogram", "dotplot") == FALSE) stop('It appears that you intended to plot estimates, but plot.ruler is neither "histogram" nor "dotplot".  Please re-specify plot.ruler.')
    if(plot.ruler == "histogram") {
      ggplot.out <- ggplot(data = data.plot, aes(x = Estimate)) + 
        geom_histogram(color = "darkgrey", fill = "lightblue") + 
        facet_wrap( ~ Source, nrow = 1) + 
        coord_flip() + 
        labs(title = paste("Vertical ruler:", ifelse(score.universe == TRUE, "Universe scores", "Random intercepts")), y = "")
    } else {
      ggplot.out <- ggplot(data = data.plot, aes(x = ID, y = Estimate)) + 
        geom_errorbar(width = 0, aes(ymax = Upper, ymin = Lower), color = "blue") + 
        geom_point(size = 8, color = "white", shape = 18) + 
        geom_text(size = 4, aes(label = ID)) + 
        facet_grid(. ~ Source, scales = "free_x", space = "free") + 
        scale_x_discrete(breaks = NULL) + 
        labs(title = paste("Vertical ruler:", ifelse(score.universe == TRUE, "Universe scores", "Random intercepts")), x = "") + 
        theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
    }
    ggplot.out + theme_bw()
  }
}
