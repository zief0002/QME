#' Apply generalizability theory with R.
#'
#' This package contains functions for estimating variance components, generalizability (G) coefficients, and universe scores when observed scores contain variation from one or more admissable measurement facets (e.g., items and raters).  It only applies univariate G theory at this time.
#'
#' @name gtheory-package
#' @aliases gtheory
#' @docType package
#' @title Apply generalizability theory with R.
#' @author Christopher T. Moore \email{moor0554@@umn.edu}
#' @keywords package
#' 
NULL
#' Brennan's (2001) data set number 4
#'
#' Brennan's (2001) synthetic data set number 4 contains item scores from a two-facet person * (rater : task) generalizability (G) study.  Note that the data are in long format (one item score per row), that the factors are classified as such, and that tasks are referred to as items.
#'
#' @param Brennan.4 data frame in long format with a column for item scores and columns for sources of variance
#' @name Brennan.4
#' @docType data
#' @author Christopher T. Moore \email{moor0554@@umn.edu}
#' @keywords data
#' @references Brennan, R. L. (2001). \emph{Generalizability theory}. New York: Springer.
#' @examples
#' data(Brennan.4)
#' head(Brennan.4)
#' sapply(Brennan.4, class)
#' 
NULL
#' Shavelson and Webb's (1991) data set number 5.1
#'
#' Shavelson and Webb's (1991) data set (table) number 5.1 contains item scores from a two-facet person * rater * subject generalizability (G) study with subject considered fixed.  Note that the data are in long format (one item score per row) and that the factors are classified as such.
#'
#' @param Shavelson.Webb.5.1 data frame in long format with a column for item scores and columns for sources of variance
#' @name Shavelson.Webb.5.1
#' @docType data
#' @author Christopher T. Moore \email{moor0554@@umn.edu}
#' @keywords data
#' @references Shavelson, R. J., & Webb, N. M. (1991). \emph{Generalizability theory: A primer}. New York: Sage Publications.
#' @examples
#' data(Shavelson.Webb.5.1)
#' head(Shavelson.Webb.5.1)
#' sapply(Shavelson.Webb.5.1, class)
#' 
NULL