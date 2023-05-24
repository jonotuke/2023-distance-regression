data {
  int<lower=0>n_obs;
  vector[n_obs] G;
  vector[n_obs] X;
  matrix[n_obs, n_obs*2] Z;
  int<lower = 0, upper =1> sample_prior;
}

parameters {
  real beta_1;
  real<lower=0> sigma;
  vector<lower=0>[2] alpha[n_obs];
//multivariate priors borrowwd from here https://mc-stan.org/docs/stan-users-guide/multivariate-hierarchical-priors.html
  corr_matrix[2] Omega;        // prior correlation
  vector<lower=0>[2] tau;      // prior scale

}
transformed parameters {
  vector[n_obs*2] b;
  vector[n_obs] mu;
  for(i in 1:n_obs){
    b[(i*2)-1] = alpha[n_obs, 1];
    b[i*2] = alpha[n_obs, 2];
  }
  mu = X * beta_1 + Z * b; 
}
model {
  vector[2] alpha_intercept;
  tau ~ cauchy(0, 1);
  Omega ~ lkj_corr(2);
  alpha_intercept = rep_vector(0,2);
  
  for(i in 1:n_obs){
    alpha[i] ~ multi_normal(alpha_intercept, quad_form_diag(Omega, tau));
  }
  if(sample_prior == 0){
    G ~ normal(mu, sigma);
  }
}

