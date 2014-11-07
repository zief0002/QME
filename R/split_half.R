split_half = function(x, method = "oddeven", ...){
  
  # Split test by even and odd items if method="oddeven" (default)
  # "random" makes test split randomly
  a_items = switch(method,
                 oddeven = which(1:ncol(x) %% 2 == 0),
                 random = sample(1:ncol(x), floor(ncol(x) / 2), replace = FALSE)
    )

  s_half = list(
    form_a = x[ , a_items],
    form_b = x[ , -a_items]
    )

  return(s_half)
}


  form.a.score = rowSums(x[ , a.items])
  form.b.score = rowSums(x[ , -a.items])
  r = cor(form.a.score, form.b.score)
  
  # Correct the correlation
  SBr = (2 * r) / (r + 1)
  
  # Format output
  nice.output = data.frame(Estimate = c(r, SBr), row.names = c("r", "SBr"))
  return(nice.output)
  
}

#split_half(LSAT)
#split_half(LSAT, oddEven = FALSE)