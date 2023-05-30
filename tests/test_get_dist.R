library(testthat)
Rcpp::sourceCpp(here::here("c-code", "get_dist.cpp"))
test_that("get_dist works", {
  pacman::p_load(tidyverse)
  M <- matrix(
    c(0,0,1,0,0,1), ncol = 2, byrow = TRUE
  )
  dist <- cpp_get_dist(pts)
  expect_equal(dist, c(1, 1, sqrt(2)))
  M <- matrix(
    c(0,0,1e-12, 1e-12), ncol = 2, byrow = TRUE
  )
  expect_equal(cpp_get_dist(M), sqrt(2) * 10^-12)
})
