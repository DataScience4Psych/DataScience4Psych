# Exercise 2-4: Pairings and joins

test_that("Ex 2: number of pairings is correct (3 * 2 = 6)", {
  skip_if(!exists("dn_ak") || !exists("lq_ak"))
  expect_equal(nrow(dn_ak) * nrow(lq_ak), 6,
               label = "Number of pairings should be nrow(dn_ak) * nrow(lq_ak) = 6")
})

test_that("Ex 3: dn_lq_ak object exists after join", {
  expect_true(exists("dn_lq_ak"),
              label = "dn_lq_ak should be created by joining dn_ak and lq_ak")
})

test_that("Ex 4: dn_lq_ak has 6 observations", {
  skip_if(!exists("dn_lq_ak"))
  expect_equal(nrow(dn_lq_ak), 6,
               label = "dn_lq_ak should have 6 rows (3 Denny's x 2 La Quintas)")
})

test_that("Ex 4: dn_lq_ak has .x and .y suffixed columns", {
  skip_if(!exists("dn_lq_ak"))
  expect_true(any(grepl("\\.x$", names(dn_lq_ak))),
              label = "Joined data should have .x suffixed columns from Denny's")
  expect_true(any(grepl("\\.y$", names(dn_lq_ak))),
              label = "Joined data should have .y suffixed columns from La Quinta")
})
