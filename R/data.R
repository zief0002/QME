#' Item-level scores for 30 students on a math test
#' 
#' Contains item-level scores for 30 students and 10 items, in the 
#' format required by \code{\link{analyze}}: one row per student, one column per
#' item, starting with an \code{id} column. See \code{vignette("scoring")}.
#' 
#' @format A data frame with an \code{id} column, indicating the student, and 10 subsequent columns for each item
#' @seealso \code{\link{math_key}}, \code{\link{math_full_key}}
"math"

#' Simple key for \code{math} dataset
#' 
#' Contains correct answers for \code{math} dataset, in the \emph{simple key} 
#' format required by \code{analyze}. See \code{vignette("scoring")}.
#' 
#' @format A length 10 character vector containing the correct response for each of the 10
#'   items in \code{math}.
#' @seealso \code{\link{math}}, \code{\link{math_full_key}}
#'   
"math_key"

#' Full key for \code{math} dataset
#' 
#' Contains correct answers for \code{math} dataset, in the \emph{full key} 
#' format required by \code{analyze}. See \code{vignette("scoring")}.
#' 
#' @format A data frame with the first column, \code{response}, containing every
#'   possible response, and 10 additional columns specifying how each response
#'   will be scored for each item.
#' @seealso \code{\link{math}}, \code{\link{math_key}}
#'   
"math_full_key"