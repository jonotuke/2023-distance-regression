simulate_distances <- function(n_pts, sigma_b, beta){
  # X points
  X <- matrix(runif(n_pts * 2), ncol = 2)
  colnames(X) <- c("X1", "X2")
  # Get A
  A <- matrix(rnorm(n_pts * 2, mean = 0, sd = sigma_b), ncol = 2)
  colnames(A) <- c("A1", "A2")
  # Get Y
  Y <- beta * X + A
  colnames(Y) <- c("Y1", "Y2")
  # Get Dij
  Dij <- cpp_get_dist(X)
  # Get Gij
  Gij <- cpp_get_dist(Y)
  # Get LM Gij
  LMGij <- get_linear_model_gij(X, beta, A)
  # Return as a list
  lst <- list()
  lst$X <- X
  lst$A <- A
  lst$Y <- Y
  lst$Dij <- Dij
  lst$Gij <- Gij
  lst$LMGij <- LMGij
  return(lst)
}
# pacman::p_load(tidyverse, targets)
# fs::dir_ls("c-code/") |> walk(Rcpp::sourceCpp)
# source("r-code/get_linear_model_gij.R")
# sims <- simulate_distances(
#   n_pts = 200,
#   sigma_b = 0.01, beta = 1
# )
# sims$X |> as_tibble() |>
#   bind_cols(sims$Y) |>
#   ggplot(aes(X1, X2)) +
#   geom_point(aes(fill = "X"), pch = 21) +
#   geom_point(aes(Y1, Y2, fill = "Y"), pch = 21) +
#   geom_segment(aes(x = X1, xend = Y1, y = X2, yend = Y2))
#
# tibble(
#   Gij = sims$Gij,
#   LMGij = sims$LMGij,
#   Dij = sims$Dij
# ) |>
#   ggplot(aes(Gij, LMGij, col = cut(Dij, breaks = c(0, 1/sqrt(2), sqrt(2))))) +
#   geom_point()
