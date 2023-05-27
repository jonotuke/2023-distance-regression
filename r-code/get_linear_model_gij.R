get_linear_model_gij <- function(X, beta, a){
  Dij <- cpp_get_dist(X)
  Z <- cpp_get_Z(X)
  b <- cpp_get_b(a)
  Gij <- as.numeric(Dij * beta + Z %*% b)
  Gij
}
# X <- matrix(
#   c(
#     0, 0,
#     1, 0,
#     0, 1
#   ), ncol = 2, byrow = TRUE
# )
# a <- matrix(
#   c(
#     0.1, 0.1,
#     0, 0,
#     -0.1, -0.1
#   ), ncol = 2, byrow = TRUE
# )
# get_linear_model_gij(X, beta = 1, a)
