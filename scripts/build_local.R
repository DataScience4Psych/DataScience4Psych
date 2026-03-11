# Local Build Helpers for DS4P
#
# This script provides fast, iterative build helpers for local development.
# These are NOT used by CI — they are for working on chapters locally.
#
# Quick reference:
#   source("scripts/build_local.R")
#   preview_chapter("0201_visualization.Rmd")   # knit one chapter fast
#   build_changed()                              # knit only git-modified chapters
#   build_all()                                  # full HTML build (uses cache)
#   clear_cache("0201_visualization")            # force re-run one chapter's chunks
#   clear_cache()                                # force re-run all chapters

# Chapters that require external API keys and will fail without them set locally.
# Set the relevant env vars before building these, or skip them.
api_chapters <- c(
  "0703_apiwrappers.Rmd",  # rebird / EBIRD_API_KEY
  "0702_getdata.Rmd",      # geonames / GEONAMES_USERNAME
  "1401_llm.Rmd",          # openai  / OPENAI_API_KEY
  "1402_llmintro.Rmd",     # openai  / OPENAI_API_KEY
  "1403_llmcases.Rmd",     # openai  / OPENAI_API_KEY
  "1404_llmapi.Rmd"        # openai  / OPENAI_API_KEY
)

# preview_chapter() ------------------------------------------------------------
# Knit a single chapter in isolation. Fast — no full-book merge step.
# Cross-references to other chapters won't resolve, but all code runs.
#
# Usage:
#   preview_chapter("0201_visualization.Rmd")
#   preview_chapter("0201_visualization.Rmd", output_format = "html_document")
preview_chapter <- function(file, output_format = "bookdown::html_document2") {
  if (!file.exists(file)) {
    stop("File not found: ", file, "\n",
         "Run from the project root, e.g. preview_chapter('0201_visualization.Rmd')")
  }
  if (basename(file) %in% api_chapters) {
    message("Note: '", basename(file), "' uses external API keys. ",
            "Set EBIRD_API_KEY / GEONAMES_USERNAME / OPENAI_API_KEY as needed.")
  }
  bookdown::preview_chapter(file, output_format = output_format)
}


# build_changed() --------------------------------------------------------------
# Detect .Rmd files changed since `base_branch` (default: "main") and
# preview each one. Useful for a quick sanity-check before pushing.
#
# Usage:
#   build_changed()               # compare to main
#   build_changed("HEAD~3")       # compare to 3 commits ago
build_changed <- function(base_branch = "main") {
  changed_raw <- tryCatch(
    system2("git", c("diff", "--name-only", base_branch, "--", "*.Rmd"),
            stdout = TRUE, stderr = FALSE),
    error = function(e) character(0)
  )

  # Also include staged / unstaged changes in the working tree
  uncommitted <- tryCatch(
    system2("git", c("diff", "--name-only", "--", "*.Rmd"),
            stdout = TRUE, stderr = FALSE),
    error = function(e) character(0)
  )

  changed <- unique(c(changed_raw, uncommitted))
  changed <- changed[file.exists(changed)]

  if (length(changed) == 0) {
    message("No changed .Rmd files found vs '", base_branch, "'.")
    return(invisible(NULL))
  }

  message("Previewing ", length(changed), " changed chapter(s):")
  for (f in changed) {
    message("  -> ", f)
    preview_chapter(f)
  }
  invisible(changed)
}


# build_all() ------------------------------------------------------------------
# Full book build. Defaults to HTML only (gitbook) to skip slow PDF/EPUB steps.
# Always builds with clean = FALSE so knitr's chapter-level cache is preserved.
#
# Usage:
#   build_all()                         # HTML-only, keep cache
#   build_all(html_only = FALSE)        # all formats (slow)
#   build_all(skip_api = FALSE)         # include API-key chapters (need env vars)
build_all <- function(html_only = TRUE, skip_api = TRUE, clean = FALSE) {
  if (skip_api) {
    # Temporarily exclude API-dependent chapters by writing a minimal config
    all_rmds <- list.files(pattern = "^[0-9].*\\.Rmd$")
    selected <- all_rmds[!all_rmds %in% api_chapters]
    message("Skipping ", length(api_chapters), " API-dependent chapter(s). ",
            "Pass skip_api = FALSE to include them.")
    build_with_files(selected, html_only = html_only, clean = clean)
  } else {
    output_format <- if (html_only) "bookdown::gitbook" else NULL
    bookdown::render_book("index.Rmd", output_format = output_format, clean = clean)
  }
}


# build_with_files() -----------------------------------------------------------
# Build a partial book from a specific set of .Rmd files.
# Writes a temporary _bookdown_local.yml so the main config is not disturbed.
#
# Usage:
#   build_with_files(c("index.Rmd", "0201_visualization.Rmd", "0202_datafeeding.Rmd"))
build_with_files <- function(files, html_only = TRUE, clean = FALSE) {
  if (!"index.Rmd" %in% files) {
    files <- c("index.Rmd", files)
  }
  missing <- files[!file.exists(files)]
  if (length(missing) > 0) {
    stop("Files not found: ", paste(missing, collapse = ", "))
  }

  output_format <- if (html_only) "bookdown::gitbook" else NULL

  # Write a temporary bookdown config with rmd_files overridden
  tmp_config <- "_bookdown_local.yml"
  base_config <- yaml::read_yaml("_bookdown.yml")
  base_config$rmd_files <- as.list(files)
  yaml::write_yaml(base_config, tmp_config)
  on.exit(unlink(tmp_config), add = TRUE)

  bookdown::render_book(
    "index.Rmd",
    output_format = output_format,
    clean = clean,
    config_file = tmp_config
  )
}


# clear_cache() ----------------------------------------------------------------
# Delete knitr chunk cache for one chapter (or all chapters).
# Run this when you need to force-recompute chunk outputs — e.g. after
# changing a dataset or fixing a bug that was masked by stale cache.
#
# Usage:
#   clear_cache("0201_visualization")        # one chapter (no .Rmd extension needed)
#   clear_cache()                            # all chapters
clear_cache <- function(chapter = NULL) {
  if (!is.null(chapter)) {
    # Strip extension if provided
    chapter <- sub("\\.Rmd$", "", chapter, ignore.case = TRUE)
    cache_dir <- paste0(chapter, "_cache")
    if (dir.exists(cache_dir)) {
      unlink(cache_dir, recursive = TRUE)
      message("Cleared cache: ", cache_dir)
    } else {
      message("No cache found for chapter '", chapter, "' (looked for ", cache_dir, ")")
    }
  } else {
    cache_dirs <- list.dirs(recursive = FALSE, full.names = TRUE)
    cache_dirs <- cache_dirs[grepl("_cache$", cache_dirs)]
    if (length(cache_dirs) == 0) {
      message("No chapter cache directories found.")
    } else {
      unlink(cache_dirs, recursive = TRUE)
      message("Cleared ", length(cache_dirs), " cache director(ies).")
    }
  }
  invisible(NULL)
}


# show_api_chapters() ----------------------------------------------------------
# List the chapters that need API keys, so you know what to set up.
show_api_chapters <- function() {
  cat("Chapters requiring external API keys:\n")
  cat("  EBIRD_API_KEY      : 0703_apiwrappers.Rmd\n")
  cat("  GEONAMES_USERNAME  : 0702_getdata.Rmd\n")
  cat("  OPENAI_API_KEY     : 1401_llm.Rmd, 1402_llmintro.Rmd,\n")
  cat("                       1403_llmcases.Rmd, 1404_llmapi.Rmd\n\n")
  cat("Set env vars before sourcing this file, e.g.:\n")
  cat("  Sys.setenv(EBIRD_API_KEY = 'your-key')\n")
  invisible(api_chapters)
}

message(
  "DS4P local build helpers loaded.\n",
  "  preview_chapter('file.Rmd')  -- knit one chapter fast\n",
  "  build_changed()              -- knit only git-modified chapters\n",
  "  build_all()                  -- full HTML build (uses cache)\n",
  "  clear_cache('chapter-name') -- force re-run one chapter's chunks\n",
  "  show_api_chapters()          -- list chapters needing API keys"
)
