# Source shared test helper
.shared_helper <- normalizePath(file.path(dirname(sys.frame(1)$ofile), "..", "..", "shared-helper-load.R"), mustWork = FALSE)
if (file.exists(.shared_helper)) source(.shared_helper, local = FALSE)
