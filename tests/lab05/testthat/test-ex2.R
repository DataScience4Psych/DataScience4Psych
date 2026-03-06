# Exercise 3 & 4: Join Denny's and La Quinta Alaska data

test_that("Ex 3: dn_lq_ak joined data frame exists", {
  expect_true(exists("dn_lq_ak"),
    label = "dn_lq_ak should be created by full_join of dn_ak and lq_ak"
  )
})

test_that("Ex 3: dn_lq_ak is a full join of dn_ak and lq_ak by state", {
  skip_if(!exists("dn_lq_ak"))
  expect_true(
    nrow(dn_lq_ak) == 6,
    label = "dn_lq_ak should have 6 rows (3 Denny's × 2 La Quintas = 6 pairs)"
  )
})

test_that("Ex 3: Rmd uses full_join", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "full_join") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Use full_join() to join dn_ak and lq_ak data frames"
  )
})

test_that("Ex 4: dn_lq_ak has variables from both datasets (with .x and .y suffixes)", {
  skip_if(!exists("dn_lq_ak"))
  # After full_join by state, address becomes address.x and address.y
  expect_true(
    any(grepl("\\.x$", names(dn_lq_ak))),
    label = "dn_lq_ak should have variables with .x suffix (from dn_ak)"
  )
  expect_true(
    any(grepl("\\.y$", names(dn_lq_ak))),
    label = "dn_lq_ak should have variables with .y suffix (from lq_ak)"
  )
})
