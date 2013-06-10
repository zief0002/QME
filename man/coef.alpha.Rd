\name{coef_alpha}
\alias{coef_alpha}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Coefficient Alpha
}
\description{
This function computes coefficient alpha from the formula in Thorndike's measurement book
}
\usage{
coef_alpha(x,k,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
x is a data frame consisting of the student(row) by item response(columns) matrix.
}
\item{k}{
k is the number of items on the test.  If k is not entered, it will be computed based on the number of columns.
}
}

\value{
It returns the value of coefficient alpha.
}
\references{
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
