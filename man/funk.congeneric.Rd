\name{funk.congeneric}
\alias{funk.congeneric}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Congeneric Reliability
}
\description{
This function computes the congeneric reliability coefficient, which is especially useful when items are stratified or lack a common scale.  As discussed by Graham (2006), it's not widely known in applied educational research that Cronbach's alpha assumes essential tau-equivalence and underestimates reliability when the assumption is not met.  This function uses Fox's \code{\link{sem}} package to conduct a confirmatory factor analysis with minimal constraints (variance of common true score fixed at 1 for identifiability). The estimated loadings and error variances are then summed to calculate reliability (i.e., the ratio of true score variance to observed score variance).
}
\usage{
funk.congeneric(x, N)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
x is a variance-covariance matrix calculated from item responses to be passed to \code{\link{sem}}.
}
  \item{N}{
N is the number of objects of measurement (e.g., persons, respondents, rows) underlying the variance-covariance matrix.
}
}

\value{
This function returns the congeneric reliability coefficient.
}
\references{
Graham, J. M. (2006). Congeneric and (essentially) tau-equivalent estimates of score reliability: What they are and how to use them. Educational and Psychological Measurement, 66, 6, 930-944. 
}
\author{
University of Minnesota Quantitative Methods in Education
}

%%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%%}

\examples{
S.Graham <- readMoments(diag = T, names = paste("x", 1:7, sep = ""))
4.98
4.60  5.59
4.45  4.42  6.30
3.84  3.81  3.66  6.44
5.71  5.67  5.52  4.91 11.86
23.85 23.68 22.92 19.87 34.28 127.65 
46.53 46.20 44.67 38.57 62.30 244.36 471.95

#Tau-equivalent
congeneric.out <- funk.congeneric(x = S.Graham[1:5, 1:5], N = 60)
congeneric.out
library(psych)
alpha(attr(congeneric.out, "cfa")$S)$total$raw_alpha

#Tau-inequivalent
congeneric.out <- funk.congeneric(x = S.Graham[c(1:4, 7), c(1:4, 7)], N = 60)
congeneric.out
alpha(attr(congeneric.out, "cfa")$S)$total$raw_alpha
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ measurement }
\keyword{ reliability }% __ONLY ONE__ keyword per line
