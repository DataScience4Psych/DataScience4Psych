# Quick Reference: Spellchecker

## For Contributors

### When submitting a PR:
1. The spellchecker runs automatically on PRs that modify `.Rmd` or `.md` files
2. If it fails, check the workflow logs for flagged words
3. Fix genuine typos in your source files
4. For valid domain terms, add them to `_typos.toml` under `[default.extend-words]`

### Running locally (before submitting PR):
```bash
# Install typos (one time)
# macOS: brew install typos-cli
# Linux: Download from https://github.com/crate-ci/typos/releases

# Run spellcheck
typos

# Or with explicit config
typos --config _typos.toml
```

## For Maintainers

### Adding new domain-specific terms:
Edit `_typos.toml` and add under `[default.extend-words]`:
```toml
newterm = "newterm"
MyPackage = "MyPackage"
```

### Excluding files/directories:
Edit `_typos.toml` and add under `[files]` -> `extend-exclude`:
```toml
  "new_dir/*",
  "*.extension",
```

## Common Issues

**Q: Spellcheck fails on a valid technical term**
A: Add it to `_typos.toml` under `[default.extend-words]`

**Q: Want to run spellcheck on specific files only**
A: `typos file1.Rmd file2.md`

**Q: Need to use R-based spellchecker instead**
A: Run `Rscript spellcheck.R` (requires R and `spelling` package)

For complete documentation, see [SPELLCHECK.md](SPELLCHECK.md)
