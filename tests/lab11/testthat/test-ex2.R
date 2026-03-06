# Exercise 2: Train/test split

test_that("Ex 2: Rmd creates training and test sets", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "train",
    "test",
    "sample.*split",
    "initial_split",
    "createDataPartition"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Split the data into training and test sets"
  )
})

test_that("Ex 2: titanic_train or train_data data frame exists", {
  has_train <- exists("titanic_train") || exists("train_data") || exists("train")
  expect_true(has_train,
    label = "A training data object should exist (e.g., titanic_train, train_data, or train)"
  )
})

test_that("Ex 2: acc_test exists and is a plausible accuracy value", {
  skip_if(!exists("acc_test"))
  expect_true(
    is.numeric(acc_test) && acc_test > 0.4 && acc_test < 1,
    label = sprintf(
      "acc_test should be a numeric accuracy between 0.4 and 1, got %s",
      acc_test
    )
  )
})

test_that("Ex 2: acc_train is higher than acc_test (typical overfitting pattern)", {
  skip_if(!exists("acc_train") || !exists("acc_test"))
  expect_true(
    acc_train >= acc_test,
    label = sprintf(
      "acc_train (%.3f) should be >= acc_test (%.3f) — training accuracy is typically higher",
      acc_train, acc_test
    )
  )
})

test_that("Ex 2: Rmd explains why training accuracy overestimates true performance", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "overfit",
    "overestimate",
    "train.*test",
    "test.*train"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Explain why apparent accuracy overestimates true predictive performance"
  )
})
