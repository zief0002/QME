\name{coef_alpha}
\alias{coef_alpha}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Coefficient Alpha
}
\description{
This function computes coefficient alpha using the covariance matrix
}
\usage{
coef_alpha(x)
}
\arguments{
  \item{x}{
x is a data frame or matrix consisting of cases (row) by item response(columns) matrix.
}
}

\value{
It returns the value of coefficient alpha.
}
\references{
Cronbach, L. (1951). Coefficient alpha and the internal structure of tests. \emph{Psychometrika, 16(3), 297-334}
Thorndike, R. M. \& Thorndike-Christ, T. (2010).\emph{ Measurement and evaluation in psychology and education. (8th ed.)} Boston: Pearson. 
}
\author{
University of Minnesota Quantitative Methods in Education
}


%%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%%}
\examples{


library(ltm)
coef_alpha(LSAT)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ measurement }
\keyword{ reliability }% __ONLY ONE__ keyword per line
