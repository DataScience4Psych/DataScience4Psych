# Exercises 2-4: Pairings and joins

test_that("Ex 2: number of pairings is correct (3 x 2 = 6)", {
  skip_if(!exists("dn_ak") || !exists("lq_ak"))
  expected_pairings <- nrow(dn_ak) * nrow(lq_ak)
  expect_equal(expected_pairings, 6,
               label = "Number of pairings should be nrow(dn_ak) * nrow(lq_ak) = 3 * 2 = 6")
})

test_that("Ex 3: dn_lq_ak object exists after full_join", {
  expect_true(exists("dn_lq_ak"),
              label = "dn_lq_ak should be created by full_join of dn_ak and lq_ak")
})

test_that("Ex 3: dn_lq_ak is a data frame", {
  skip_if(!exists("dn_lq_ak"))
  expect_true(is.data.frame(dn_lq_ak),
              label = "dn_lq_ak should be a data frame")
})

test_that("Ex 4: dn_lq_ak has 6 observations", {
  skip_if(!exists("dn_lq_ak"))
  expect_equal(nrow(dn_lq_ak), 6,
               label = "dn_lq_ak should have 6 rows (3 Denny's x 2 La Quintas)")
})

test_that("Ex 4: dn_lq_ak has .x and .y suffixed columns from the join", {
  skip_if(!exists("dn_lq_ak"))
  has_x <- any(grepl("\\.x$", names(dn_lq_ak)))
  has_y <- any(grepl("\\.y$", names(dn_lq_ak)))
  expect_true(has_x,
              label = "Joined data should have .x suffixed columns from Denny's")
  expect_true(has_y,
              label = "Joined data should have .y suffixed columns from La Quinta")
})

test_that("Ex 4: dn_lq_ak has longitude and latitude columns for both establishments", {
  skip_if(!exists("dn_lq_ak"))
  expect_true("longitude.x" %in% names(dn_lq_ak),
              label = "dn_lq_ak should have longitude.x (Denny's longitude)")
  expect_true("longitude.y" %in% names(dn_lq_ak),
              label = "dn_lq_ak should have longitude.y (La Quinta longitude)")
  expect_true("latitude.x" %in% names(dn_lq_ak),
              label = "dn_lq_ak should have latitude.x (Denny's latitude)")
  expect_true("latitude.y" %in% names(dn_lq_ak),
              label = "dn_lq_ak should have latitude.y (La Quinta latitude)")
})
