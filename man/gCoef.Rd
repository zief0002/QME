\name{gCoef}

\alias{gCoef}

\title{Calculate generalizability and/or dependability.}

\description{This function calculates generalizability and/or dependability coefficients from estimated generalizability study variance components.  This function also returns relative and/or absolute error variances and standards or measurement.}

\arguments{
  \item{gVar.out}{data frame consisting of a column named "Source" containing named sources of variation, a column named "Variance" containing estimated variance components, and a column named "N" containing the number of conditions by which variance components will be divided.}
  \item{object}{a character string specifying which named source of variation is the object of measurement.}
  \item{type}{a character string taking the value of "both" (default), "relative", or "absolute".}
}

\references{
  item{Brennan, R. L. (2001). \emph{Generalizability theory}. New York: Springer.}
  item{Shavelson, R. J., & Webb, N. M. (1991). \emph{Generalizability theory: A primer}. New York: Sage Publications.}
}

\author{Christopher T. Moore \email{moor0554@@umn.edu}}

\details{Users of this function must carefully specify the appropriate number of conditions/sample sizes for  each source of variation (i.e., the denominators).  If completing a generalizability (G) study, N contains the number of conditions from the data collection design.  If conducting a decision (D) study, N can be a vector of sample sizes from a proposed design.}

\value{a data frame containing containing error variance(s), standard error(s) of measurement, and coefficient(s) for a given design.}

\examples{
########################################
#An example in which all facets are considered random.

#Load Brennan's (2001) data set number 4.
data(Brennan.4)
head(Brennan.4)
sapply(Brennan.4, class)

#Estimate generalizability study variance components.
formula.Brennan.4 <- as.formula("Score ~ (1 | Person) + (1 | Item) + (1 | Rater:Item) + (1 | Person:Item)")
gVar.out <- gVar(data.g = Brennan.4, formula.g = formula.Brennan.4)
gVar.out

#Complete G study.
gVar.out$N <- c(3, 12, 1, 3, 12)
gCoef(gVar.out)

#Conduct a D study asking, "What is the effect of adding a task (item)?"
gVar.out$N <- c(4, 12, 1, 4, 12)
gCoef(gVar.out)

#Conduct a D study by "looping" over combinations of possible numbers of conditions.
array.denominator <- expand.grid(list("Raters" = 1 : 12, "Items" = 1 : 6))
head(array.denominator)
tail(array.denominator)
funk.N <- function(x) {
  Items <- x$Items
  Raters <- x$Raters
  N <- ifelse(str_detect(gVar.out$Source, "Rater") | str_detect(gVar.out$Source, "Residual"), Raters, 1) * 
    ifelse(str_detect(gVar.out$Source, "Item") | str_detect(gVar.out$Source, "Residual"), Items, 1)
  gVar.out$N <- N
  gVar.out
}
list.gVar.out <- alply(array.denominator, 1, funk.N)
list.gVar.out[1:2]
d.out <- ldply(list.gVar.out, function(x) gCoef(gVar.out = x))
head(d.out)
tail(d.out)

#Plot results of D study.
data.plot <- d.out
data.plot$Items <- factor(data.plot$Items)
data.plot.observed <- subset(data.plot, Raters == 4 & Items == 3)
funk.plot.d <- function(y, title, ylab) {
  ggplot.out <- ggplot(data = data.plot, aes_string(x = "Raters", y = y)) +
    geom_line(lwd = 1, aes(linetype = Items, color = Items)) +
    geom_point(data = data.plot.observed, size = 3, aes_string(x = "Raters", y = y)) +
    geom_text(data = data.plot.observed, size = 3, label = "Observed", vjust = -1, aes_string(x = "Raters", y = y)) +
    scale_color_brewer(palette = "YlOrRd") +
    scale_x_continuous(breaks = min(data.plot$Raters) : max(data.plot$Raters)) + 
    labs(title = title, y = ylab) +
    theme(legend.box = "horizontal", legend.position = "bottom")
  if(y %in% c("Generalizability", "Dependability")) {
    ggplot.out <- ggplot.out + scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1))
  } else {
    ggplot.out <- ggplot.out + scale_y_continuous(limits = c(0, max(data.plot[, y])))
  }
  ggplot.out + theme_bw()
}
funk.plot.d(y = "RelativeErrorVariance", title = "Decision study: Relative error variance", ylab = expression(paste(hat(sigma) ^ 2, "(", delta, ")")))
funk.plot.d(y = "RelativeSEM", title = "Decision study: Relative standard error of measurement", ylab = expression(paste(hat(sigma), "(", delta, ")")))
funk.plot.d(y = "Generalizability", title = "Decision study: Generalizability of scores for relative decisions", ylab = expression(widehat(paste(symbol(E), rho ^ 2))))
funk.plot.d(y = "AbsoluteErrorVariance", title = "Decision study: Absolute error variance", ylab = expression(paste(hat(sigma) ^ 2, "(", Delta, ")")))
funk.plot.d(y = "AbsoluteSEM", title = "Decision study: Absolute standard error of measurement", ylab = expression(paste(hat(sigma), "(", Delta, ")")))
funk.plot.d(y = "Dependability", title = "Decision study: Dependability of scores for relative decisions", ylab = expression(hat(phi)))

########################################
#An example in which one facet is considered fixed.

#Load havelson and Webb's (1991) data set number 5.1.
data(Shavelson.Webb.5.1)
head(Shavelson.Webb.5.1)
sapply(Shavelson.Webb.5.1, class)

#Estimate generalizability study variance components.
formula.Shavelson.Webb.5.1 <- as.formula("Score ~ (1 | Person) + (1 | Rater) + (1 | Subject) + (1 | Person : Rater) + (1 | Person : Subject) + (1 | Subject : Rater)")
gVar.out <- gVar(data.g = Shavelson.Webb.5.1, formula.g = formula.Shavelson.Webb.5.1)
gVar.out

#Average over conditions of the fixed facet.
n.fixed <- length(levels(Shavelson.Webb.5.1$Subject))
attr.mer.temp <- attr(gVar.out, "mer")
gVar.out <- data.frame(
  "Source" = c("Person", "Rater", "Residual"), 
  "Variance" = rbind(
    subset(gVar.out, Source == "Person", select = "Variance") + subset(gVar.out, Source == "Person:Subject", select = "Variance") / n.fixed, 
    subset(gVar.out, Source == "Rater", select = "Variance") + subset(gVar.out, Source == "Subject:Rater", select = "Variance") / n.fixed, 
    subset(gVar.out, Source == "Person:Rater", select = "Variance") + subset(gVar.out, Source == "Residual", select = "Variance") / n.fixed
  )
) 
gVar.out$Percent <- round(gVar.out$Variance / sum(gVar.out$Variance) * 100, 1)
attr(gVar.out, "mer") <- attr.mer.temp
gVar.out

#Complete G study.
gVar.out$N <- c(1, 3, 3)
gCoef(gVar.out)

#Conduct a D study asking, "What is the effect of adding a rater?"
gVar.out$N <- c(1, 4, 4)
gCoef(gVar.out)

#Conduct D study by "looping" over combinations of possible counts.
array.denominator <- expand.grid(list("Raters" = 1 : 6))
head(array.denominator)
tail(array.denominator)
funk.N <- function(x) {
  Raters <- x$Raters
  N <- ifelse(str_detect(gVar.out$Source, "Rater") | str_detect(gVar.out$Source, "Residual"), Raters, 1)
  gVar.out$N <- N
  gVar.out
}
list.gVar.out <- alply(array.denominator, 1, funk.N)
list.gVar.out[1:2]
d.out <- ldply(list.gVar.out, function(x) gCoef(gVar.out = x))
head(d.out)
tail(d.out)

#Plot results of D study.
data.plot <- d.out
data.plot.observed <- subset(data.plot, Raters == 3)
funk.plot.d <- function(y, title, ylab) {
  ggplot.out <- ggplot(data = data.plot, aes_string(x = "Raters", y = y)) + 
    geom_line(lwd = 1, color = "blue") + 
    geom_point(data = data.plot.observed, size = 3, aes_string(x = "Raters", y = y)) + 
    geom_text(data = data.plot.observed, size = 3, label = "Observed", vjust = -1, aes_string(x = "Raters", y = y)) + 
    labs(title = title, y = ylab) + 
    theme(legend.box = "horizontal", legend.position = "bottom")
  if(y %in% c("Generalizability", "Dependability")) {
    ggplot.out <- ggplot.out + scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1))
  } else {
    ggplot.out <- ggplot.out + scale_y_continuous(limits = c(0, max(data.plot[, y])))
  }
  ggplot.out + theme_bw()
}
funk.plot.d(y = "RelativeErrorVariance", title = "Decision study: Relative error variance", ylab = expression(paste(hat(sigma) ^ 2, "(", delta, ")")))
funk.plot.d(y = "RelativeSEM", title = "Decision study: Relative standard error of measurement", ylab = expression(paste(hat(sigma), "(", delta, ")")))
funk.plot.d(y = "Generalizability", title = "Decision study: Generalizability of scores for relative decisions", ylab = expression(widehat(paste(symbol(E), rho ^ 2))))
funk.plot.d(y = "AbsoluteErrorVariance", title = "Decision study: Absolute error variance", ylab = expression(paste(hat(sigma) ^ 2, "(", Delta, ")")))
funk.plot.d(y = "AbsoluteSEM", title = "Decision study: Absolute standard error of measurement", ylab = expression(paste(hat(sigma), "(", Delta, ")")))
funk.plot.d(y = "Dependability", title = "Decision study: Dependability of scores for relative decisions", ylab = expression(hat(phi)))
}