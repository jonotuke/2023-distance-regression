get_linear_model_gij <- function(X, beta, a){
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
  Gij <- Dij * 1 + Z %*% b
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
# get_linear_model_gij(X, beta = 1, a)
# get_linear_model_gij(X_df, beta = 1, a_df)
