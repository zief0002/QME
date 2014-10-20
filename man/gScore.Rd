\name{gScore}
\alias{gScore}
\title{Obtain and plot universe scores.}
\usage{
  gScore(gVar.out, plot.ruler = NULL,
    score.universe = TRUE, significant = FALSE)
}
\arguments{
  \item{gVar.out}{an object of class "G" produced by
  \code{\link{gVar}}.}

  \item{score.universe}{logical if TRUE (default), then
  plot or return estimated universe scores; random effects
  otherwise.}

  \item{plot.ruler}{a character string specifying either
  "dotplot" with 2-standard-error bars or "histogram" if a
  plot is desired; if NULL (default), then return a data
  frame containing estimates.}

  \item{significant}{logical if TRUE, then the output will
  only contain scores or effects that are significantly
  different from the mean; otherwise (default) plot or
  return all estimates.}
}
\description{
  This function facillitates obtaining
  estimates/predictions of universe scores for any
  potential object of measurement not nested in another
  facet (Brennan, 2001; i.e., the random main effects) and
  plotting them on a facet-object map (e.g., an
  item-person map).
}
\details{
  The histogram feature is necessary when the sources of
  variation contain a large number of levels.  Note that
  estimated/predicted universe scores and random effects
  are shrunk toward the mean based on
  \emph{generalizability} (i.e., not dependability at this
  time).  That is, universe scores provided by this
  function are simply the conditional modes of the random
  main effects (extracted by \code{\link{ranef}}) plus the
  fixed intercept (see Cronbach et al., 1950, equation
  3.5).  A potential benefit of this function is that it
  will provide conditional universe scores arising from
  unbalanced situations (e.g., if persons were observed by
  different numbers of raters in the G study), which is
  common practice in multilevel modeling (Snijders &
  Bosker, 1999).
}
\author{
  Christopher T. Moore \email{moor0554@umn.edu}
}
\examples{
#Load Brennan's (2001) synthetic data set number 4.
data(Brennan.4)
head(Brennan.4)
sapply(Brennan.4, class)

#Estimate generalizability study variance components.
formula.Brennan.4 <- as.formula("Score ~ (1 | Person) + (1 | Item) + (1 | Rater:Item) + (1 | Person:Item)")
gVar.out <- gVar(data.g = Brennan.4, formula.g = formula.Brennan.4)
gVar.out

#Estimated universe scores.
gScore(gVar.out)

#Plot vertical rulers.
gScore(gVar.out, plot.ruler = "dotplot")
gScore(gVar.out, plot.ruler = "histogram")
gScore(gVar.out, plot.ruler = "histogram", score.universe = FALSE)
}
\references{
  Brennan, R. L. (2001). \emph{Generalizability theory}.
  New York: Springer.

  Cronbach, L. J., Gleser, G, C., Nanda, H., & Rajaratnam,
  N. (1972). \emph{The dependability of behavioral
  measurements}.  New York: John Wiley & Sons.

  Snijders, T. A. B., & Bosker, R. J. (1999).
  \emph{Multilevel analysis: An introduction to basic and
  advanced multilevel modeling}. London: Sage Publications.
}

