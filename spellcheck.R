#!/usr/bin/env Rscript
# Spell Check Script for DataScience4Psych
# This script checks spelling in all Rmd and md files
# 
# Usage:
#   Rscript spellcheck.R
#
# To update the wordlist with new valid words:
#   1. Review the spelling errors
#   2. Add valid terms to inst/WORDLIST (one per line, sorted alphabetically)
#   3. Re-run this script

# Install spelling package if not available
if (!requireNamespace("spelling", quietly = TRUE)) {
  install.packages("spelling")
}

library(spelling)

# Get all Rmd and md files
rmd_files <- list.files(pattern = "\\.Rmd$", recursive = FALSE)
md_files <- list.files(pattern = "\\.md$", recursive = FALSE)
jose_files <- list.files("admin/jose", pattern = "\\.md$", full.names = TRUE)

all_files <- c(rmd_files, md_files, jose_files)

cat("Checking spelling in", length(all_files), "files...\n\n")

# Load custom wordlist
wordlist_file <- "inst/WORDLIST"
if (file.exists(wordlist_file)) {
  custom_words <- readLines(wordlist_file, warn = FALSE)
  cat("Loaded", length(custom_words), "custom words from", wordlist_file, "\n\n")
} else {
  custom_words <- character(0)
  warning("No WORDLIST found at ", wordlist_file)
}

# Run spell check
results <- spell_check_files(all_files, ignore = custom_words)

# Print results
if (nrow(results) > 0) {
  cat(strrep("=", 50), "\n")
  cat("SPELLING ERRORS FOUND\n")
  cat(strrep("=", 50), "\n\n")
  print(results)
  
  cat("\n\nSummary:\n")
  cat("  Total errors:", nrow(results), "\n")
  cat("  Unique words:", length(unique(results$word)), "\n\n")
  
  cat("Unique misspelled words:\n")
  unique_words <- sort(unique(results$word))
  cat(paste("  -", unique_words), sep = "\n")
  
  cat("\n\nTo add valid words to the dictionary:\n")
  cat("  1. Review the words above\n")
  cat("  2. Add valid terms to inst/WORDLIST (one per line, sorted alphabetically)\n")
  cat("  3. Re-run this script\n\n")
  
  quit(status = 1)
} else {
  cat(strrep("=", 50), "\n")
  cat("SUCCESS: No spelling errors found!\n")
  cat(strrep("=", 50), "\n")
  quit(status = 0)
}
