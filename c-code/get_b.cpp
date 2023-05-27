#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector cpp_get_b(NumericMatrix a) {
  int n_pts = a.nrow();
  NumericVector b(2*n_pts);
  for(int i = 0; i < n_pts; i++){
    b(2*i) = a(i, 0);
    b(2*i+1) = a(i, 1);
  }
  return b;
}

/*** R
a <- matrix(1:6, ncol = 2, byrow = TRUE)
a
cpp_get_b(a)
*/
