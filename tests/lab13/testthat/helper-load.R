# Lab-specific test helper
# The shared helper (sourced below) handles: student Rmd loading,
# .rmd_content, .find_ex_section, and common packages.
# Add any lab-specific setup (extra packages, custom utilities) after this line.
.shared_helper <- normalizePath(
  file.path(dirname(sys.frame(1)$ofile), "..", "..", "shared-helper-load.R"),
  mustWork = FALSE
)
if (file.exists(.shared_helper)) source(.shared_helper, local = FALSE)

# Lab-specific setup below:
