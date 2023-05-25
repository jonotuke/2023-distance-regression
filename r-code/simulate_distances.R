simulate_distances <- function(n_pts, sigma_b, beta){
  lst <- list()
  lst$pts <- tibble(
    X1 = runif(n_pts, 0, 10),
    X2 = runif(n_pts, 0, 10),
    a1 = rnorm(n_pts, mean = 0, sd = sigma_b),
    a2 = rnorm(n_pts, mean = 0, sd = sigma_b),
    Y1 = beta * X1 + a1,
    Y2 = beta * X2 + a2
  )
  lst$dist <- tibble(
    Dij = lst$pts |> select(X1, X2) |> get_dist_df(),
    Gij = lst$pts |> select(Y1, Y2) |> get_dist_df()
  )
  lst
}
pacman::p_load(tidyverse, targets)
source("r-code/get_dist.R")
sims <- simulate_distances(n_pts = 50,
                           sigma_b = 0.1, beta = 1)
sims$pts
sims$pts |>
  ggplot(aes(X1, X2)) +
  geom_point(aes(fill = "X"), pch = 21) +
  geom_point(aes(Y1, Y2, fill = "Y"), pch = 21) +
  geom_segment(aes(x = X1, xend = Y1, y = X2, yend = Y2))

sims$dist |>
  ggplot(aes(Dij, Gij)) +
  geom_point()
