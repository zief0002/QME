\name{split_half}
\alias{split_half}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Split-Half Reliability}
\description{This function computes the split-half reliability from the formula in Thorndike's measurement book.}
\usage{
split_half(x, method = "oddeven")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
x is a data frame consisting of the student(row) by item response(columns) matrix.
}
\item{method}{
"oddeven" splits the test on even and odd items (default). "random" selects items split at random  
}
}

\value{
The function returns the value of the correlation between the two split-halves of the test. In addition, the Spearman-Brown adjusted correlation is also returned.
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


data(beer)
# Odd-even split of the items
split_half(beer[,4:14])

# Random split of the items
split_half(beer[,4:14], method = "random")

# For reproducibility use \code{set.seed()} 
set.seed(100)
split_half(beer[,4:14], method = "random")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ measurement }
\keyword{ reliability }% __ONLY ONE__ keyword per line
