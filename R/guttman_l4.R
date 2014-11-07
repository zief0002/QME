##############################################################
## Function to produce the Guttman's Lambda4
##############################################################

guttman_l4 = function(x, oddEven = TRUE, ...){
    
    # Compute covariance matrix for full test
    cov_matrix = cov(x, use = "pairwise.complete.obs")

    #Split test
    s = split_half(x, oddEven = TRUE, ...)

    # Compute variances for each form
    a_var = sum(var(s$form_a))
    b_var = sum(var(s$form_b))

    # Compute Guttman's Lambda4
    l4 = 2 * (1 - (a_var + b_var) / sum(cov_matrix))

    # Compute CI based on Feldt's (1965) method
    k = nrow(cov_matrix)
    n = nrow(x)

    df_1 = n - 1
    df_2 = (n - 1) * (k - 1)

    lower_limit = 1 - ((1 - l4) * qf(0.975, df_1, df_2))
    upper_limit = 1 - ((1 - l4) * qf(0.0255, df_1, df_2))

    # Compute standard error measurement
    sem = sqrt(tot_var * (1 - l4))

    return(list(l4 = l4, ll = lower_limit, ul = upper_limit, sem = sem))
}


# Osburn, H. G. (2000) Coefficient Alpha and related internal consistency reliability coefficients. Psychological Methods, 5, 343-355.


# library(QME)
# data(math)
# data(math_key)
# out = QMEtest(math, math_key)
# x = getKeyedTestNoID(out)
# guttman_l4(x)

