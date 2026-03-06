# Exercise 11-12: Mature mothers and low birth weight

test_that("Ex 11: ncbirths has mature and mage variables", {
  skip_if(!exists("ncbirths"))
  expect_true("mature" %in% names(ncbirths),
              info ="ncbirths should have a mature column")
  expect_true("mage" %in% names(ncbirths),
              info ="ncbirths should have a mage column")
})

test_that("Ex 11: mature variable has two categories", {
  skip_if(!exists("ncbirths"))
  skip_if(!"mature" %in% names(ncbirths))
  mature_vals <- unique(ncbirths$mature[!is.na(ncbirths$mature)])
  expect_equal(length(mature_vals), 2,
               info ="mature should have exactly 2 categories")
  expect_true("mature mom" %in% mature_vals,
              info ="mature should include 'mature mom' category")
  expect_true("younger mom" %in% mature_vals,
              info ="mature should include 'younger mom' category")
})

test_that("Ex 11: mature cutoff age is 35", {
  skip_if(!exists("ncbirths"))
  skip_if(!all(c("mature", "mage") %in% names(ncbirths)))
  mature_ages <- ncbirths$mage[ncbirths$mature == "mature mom"]
  younger_ages <- ncbirths$mage[ncbirths$mature == "younger mom"]
  expect_true(min(mature_ages) >= 35,
              info ="Minimum age for mature mothers should be >= 35")
  expect_true(max(younger_ages) < 35,
              info ="Maximum age for younger mothers should be < 35")
})

test_that("Ex 12: ncbirths has lowbirthweight variable", {
  skip_if(!exists("ncbirths"))
  expect_true("lowbirthweight" %in% names(ncbirths),
              info ="ncbirths should have a lowbirthweight column")
})

test_that("Ex 12: lowbirthweight has two categories", {
  skip_if(!exists("ncbirths"))
  skip_if(!"lowbirthweight" %in% names(ncbirths))
  lbw_vals <- unique(ncbirths$lowbirthweight[!is.na(ncbirths$lowbirthweight)])
  expect_equal(length(lbw_vals), 2,
               info ="lowbirthweight should have exactly 2 categories (low/not low)")
})

test_that("Ex 12: Rmd Exercise 12 contains low birth weight analysis code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("lowbirthweight|low.*birth", "mature", "group_by", "proportion|mean\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code analyzing low birth weight by mature status in your Rmd")
})

test_that("Ex 12: low birth weight proportions have expected properties (solution check)", {
  skip_if(!exists("ncbirths"))
  skip_if(!all(c("mature", "lowbirthweight") %in% names(ncbirths)))
  solution_props <- ncbirths %>%
    dplyr::filter(!is.na(mature), !is.na(lowbirthweight)) %>%
    dplyr::group_by(mature) %>%
    dplyr::summarize(
      pct_low = mean(lowbirthweight == "low"),
      .groups = "drop"
    )
  expect_equal(nrow(solution_props), 2,
               info ="Should have proportions for both mature and younger mothers")
  expect_true(all(solution_props$pct_low >= 0 & solution_props$pct_low <= 1),
              info ="Proportions of low birth weight should be between 0 and 1")
})
