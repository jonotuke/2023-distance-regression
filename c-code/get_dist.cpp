#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector cpp_get_dist(NumericVector x1, NumericVector x2) {
  // Set up distance vector
  int n_pts = x1.size();
  int n_dist = n_pts * (n_pts - 1) / 2;
  NumericVector dist(n_dist);
  int index = 0;
  for(int i = 0; i < n_pts - 1; i++){
    for(int j = i+1; j < n_pts; j++){
      // Rcout << "i = " << i << ",j = " << j << std::endl;
      dist[index] = sqrt(
        pow(x1[i] - x1[j], 2.0) +
          pow(x2[i] - x2[j], 2.0)
      );
      index++;
    }
  }
  return dist;
}

/*** R
pacman::p_load(tidyverse)
pts <- tibble(
  x1 = c(0,1,0),
  x2 = c(0,0,1)
)
cpp_get_dist(pts$x1, pts$x2)
*/
