gVar <- function(data.g, formula.g) {
  lmer.out <- lme4::lmer(data = data.g, formula = formula.g)
  var.comp <- plyr::ldply(VarCorr(lmer.out))
  names(var.comp) <- c("Source", "Variance")
  var.comp <- rbind(var.comp, data.frame("Source" = "Residual", "Variance" = attr(lme4::VarCorr(lmer.out), "sc") ^ 2))
  var.comp$Percent <- round(var.comp$Variance / sum(var.comp$Variance) * 100, 1)
  attr(var.comp, "mer") <- lmer.out
  class(var.comp) <- c("data.frame", "G")
  var.comp
}
