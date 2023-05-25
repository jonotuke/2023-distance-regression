get_Z_coeff <- function(x1, x2){
  norm <- sqrt(sum((x1 - x2)^2))
  (x1 - x2) / norm
}
get_Z <- function(pts){
  n_pts <- length(pts)
  m <- n_pts * (n_pts - 1) / 2
  n <- n_pts * 2
  Z <- matrix(0, nrow = m, ncol = n)
  row <- 1
  for(i in 1:(length(pts) - 1)){
    for(j in (i+1):length(pts)){
      coef <- as.numeric(get_Z_coeff(pts[[i]], pts[[j]]))
      Z[row, 2*i - 1] <- coef[1]
      Z[row, 2*i] <- coef[2]
      Z[row, 2*j - 1] <- -coef[1]
      Z[row, 2*j] <- -coef[2]
      row <- row + 1
    }
  }
  Z
}
get_Z_df <- function(df){
  split(df, seq(nrow(df))) |> get_Z()
}
# pacman::p_load(tidyverse, targets)
# pts <- list(
#   x1 = c(0,0),
#   x2 = c(1,0),
#   x3 = c(0,1)
# )
# get_Z_coeff(x1 = pts$x1, x2 = pts$x2)
# get_Z(pts)
# df <- tibble(
#   x1 = c(0,1,0),
#   x2 = c(0,0,1)
# )
# get_Z_df(df)
