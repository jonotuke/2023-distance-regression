pacman::p_load(tidyverse)
fs::dir_ls("c-code/") |> walk(Rcpp::sourceCpp)
fs::dir_ls("r-code/") |> walk(source)

sd_x <- sqrt(1/12)
df <- expand_grid(
  sigma_b = c(
    0.01, 0.1, 0.25, 0.5, 0.75,
    1, 1.5, 2,3, 4, 5, 6, 7, 8, 9, 10
  ) * sd_x,
  sim = 1:100
)

df <- df %>%
  rowwise() %>%
  mutate(
    data = list(
      simulate_distances(n_pts = 100, sigma_b = sigma_b, beta = 1)
    ),
    dist = list(
      tibble(
        Gij = data$Gij,
        LMGij = data$LMGij
      )
    ),
    r = cor(dist$Gij, dist$LMGij)
  )
df |>
  group_by(sigma_b) |>
  summarise(
    mean = mean(r),
    lwr = quantile(r, 0.1),
    upr = quantile(r, 0.9)
    ) |>
  ggplot(aes(sigma_b/sqrt(1/12), mean)) +
  geom_point() +
  geom_errorbar(aes(ymin = lwr, ymax = upr)) +
  scale_x_continuous(breaks = 0:10) +
  labs(x = expression(sigma[b]/sigma[x]))
