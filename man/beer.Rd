\name{beer}
\docType{data}
\alias{beer}
\title{Data from the 2011 Atlanta Beer Survey}
\description{
  The data come from the 2011 Atlanta beer survey. The six items included here are a subset of items asked on a larger beer survey. Each of these items were Likert-scaled from Very Unlikely to Very Likely (1 = Very Unlikely; 2 = Unlikely; 3 = Undecided; 4 = Likely; 5 = Very Likely). In order, the items asked
}

\itemize{
  \item{subject}{Subject ID number}
  \item{massMarket}{How likely are you to consume American-style Mass Market beers (e.g., Budweiser, Coors, Miller, PBR)?}
  \item{lager}{How likely are you to consume Lagers and Pilsners (e.g., Heineken, Amstel, Stella Artois, Corona, Warsteiner)?}
  \item{wheat}{How likely are you to consume Wheat beers (e.g., Hefeweizen, Hoegaarden, Paulaner)?}
  \item{paleAle}{How likely are you to consume Pale Ales and IPAs (e.g., Bass Ale, Sierra Nevada, Dogfish)?}
  \item{brown}{How likely are you to consume Brown Ales (e.g., Newcastle, Samuel Smith)?}
  \item{stout}{How likely are you to consume Stouts and Porters (e.g., Guinness, Taddy)?}
}
\format{A data frame containing 61 rows (cases) and 7 columns (variables).}
\examples{
data(beer)
head(beer)
# Compute Coefficient Alpha for the six items
coef_alpha(beer[2:7])
}
\author{
  Andrew Zieffler \email{zief0002@umn.edu}
}
% \references{
%   Brennan, R. L. (2001). \emph{Generalizability theory}.
%   New York: Springer.
% }
\keyword{data}
\keyword{datasets}

