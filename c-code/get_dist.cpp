#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector cpp_get_dist(NumericMatrix pts) {
  // Set up distance vector
  int n_pts = pts.nrow();
  int n_dist = n_pts * (n_pts - 1) / 2;
  NumericVector dist(n_dist);
  int index = 0;
  for(int i = 0; i < n_pts - 1; i++){
    for(int j = i+1; j < n_pts; j++){
      dist[index] = sqrt(
        sum(
          pow((pts(i, _) - pts(j, _)), 2)
        )
      );
      index++;
    }
  }
  return dist;
}

/*** R
pacman::p_load(tidyverse)
pts <- matrix(
  c(
    0, 0,
    1, 0,
    0, 1
  ), ncol = 2, byrow = TRUE
)
pts
cpp_get_dist(pts)
*/
