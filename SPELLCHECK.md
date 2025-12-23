# Spellchecking for DataScience4Psych

This repository uses automated spellchecking to maintain high-quality documentation and educational materials.

## How it Works

The spellchecker uses the `typos` tool to check all `.Rmd` (RMarkdown) and `.md` (Markdown) files in the repository. `typos` is a fast, Rust-based spell checker that's designed for source code.

### Automated Checks

A GitHub Actions workflow (`.github/workflows/spellcheck.yml`) automatically runs on:
- Every push that modifies `.Rmd` or `.md` files
- Every pull request that modifies `.Rmd` or `.md` files
- Changes to the configuration file (`_typos.toml`)

### Configuration

The file `_typos.toml` contains:
- **Custom dictionary entries** for domain-specific terms like:
  - R package names (tidyverse, ggplot, dplyr, etc.)
  - Data science terminology
  - Psychology-specific terms
  - Proper nouns (author names, project names, etc.)
  - Technical abbreviations
- **Exclusion patterns** to ignore:
  - R code chunks
  - URLs and email addresses
  - Binary files (images, PDFs, etc.)
  - Build artifacts and dependencies

## Running Spellcheck Locally

### Option 1: Using typos (Recommended for CI/CD consistency)

Install typos:

```bash
# On macOS
brew install typos-cli

# On Linux (using cargo)
cargo install typos-cli

# Or download from https://github.com/crate-ci/typos/releases
```

Run the spellchecker:

```bash
typos
```

Or with the config file explicitly:

```bash
typos --config _typos.toml
```

### Option 2: Using R spelling package (Alternative)

If you prefer to use R's native spelling package:

Install the `spelling` R package:

```r
install.packages("spelling")
```

Run the spellchecker script:

```bash
Rscript spellcheck.R
```

This uses the wordlist in `inst/WORDLIST`.

## Handling Spelling Errors

When the spellchecker finds potential errors:

1. **Review the flagged words** - Some may be genuine typos that need fixing
2. **Fix actual typos** - Edit the source files to correct spelling mistakes
3. **Add valid terms to the configuration** - For domain-specific terms, technical jargon, or proper nouns:
   
   For `typos`:
   - Open `_typos.toml`
   - Add the word under `[default.extend-words]` section:
     ```toml
     myterm = "myterm"
     ```
   - Commit the updated configuration
   
   For R `spelling`:
   - Open `inst/WORDLIST`
   - Add the word (one per line)
   - Keep the list sorted alphabetically
   - Commit the updated wordlist

### Example Workflow

If the spellchecker flags "tidyverse":

**Using typos:**
1. Recognize it's a valid R package name
2. Add it to `_typos.toml`:
   ```toml
   tidyverse = "tidyverse"
   ```
3. Commit the change

**Using R spelling:**
1. Add it to `inst/WORDLIST`:
   ```
   tidyverse
   ```
2. Commit the change

## Configuration Guidelines

### For _typos.toml
- Add entries under `[default.extend-words]`
- Use format: `word = "word"` for exact matches
- Can also specify corrections: `mispeling = "misspelling"`
- Use regex patterns in `extend-ignore-re` for complex patterns
- Add file patterns to `extend-exclude` to skip entire files/directories

### For inst/WORDLIST (R spelling)
- **One word per line**
- **Sorted alphabetically** (case-insensitive)
- **Include both singular and plural forms** if both are used
- **Be conservative** - Only add words that appear multiple times or are clearly valid

## Troubleshooting

### False Positives

If a word is flagged but is correct:
- Check if it's already in `_typos.toml` or `inst/WORDLIST`
- Verify the spelling matches exactly (case-sensitive)
- Add it to the appropriate configuration file

### CI/CD Failures

If the GitHub Action fails:
- Check the workflow log for the list of flagged words
- Either fix the typos or add valid terms to `_typos.toml`
- Push the changes to trigger a new check

### Local vs CI Differences

If typos passes locally but fails in CI (or vice versa):
- Ensure you're using the same configuration file
- Check that you have the latest version of typos
- Verify the configuration file is committed to the repository

## Contributing

When contributing to this repository:
- Run spellcheck locally before submitting PRs
- Include configuration updates in your PR if you introduce new domain-specific terms
- Document why new words are being added to the configuration (in the PR description)
- Prefer fixing typos over adding exceptions when possible

## Additional Resources

- [typos GitHub repository](https://github.com/crate-ci/typos)
- [typos configuration documentation](https://github.com/crate-ci/typos/blob/master/docs/reference.md)
- [R spelling package](https://cran.r-project.org/web/packages/spelling/index.html)
