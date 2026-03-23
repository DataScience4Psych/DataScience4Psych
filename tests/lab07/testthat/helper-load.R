# Source shared test helper
if (file.exists("tests/shared-helper-load.R")) {
  source("tests/shared-helper-load.R")
}

# Helper: find the first data frame in the global environment that has a given column
.find_obj_with_col <- function(col) {
  objs <- ls(envir = .GlobalEnv)
  for (nm in objs) {
    obj <- tryCatch(get(nm, envir = .GlobalEnv), error = function(e) NULL)
    if (is.data.frame(obj) && col %in% names(obj)) {
      return(list(name = nm, obj = obj))
    }
  }
  NULL
}
