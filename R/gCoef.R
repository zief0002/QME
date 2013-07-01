gCoef <- function(gVar.out, object = "Person", type = "both") {
  if(type %in% c("both", "absolute")) {
    cases.keep <- gVar.out$Source != object
    AbsoluteErrorVariance <- gVar.out$Variance[cases.keep] / gVar.out$N[cases.keep]
    AbsoluteErrorVariance <- sum(AbsoluteErrorVariance)
    AbsoluteSEM <- sqrt(AbsoluteErrorVariance)
    Dependability <- gVar.out$Variance[! cases.keep] / (gVar.out$Variance[! cases.keep] + AbsoluteErrorVariance)
  } else {
    AbsoluteErrorVariance <- NA
    AbsoluteSEM <- NA
    Dependability <- NA
  }
  if(type %in% c("both", "relative")) {
    cases.keep <- gVar.out$Source != object & (str_detect(gVar.out$Source, object) | gVar.out$Source == "Residual")
    RelativeErrorVariance <- gVar.out$Variance[cases.keep] / gVar.out$N[cases.keep]
    RelativeErrorVariance <- sum(RelativeErrorVariance)
    RelativeSEM <- sqrt(RelativeErrorVariance)
    Generalizability <- gVar.out$Variance[gVar.out$Source == object] / (gVar.out$Variance[gVar.out$Source == object] + RelativeErrorVariance)
  } else {
    RelativeErrorVariance <- NA
    RelativeSEM <- NA
    Generalizability <- NA
  }
  data.frame(RelativeErrorVariance, RelativeSEM, Generalizability, AbsoluteErrorVariance, AbsoluteSEM, Dependability)
}