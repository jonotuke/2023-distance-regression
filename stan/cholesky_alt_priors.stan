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
//multivariate priors borrowwd from here https://mc-stan.org/docs/stan-users-guide/multivariate-hierarchical-priors.html
  //corr_matrix[2] Omega;        // prior correlation
  matrix[2,n_obs] z;
  cholesky_factor_corr[2] L_Omega;
  vector<lower=0>[2] tau;      // prior scale

}
transformed parameters {
  vector[n_obs*2] b;
  vector[n_obs] mu;
  matrix[2,n_obs] alpha;
  matrix[2,n_obs] alpha_intercept;
  alpha_intercept = rep_matrix(0, 2, n_obs);
  alpha = alpha_intercept + diag_pre_multiply(tau, L_Omega)*z;
  for(i in 1:n_obs){
    b[(i*2)-1] = alpha[1,i];
    b[i*2] = alpha[2,i];
  }
  mu = X * beta_1 + Z * b;
}
model {
  matrix[2,2] Sigma_alpha;
  tau ~ cauchy(0, .1);
  //Omega ~ lkj_corr(1);
  to_vector(z) ~ std_normal();
  L_Omega ~ lkj_corr_cholesky(2);
  sigma ~ normal(0,.1);
  beta_1 ~ normal(.3,.3);
  //Sigma_alpha = quad_form_diag(Omega, tau);

//  for(i in 1:n_obs){
//    alpha[,i] ~ multi_normal(alpha_intercept, Sigma_alpha);
//  }
  if(sample_prior == 0){
    G ~ normal(mu, sigma);
  }
}

