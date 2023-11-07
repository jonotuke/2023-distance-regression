get_dist <- function(id1, id2){
  sqrt(sum((id2 - id1)^2))
}
get_dists <- function(file){
  df <- file |>
    readxl::read_excel() |>
    janitor::clean_names() |>
    rename(id = pandora_no)
  dist <- expand_grid(ID1 = df$id, ID2 = df$id)
  dist <- dist |>
    filter(ID1 != ID2) |>
    mutate(dist = 0)
  for(i in 1:nrow(dist)){
    x <- df |> filter(.data$id == dist$ID1[i]) |>
      select(
        x = x_coordinate_of_point_corrected,
        y = y_coordinate_of_point_corrected
        )
    y <- df |> filter(.data$id == dist$ID2[i]) |>
      select(
        x = x_coordinate_of_point_corrected,
        y = y_coordinate_of_point_corrected
        )
    dist$dist[i] <- get_dist(x,y)
  }
  dist
}
# pacman::p_load(tidyverse, targets)
# get_dists("raw-data/Grave_Skeleton_x_y_coordinates_Mikulovice_OK_corrected_20220701_LP.xlsx")
# get_dist(c(0, 0), c(1,1))
# get_dist(c(0, 0), c(0,0))
# get_dist(c(0, 0), c(0,1))
