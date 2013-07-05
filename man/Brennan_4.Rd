\docType{data}
\name{Brennan_4}
\alias{Brennan_4}
\title{Brennan's (2001) data set number 4}
\arguments{
  \item{Brennan_4}{data frame in long format with a column
  for item scores and columns for sources of variance}
}
\description{
  Brennan's (2001) synthetic data set number 4 contains
  item scores from a two-facet person * (rater : task)
  generalizability (G) study.  Note that the data are in
  long format (one item score per row), that the factors
  are classified as such, and that tasks are referred to as
  items.
}
\examples{
data(Brennan_4)
head(Brennan_4)
sapply(Brennan_4, class)
}
\author{
  Christopher T. Moore \email{moor0554@umn.edu}
}
\references{
  Brennan, R. L. (2001). \emph{Generalizability theory}.
  New York: Springer.
}
\keyword{data}
\keyword{datasets}

