#' Utility functions to test validity of key.
#' 
#' Test whether key is in valid format for scoring
#' 
#' @param key The candidate key \code{data.frame} or vector. See \code{vignette("scoring")}.
#' @return \code{TRUE} or \code{false} depending on whether key is of relevant valid form
#' @aliases valid_key is_valid_simple_key is_valid_full_key
#' @export

is_valid_simple_key = function(key) {
  ((is.data.frame(key) || (is.matrix(key) && length(dim(key)) == 2))
    && nrow(key) == 1 && ncol(key) >= 1) ||
    (!is.matrix(key) && is.atomic(key) == 1 && length(key) >= 1)
}

#' @export
is_valid_full_key = function(key) {
  is.data.frame(key) && 
    ncol(key) >= 2 &&
    all(vapply(key[2:ncol(key)], is.numeric, TRUE))
}
