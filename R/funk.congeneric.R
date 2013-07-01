funk.congeneric <- function(x, N = NULL, vcov = TRUE) {
  if(vcov == FALSE) {
    colnames(x) <- make.names(colnames(x))
    x <- var(x)
  }
  name.tempfile <- tempfile()
  model.cfa <- paste("F:", paste(colnames(x), collapse = ", "))
  cat(model.cfa, file = name.tempfile)
  model.cfa <- cfa(file = name.tempfile, reference.indicators = FALSE)
  unlink(name.tempfile)
  cfa.out <- sem(model = model.cfa, S = x, N = N)
  names.loadings <- str_detect(names(cfa.out$coeff), fixed("lam["))
  names.errors <- str_detect(names(cfa.out$coeff), fixed("V["))
  r.congeneric <- sum(cfa.out$coeff[names.loadings]) ^ 2 / 
    (sum(cfa.out$coeff[names.loadings]) ^ 2 + sum(cfa.out$coeff[names.errors]))
  r.congeneric <- c("Congeneric" = r.congeneric)
  attr(r.congeneric, "cfa") <- cfa.out
  r.congeneric
}