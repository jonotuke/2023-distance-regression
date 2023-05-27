library(testthat)
Rcpp::sourceCpp(here::here("c-code", "get_Z.cpp"))
test_that("get_Z works", {
  pacman::p_load(tidyverse)
  pts <- matrix(
    c(0,0,1,0,0,1), ncol = 2, byrow = TRUE
  )
  Z <- cpp_get_Z(pts)
  true_Z <- matrix(
    c(
      -1, 0, 1, 0, 0, 0,
      0, -1, 0, 0, 0, 1,
      0, 0, 1/sqrt(2), -1/sqrt(2), -1/sqrt(2), 1/sqrt(2)
    ), nrow = 3, byrow = TRUE
  )
  expect_equal(Z, true_Z)
})
