#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector cpp_get_Z_coef(NumericVector x1, NumericVector x2) {
  double norm = sqrt(sum(pow(x1 - x2, 2)));
  NumericVector coef = (x1 - x2) / norm;
  return coef;
}

// [[Rcpp::export]]
NumericMatrix cpp_get_Z(NumericMatrix pts){
  int n_pts = pts.nrow();
  int m = n_pts * (n_pts - 1) / 2;
  int n = n_pts * 2;
  NumericMatrix Z(m, n);
  int row = 0;
  for(int i = 0; i < n_pts - 1; i++){
    for(int j = i + 1; j < n_pts; j++){
      NumericVector coef = cpp_get_Z_coef(pts(i,_), pts(j,_));

      Z(row, 2*i) = coef(0);
      Z(row, 2*i + 1) = coef(1);
      Z(row, 2*j) = -coef(0);
      Z(row, 2*j + 1) = -coef(1);
      row++;
    }
  }
  return Z;
}


/*** R
pts <- list(
  x1 = c(0,0),
  x2 = c(1,0),
  x3 = c(0,1)
)
cpp_get_Z_coef(pts$x1, pts$x2)
cpp_get_Z_coef(pts$x1, pts$x3)
cpp_get_Z_coef(pts$x2, pts$x3)
pacman::p_load(tidyverse)
M <- matrix(
  c(
    0, 0,
    1, 0,
    0, 1
  ),
  nrow = 3, byrow = TRUE
)
cpp_get_Z(M)
*/
