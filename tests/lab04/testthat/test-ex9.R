# Exercise 9-12: State-level analysis and visualization

test_that("Ex 9: can count Denny's per state", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  state_counts <- d %>% dplyr::count(state, sort = TRUE)
  expect_true(nrow(state_counts) > 0)
  # California should be near the top for Denny's
  expect_true("CA" %in% state_counts$state,
              label = "California should appear in Denny's state counts")
})

test_that("Ex 11-12: scatter plot of locations can be created", {
  skip_if(!exists("dn_lq") && !(exists("dn") && exists("lq")))
  if (exists("dn_lq")) {
    d <- dn_lq
  } else {
    dn_tmp <- dn %>% dplyr::mutate(establishment = "Denny's")
    lq_tmp <- lq %>% dplyr::mutate(establishment = "La Quinta")
    d <- dplyr::bind_rows(dn_tmp, lq_tmp)
  }
  p <- ggplot2::ggplot(d, ggplot2::aes(x = longitude, y = latitude, color = establishment)) +
    ggplot2::geom_point()
  expect_s3_class(p, "ggplot")
})
