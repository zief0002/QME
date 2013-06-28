funk.congeneric <- function(data.congeneric) {
  data.congeneric <- as.data.frame(data.congeneric)
  names(data.congeneric) <- make.names(names(data.congeneric))
  name.tempfile <- tempfile()
  model.cfa <- paste("F:", paste(names(data.congeneric), collapse = ", "))
  cat(model.cfa, file = name.tempfile)
  model.cfa <- cfa(file = name.tempfile, reference.indicators = FALSE)
  unlink(name.tempfile)
  cfa.out <- sem(model = model.cfa, data = data.congeneric)
  names.loadings <- str_detect(names(cfa.out$coeff), fixed("lam["))
  names.errors <- str_detect(names(cfa.out$coeff), fixed("V["))
  r.congeneric <- sum(cfa.out$coeff[names.loadings]) ^ 2 / 
    (sum(cfa.out$coeff[names.loadings]) ^ 2 + sum(cfa.out$coeff[names.errors]))
  c("Congeneric" = r.congeneric)
}
