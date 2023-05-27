library(testthat)
Rcpp::sourceCpp(here::here("c-code", "get_b.cpp"))
test_that("get_b works", {
  pacman::p_load(tidyverse)
  pts <- matrix(
    1:6, ncol = 2, byrow = TRUE
  )
  b <- cpp_get_b(pts)
  expect_equal(b, 1:6)
})
