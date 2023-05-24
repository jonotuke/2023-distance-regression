get_dist <- function(pts){
  n_pts <- length(pts)
  n <- n_pts * (n_pts - 1) / 2
  dist <- numeric(n)
  index <- 1
  for(i in 1:(n_pts - 1)){
    for(j in (i+1):n_pts){
      dist[index] <- sqrt(sum((pts[[i]] - pts[[j]])^2))
      index <- index + 1
    }
  }
  dist
}
get_dist_df <- function(df){
  split(df, seq(nrow(df))) |> get_dist()
}
# pts <- list(
#   x1 = c(0,0),
#   x2 = c(1,0),
#   x3 = c(0,1)
# )
# get_dist(pts)
# pts <- tibble(
#   c(0,1,0),
#   c(0,0,1)
# )
# get_dist_df(pts)
