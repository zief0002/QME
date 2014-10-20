\name{gVar}
\alias{gVar}
\title{Estimate generalizability study variance components.}
\usage{
  gVar(data.g, formula.g)
}
\arguments{
  \item{data.g}{data frame in long format with a column for
  item scores and columns for sources of variance.}

  \item{formula.g}{a formula specifying the model to be
  estimated by \code{\link{lmer}}.}
}
\description{
  This function estimates variance components for the
  object of measurement (e.g., person) and facets (e.g.,
  rater) from a generalizability study.  The variance
  components can then be used to conduct generalizability
  (G) and decision (D) studies.  Note that the data must be
  in long format (one item score per row) and factors must
  be classified as such.
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

#lmer object is an attribute.
attr(gVar.out, "mer")
}
\references{
  Brennan, R. L. (2001). \emph{Generalizability theory}.
  New York: Springer.
}

