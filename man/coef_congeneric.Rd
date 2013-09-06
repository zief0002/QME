\name{coef_congeneric}
\alias{coef_congeneric}
\title{Estimate congeneric reliability.}
\usage{
  coef_congeneric(x, N = NULL, vcov = TRUE)
}
\arguments{
  \item{x}{a variance-covariance matrix calculated from item responses to be passed to \code{\link{sem}}; alternatively, an item response matrix or data frame containing one object of measurement (e.g., person) per row and one item per column.  If the latter, then \code{vcov} must be \code{FALSE}.}
  
  \item{N}{the number of objects of measurement (e.g., persons, respondents, rows) underlying the variance-covariance matrix; defaults to the number of rows if \code{vcov} is \code{FALSE}.}
  
  \item{vcov}{if \code{TRUE}, then \code{x} must be a variance-covariance matrix and \code{N} must be specified; if \code{FALSE}, then \code{x} is an item response matrix}
}
\description{
  This function estimates the congeneric reliability of observed scores.  Estimating congeneric reliability is appropriate when items are stratified or lack a common scale (e.g., when a test contains both dichotomously and polytomously scored items).  As discussed by Graham (2006), it is not widely known in applied educational research that Cronbach's alpha assumes essential tau-equivalence and underestimates reliability when the assumption is not met.  This function uses Fox's \code{\link{sem}} package to conduct a confirmatory factor analysis with minimal constraints (variance of common true score fixed at 1 for identifiability). The estimated loadings and error variances are then summed to calculate reliability as the ratio of true- to observed-score variance.
}
\author{
  Christopher T. Moore \email{moor0554@umn.edu}
}
\value{Returns the congeneric reliability coefficient.}
\references{
Graham, J. M. (2006). Congeneric and (essentially) tau-equivalent estimates of score reliability: What they are and how to use them. \emph{Educational and Psychological Measurement, 66}, 6, 930-944. 

Raykov, T. (2001). \emph{Scale reliability evaluation with LISREL 8.50}. Retrieved from \url{http://www.ssicentral.com/lisrel/techdocs/reliabil.pdf}
}
\examples{
data(Graham)
Graham

#Tau-equivalent
congeneric.out <- coef_congeneric(x = Graham[1:5, 1:5], N = 60)
congeneric.out
library(psych)
if(require(psych)) psych::alpha(attr(congeneric.out, "cfa")$S)$total$raw_alpha

#Tau-inequivalent
congeneric.out <- coef_congeneric(x = Graham[c(1:4, 7), c(1:4, 7)], N = 60)
congeneric.out
if(require(psych)) psych::alpha(attr(congeneric.out, "cfa")$S)$total$raw_alpha

#LSAT data
library(ltm)
congeneric.out <- coef_congeneric(x = LSAT, vcov = F)
congeneric.out
coef_alpha(LSAT)
split_half(LSAT)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ measurement }
\keyword{ reliability }
