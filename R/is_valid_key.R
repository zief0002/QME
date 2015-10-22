is_valid_key = function(key) {
  return(
  is.data.frame(key)
  & all(sapply(key[2:ncol(key)], is.numeric))
  & ncol(key) >= 2
  )
}
