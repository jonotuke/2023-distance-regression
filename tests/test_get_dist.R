library(testthat)
Rcpp::sourceCpp(here::here("c-code", "get_dist.cpp"))
test_that("get_dist works", {
  pacman::p_load(tidyverse)
  pts <- tibble(
    x1 = c(0,1,0),
    x2 = c(0,0,1)
  )
  dist <- cpp_get_dist(pts$x1, pts$x2)
  expect_equal(dist, c(1, 1, sqrt(2)))
})
