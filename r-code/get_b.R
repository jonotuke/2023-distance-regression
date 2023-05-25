get_b <- function(pts){
  pts |> list_c()
}
get_b_df <- function(df){
  split(df, seq(nrow(df))) |> map(as.numeric) |> list_c()
}
# pacman::p_load(tidyverse, targets)
# a <- list(
#   a1 = c(0.1,0.1),
#   a2 = c(0,0),
#   a3 = c(-0.1,-0.1)
# )
# get_b(a)
# a <- tribble(
#   ~a1, ~a2,
#   1, 2,
#   3, 4,
#   5, 6
# )
# get_b_df(a)
