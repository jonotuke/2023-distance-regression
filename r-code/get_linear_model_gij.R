get_linear_model_gij <- function(X, beta, a, Dij){
  if(is.data.frame(X)){
    Z <- get_Z_df(X)
  } else {
    Z <- get_Z(X)
  }
  if(is.data.frame(a)){
    b <- get_b_df(a)
  } else {
    b <- get_b(a)
  }
  Gij <- Dij * beta + Z %*% b
  Gij <- as.numeric(Gij)
  Gij
}
# X <- list(
#   x1 = c(0,0),
#   x2 = c(1,0),
#   x3 = c(0,1)
# )
# X_df <- tibble(
#   x1 = c(0,1,0),
#   x2 = c(0,0,1)
# )
# a <- list(
#   a1 = c(0.1,0.1),
#   a2 = c(0,0),
#   a3 = c(-0.1,-0.1)
# )
# a_df <- tibble(
#   a1 = c(0.1, 0, -0.1),
#   a2 = c(0.1, 0, -0.1)
# )
# Dij <- get_dist(X)
# get_linear_model_gij(X, beta = 1, a, Dij)
# get_linear_model_gij(X_df, beta = 1, a_df, Dij)
