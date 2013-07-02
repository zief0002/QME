\name{guttman_l1}
\alias{guttman_l1}

\title{
  Guttman's Lambda 1
}
\description{
  This function computes Guttman's Lambda 1, which is a lower bound for
  reliability, based on the characteristics of an individual test.
}
\usage{
guttman_l1(x)
}

\arguments{
  \item{x}{
    a matrix or data frame, with rows representing respondents and
    columns representing items.
  }
}

\value{
  The value of Guttman's Lambda 1, which is an estimate of reliability.  
}
\references{
  Guttman, L. (1945). A basis for analyzing test-retest
  reliability. \emph{Psychometrika}, \emph{10}(4), 255-282. 

  Revelle, W. (n.d.). \emph{An introduction to psychometric theory with
    applications in R: an overview}. Retrieved from \url{http://personality-project.org/r/book/}
}

\seealso{
  \code{\link{coef_alpha}} is a corrected version of Guttman's Lambda 1.
}

\author{
  University of Minnesota Quantitative Methods in Education
}

\examples{
data(LSAT, package = "ltm")
guttman_l1(LSAT)

## coef_alpha is just a correction of Guttman's Lambda 1
correction <- (ncol(LSAT)/(ncol(LSAT) - 1))
correction * guttman_l1(LSAT) - coef_alpha(LSAT) # ~0

}

\keyword{ measurement }
\keyword{ reliability }
