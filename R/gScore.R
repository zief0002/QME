gScore <- function(gVar.out, plot.ruler = NULL, score.universe = TRUE, significant = FALSE) {
  lmer.out <- attr(gVar.out, "mer")
  funk <- function(x) {
    data.frame(
      "ID" = row.names(x), 
      "Estimate" = x$"(Intercept)"
    )
  }
  data.plot <- data.frame(plyr::ldply(lme4::ranef(lmer.out), funk), "se" = unlist(arm::se.ranef(lmer.out)))
  data.plot <- rename(data.plot, c(".id" = "Source"))
  if(significant == TRUE) {
    data.plot <- subset(data.plot, lme4::fixef(lmer.out) - 2 * se > 0 | lme4::fixef(lmer.out) + 2 * se < 0)
	if(nrow(data.plot) == 0) stop("Evidence is lacking that any universe score differs significantly from the mean.  Consider changing significant to TRUE to see all estimates.")
  }
  if(score.universe == TRUE) data.plot$Estimate <- lme4::fixef(lmer.out) + data.plot$Estimate
  data.plot$Lower <- with(data.plot, Estimate - 2 * se)
  data.plot$Upper <- with(data.plot, Estimate + 2 * se)
  data.plot$Name <- stringr::str_replace_all(paste(paste(stringr::str_split_fixed(data.plot$Source, ":", 2)[, 1], stringr::str_split_fixed(data.plot$ID, ":", 2)[, 1]), paste(stringr::str_split_fixed(data.plot$Source, ":", 2)[, 2], stringr::str_split_fixed(data.plot$ID, ":", 2)[, 2]), sep = ", "), ",  ", "")
  data.plot <- subset(data.plot, stringr::str_detect(Source, ":") == FALSE)
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
