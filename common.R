## Standard Libraries
library(tweetrmd)     # Embedding tweets
library(vembedr)      # Embedding YouTube videos
library(knitr)
library(webshot)
library(tidyverse)
library(htmlwidgets)

## Options for knitr chunks
knitr::opts_chunk$set(
  comment = "#>",
  error = TRUE,
  collapse = TRUE
  # Additional options can be included as needed
)

## Global options
options(
  rlang_trace_top_env = rlang::current_env(),
  rlang__backtrace_on_error = "none",
  digits = 3,
  str = strOptions(strict.width = "cut")
)

## Additional options for LaTeX output
if (knitr::is_latex_output()) {
  knitr::opts_chunk$set(width = 69)
  options(width = 69, crayon.enabled = FALSE, cli.unicode = TRUE)
}

## Knit hooks
knitr::knit_hooks$set(chunk_envvar = function(before, options, envir) {
  envvar <- options$chunk_envvar
  if (before && !is.null(envvar)) {
    old_envvar <<- Sys.getenv(names(envvar), names = TRUE, unset = NA)
    do.call("Sys.setenv", as.list(envvar))
  } else {
    do.call("Sys.setenv", as.list(old_envvar))
  }
})

## Reading datasets
ds4p_funyoutube <- read.csv("admin/csv/ds4p_funyoutube.csv", sep = "")
ds4p_urls <- read.csv("./admin/csv/ds4p_urls.csv")

## Functions

# Check and install packages quietly
check_quietly <- purrr::quietly(devtools::check)
install_quietly <- purrr::quietly(devtools::install)

shhh_check <- function(..., quiet = TRUE) {
  out <- check_quietly(..., quiet = quiet)
  out$result
}

pretty_install <- function(...) {
  out <- install_quietly(...)
  output <- strsplit(out$output, split = "\n")[[1]]
  output <- grep("^(\\s*|[-|])$", output, value = TRUE, invert = TRUE)
  c(output, out$messages)
}

# Function to handle single or multiple samples
sample_no_surprises <- function(x) {
  if (length(x) <= 1) {
    return(x)
  } else {
    return(sample(x, 1))
  }
}

# Function to construct slide URLs
slide_url <- function(df_url, title, slide = NULL) {
  var_url <- paste0(df_url$link[df_url$title == title], slide)
  return(var_url)
}

# Function to try including a tweet
try_include_tweet <- function(tweet_url, plain = FALSE, ...) {
  return(try(tweetrmd::include_tweet(tweet_url = tweet_url, plain = plain, ...),
             silent = TRUE))
}
