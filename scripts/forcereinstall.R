## Reinstall all currently-installed (non-base) packages
## Works on CRAN pkgs; can optionally try Bioc + GitHub remotes.

reinstall_all_packages <- function(lib = .libPaths()[1],
                                   include_priority = c("recommended", "other"),
                                   also_bioc = TRUE,
                                   also_remotes = TRUE,
                                   ask = FALSE) {
  ip <- installed.packages(lib.loc = lib)

  # Exclude base packages (Priority == "base") and anything not in selected priorities.
  pr <- ip[, "Priority"]
  keep <- is.na(pr) | pr %in% include_priority
  pkgs <- ip[keep, "Package"]

  # Safety: drop standard base packages explicitly, just in case.
  pkgs <- setdiff(pkgs, rownames(installed.packages(priority = "base")))

  if (length(pkgs) == 0L) {
    message("No non-base packages found to reinstall in: ", lib)
    return(invisible(NULL))
  }

  message("Will reinstall ", length(pkgs), " packages into: ", lib)

  # Ensure recommended helpers are available if we will use them
  if (also_bioc && !requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager", ask = ask,force = TRUE)
  }
  if (also_remotes && !requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes", ask = ask)
  }

  # Try to reinstall GitHub / remote packages if metadata exists
  if (also_remotes && "RemoteType" %in% colnames(ip)) {
    remote_type <- ip[, "RemoteType"]
    remote_repo <- ip[, "RemoteRepo"]
    remote_username <- ip[, "RemoteUsername"]

    gh_idx <- which(!is.na(remote_type) & remote_type == "github" &
                      !is.na(remote_repo) & !is.na(remote_username))
    if (length(gh_idx) > 0L) {
      gh_specs <- paste0(remote_username[gh_idx], "/", remote_repo[gh_idx])
      message("Reinstalling ", length(gh_specs), " GitHub remote packages via remotes::install_github()")
      remotes::install_github(gh_specs, dependencies = TRUE, upgrade = "never", quiet = TRUE,force = TRUE)
      pkgs <- setdiff(pkgs, ip[gh_idx, "Package"])
    }
  }

  # Try Bioconductor for any packages that are Bioc-managed (best-effort)
  if (also_bioc) {
    # Bioconductor packages often have "bioconductor-" repos or show up in BiocManager::repositories()
    bioc_repos <- tryCatch(BiocManager::repositories(), error = function(e) NULL)
    if (!is.null(bioc_repos)) {
      # If a pkg is available in Bioc repos, install it via BiocManager
      avail_bioc <- rownames(available.packages(contriburl = bioc_repos))
      bioc_pkgs <- intersect(pkgs, avail_bioc)
      if (length(bioc_pkgs) > 0L) {
        message("Reinstalling ", length(bioc_pkgs), " Bioconductor packages via BiocManager::install()")
        BiocManager::install(bioc_pkgs, ask = ask, update = FALSE,force = TRUE)
        pkgs <- setdiff(pkgs, bioc_pkgs)
      }
    }
  }

  # Reinstall the remaining packages from CRAN (or current repos)
  message("Reinstalling ", length(pkgs), " packages via install.packages()")
  install.packages(pkgs, lib = lib, dependencies = TRUE, ask = ask)

  invisible(pkgs)
}

## Run it:
reinstall_all_packages()
