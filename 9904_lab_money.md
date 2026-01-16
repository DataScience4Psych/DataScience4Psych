# Optional Lab {#labmoney}

**Disclaimer**
This lab is optional, and you are welcome to try it—just don’t expect anything to work smoothly. It’s an unusually brittle and time-consuming lab, and I haven’t had time to iron out the bugs or properly calibrate the difficulty. Things may break, behave unpredictably, or require more troubleshooting than usual. Proceed if you’re curious or want a challenge, but go in expecting chaos.







In this assignment you will work on data scraping. If you need some help, I recommend working thru this interactive tutorial titled [Money in politics](https://minecr.shinyapps.io/dsbox-05-moneyinpolitics/). They use the same website.

```{=html}
<details>
  <summary>Tired of typing your password?</summary>

<p>Chances are your browser has already saved your password, but if not, you can ask Git to save (cache) your password for a period of time, where you indicate the period of time in seconds. For example, if you want it to cache your password for 1 hour, that would be 3,600 seconds. To do so, run the following <b>in the console</b>, <code>usethis::use_git_config(credential.helper = "cache --timeout=3600")</code>. If you want to cache it for a longer amount of time, you can adjust the number in the code.</p>
  
</details>
```

## Packages {.unnumbered}

In this assignment we will use the following packages:

- **tidyverse**: a collection of packages for doing data analysis in a "tidy" way
- **robotstxt**: provides functions to download and parse `robots.txt` files, making it easy to check if bots (spiders, crawler, scrapers, ...) are allowed to access specific resources on a domain
- **rvest**: helps you scrape information from web pages
- **scales**: provides the internal scaling infrastructure used by ggplot2 and gives you tools to override the default breaks, labels, transformations and palettes

## Data collection via web scraping {.unnumbered}

<img src="img/opensecrets.png" alt="" width="100%" />

The data come from [OpenSecrets.org](https://www.opensecrets.org), a *"website tracking the influence of money on U.S. politics, and how that money affects policy and citizens' lives"*.
This website is hosted by The Center for Responsive Politics, which is a nonpartisan, independent nonprofit that *"tracks money in U.S. politics and its effect on elections and public policy."*[^1]

Before getting started, let's check that a bot has permissions to access pages on this domain.


``` r
library(robotstxt)
paths_allowed("https://www.opensecrets.org")
#> [1] TRUE
```

Our goal is to scrape data for contributions in all election years Open Secrets has data for.
Because that means repeating a task many times, let's first write a function that works on the first page. Confirm it works on a few others. Then iterate it over pages for all years.

::: {.box}
Complete the following set of steps in the `scrape-pac.R` file in the `scripts` folder of your repository.
This file already contains some starter code to help you out.
:::

- Write a function called `scrape_pac()` that scrapes information from the Open Secrets webpage for foreign-connected PAC contributions in a given year.
    This function should

  - have one input: the URL of the webpage and should return a data frame.
  - rename variables scraped, using `snake_case` naming.
  - clean up the `Country of Origin/Parent Company` variable with `str_squish()`.
  - add a new column to the data frame for `year`. We will want this information when we ultimately have data from all years, so this is a good time to keep track of it. Our function doesn't take a year argument, but the year is embedded in the URL, so we can extract it out of there, and add it as a new column. Use the `str_sub()` function to extract the last 4 characters from the URL. You will probably want to look at the help for this function to figure out how to specify "last 4 characters".

- Define the URLs for 2020, 2018, and 1998 contributions.
    Then, test your function using these URLs as inputs.
    Does the function seem to do what you expected it to do?

- Construct a vector called `urls` that contains the URLs for each webpage that contains information on foreign-connected PAC contributions for a given year.

- Map the `scrape_pac()` function over `urls` in a way that will result in a data frame called `pac_all`.

- Write the data frame to a csv file called `pac-all.csv` in the `data` folder.

*✅⬆️ If you haven't yet done so, now is definitely a good time to commit and push your changes to GitHub with an appropriate commit message (e.g. "Data scraping complete"). Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*

1. In your R Markdown file, load `pac-all.csv` and report its number of observations and variables using inline code.

## Data cleaning {.unnumbered}

In this section, we clean the `pac_all` data frame to prepare it for analysis and visualization.
We have two goals in data cleaning:

- Separate the `country_parent` into two such that country and parent company appear in different columns for country-level analysis.

- Convert contribution amounts in `total`, `dems`, and `repubs` from character strings to numeric values.

The following exercises walk you through how to make these fixes to the data.

2. Use the `separate()` function to separate `country_parent` into `country` and `parent` columns.
    Note that country and parent company names are separated by `\` (which will need to be specified in your function) and also note that there are some entries where the `\` sign appears twice and in these cases we want to only split the value at the first occurrence of `\`.
    This can be accomplished by setting the `extra` argument in to `"merge"` so that the cell is split into only 2 segments, e.g. we want `"Denmark/Novo Nordisk A/S"` to be split into `"Denmark"` and `"Novo Nordisk A/S"`.
    (See help for `separate()` for more on this.) End your code chunk by printing out the top 10 rows of your data frame (if you just type the data frame name it should automatically do this for you).

3. Remove the character strings including `$` and `,` signs in the `total`, `dems`,and `repubs` columns and convert these columns to numeric.
    End your code chunk by printing out the top 10 rows of your data frame (if you just type the data frame name it should automatically do this for you).
    A couple hints to help you out:

    - The `$` character is a special character so it will need to be escaped.

    - Some contribution amounts are in the millions (e.g. Anheuser-Busch contributed a total of \$1,510,897 in 2008).
        In this case we need to remove all occurrences of `,`, which we can do by using `str_remove_all()` instead of `str_remove()`.

🧶 ✅ ⬆️ *Now is a good time to knit your document, and commit and push your changes to GitHub with an appropriate commit message. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*

## Data visualization and interpretation {.unnumbered}

4. Create a line plot of total contributions from all foreign-connected PACs in the Canada and Mexico over the years.
    Once you have made the plot, write a brief interpretation of what the graph reveals.
    Few hints to help you out:

    - Filter for only `Canada` and `Mexico`.
    - Calculate sum of total contributions from PACs for each year for each country by using a sequence of `group_by()` then `summarize()`.
    - Make a plot of total contributions (y-axis) by year (x-axis) where two lines identified by different colors represent each of Canada and Mexico.

<!-- -->

5. Recreate the following visualization. Once you have made the plot, write a brief interpretation of what the graph reveals. Note that these are only UK contributions. You will need to make use of functions from the **scales** package for axis labels as well as from **ggplot2**. Remember, if you can't figure out certain bits, you can always ask on the class github!

<img src="img/plot-to-recreate.png" alt="" width="100%" />

🧶 ✅ ⬆️ *Knit your document, and commit and push your changes to GitHub with an appropriate commit message. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*

[^1]: Source: [Open Secrets - About](https://www.opensecrets.org/about/).



<!--DS4P Links-->
[course_web]: https://datascience4psych.github.io/DataScience4Psych
[course_git]: https://github.com/DataScience4Psych/DataScience4Psych
[course_repo]: https://github.com/DataScience4Psych
[course_slides]: https://github.com/DataScience4Psych/slides
[course_syllabus]: https://smasongarrison.github.io/syllabi/ 
<!-- https://smasongarrison.github.io/syllabi/data-science.html -->
[syllabi]: https://smasongarrison.github.io/syllabi
[pl_00]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYaEAnJX20Ryy4OSie375rVY
[pl_01]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYao_7t5ycK4KDXNKaY-ECup
[pl_02]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZmr_T3PnuxjVIlj0C0kUNI
[pl_03]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYaHmjzdRvfg0yhOIYQnfjwE
[pl_04]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYYWFcel6_vp8__RUKLxhX4y
[pl_05]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYYMIguiV1F8RagMYibTY4iW
[pl_06]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYYV_KDod3Mk9-RmtFXii9Dv
[pl_07]: https://www.youtube.com/watch?list=PLKrrdtYgOUYZxvEvQ8-PcWrOY_dwY_ETI
[pl_08]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZgOzYB_dmauw55M7jXvsdo
[pl_09]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbaiTmldRY2ddsLrHp3z6yO
[pl_10]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbPw5iYzYEzoOKa7mJKNIhq
[pl_11]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZ-u6LzBbanrNFoeLHKaLL6
[pl_12]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbwRS-9Htmb80_t1NG-021e
[pl_13]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbWGmSnbLIYwdLOnGm6une6
[pl_14]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbWGmSnbLIYwdLOnGm6une6
[pl_15]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYa5MoYrV8EsWQ5jIr5ZYMpM
[pl_all]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZomNqf-1dtCDW94ySdLv-9


<!--AE Links-->
[ae01a_unvotes]: https://github.com/DataScience4Psych/ae01a_unvotes
[ae01b_covid]: https://github.com/DataScience4Psych/ae01b_covid
[ae02_bechdel]: https://github.com/DataScience4Psych/ae-02-bechdel-rmarkdown
[ae03_starwars]: https://github.com/DataScience4Psych/ae-03-starwars-dataviz
[ae08_imdb]: https://github.com/DataScience4Psych/ae-08-imdb-webscraping

<!-- Lab Links-->

[lab01_hello]: https://github.com/DataScience4Psych/lab-01-hello-r
[lab02]: https://github.com/DataScience4Psych/lab-02-plastic-waste
[lab03]: https://github.com/DataScience4Psych/lab-03-nobel-laureates
[lab04]: https://github.com/DataScience4Psych/lab-04-viz-sp-data
[lab05]: https://github.com/DataScience4Psych/lab-05-wrangle-sp-data
[lab06]: https://github.com/DataScience4Psych/lab_06_sad_plots
[lab07]: https://github.com/DataScience4Psych/lab_07_betterviz
[lab08]: https://github.com/DataScience4Psych/lab-08-uoe-art
[lab09]: https://github.com/DataScience4Psych/lab-09-ethics-algorithmic-bias
[lab10]: https://github.com/DataScience4Psych/lab-10-slr-course-evals
[lab11]: https://github.com/DataScience4Psych/lab-11-mlr-course-evals
[lab12]: https://github.com/DataScience4Psych/lab-12-inference-smoking
[lab13]: https://github.com/DataScience4Psych/lab-13-simulating-mars

<!--Slides-->
[d01_welcome]: https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html
[d02_toolkit]: https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html
[d03_dataviz]: https://datascience4psych.github.io/slides/d03_dataviz/d03_dataviz.html
[d04_ggplot2]: https://datascience4psych.github.io/slides/d04_ggplot2/d04_ggplot2.html
[d05_viznum]: https://datascience4psych.github.io/slides/d05_viznum/d05_viznum.html
[d06_vizcat]: https://datascience4psych.github.io/slides/d06_vizcat/d06_vizcat.html
[d07_tidy]: https://datascience4psych.github.io/slides/d07_tidy/d07_tidy.html
[d08_grammar]: https://datascience4psych.github.io/slides/d08_grammar/d08_grammar.html
[d09_wrangle]: https://datascience4psych.github.io/slides/d09_wrangle/d09_wrangle.html
[d10_dfs]: https://datascience4psych.github.io/slides/d10_dfs/d10_dfs.html
[d11_types]: https://datascience4psych.github.io/slides/d11_types/d11_types.html
[d12_import]: https://datascience4psych.github.io/slides/d12_import/d12_import.html
[d13_goodviz]: https://datascience4psych.github.io/slides/d13_goodviz/d13_goodviz.html
[d13b_moreggplot]: https://datascience4psych.github.io/slides/d13_goodviz/d13b_moreggplot.html
[d14_confound]: https://datascience4psych.github.io/slides/d14_confound/d14_confound.html
[d15_goodtalk]: https://datascience4psych.github.io/slides/d15_goodtalk/d15_goodtalk.html
[d16_webscraping]: https://datascience4psych.github.io/slides/d16_webscraping/d16_webscraping.html
[d17_functions]: https://datascience4psych.github.io/slides/d17_functions/d17_functions.html
[d18_ethics]: https://datascience4psych.github.io/slides/d18_ethics/d18_ethics.html
[d19_bias]: https://datascience4psych.github.io/slides/d19_bias/d19_bias.html
[d20_language]: https://datascience4psych.github.io/slides/d20_language/d20_language.html
[d21_fitting]: https://datascience4psych.github.io/slides/d21_fitting/d21_fitting.html
[d22_nonlinear]: https://datascience4psych.github.io/slides/d22_nonlinear/d22_nonlinear.html
[d23_multiple]: https://datascience4psych.github.io/slides/d23_multiple/d23_multiple.html
[d24_overfitting]: https://datascience4psych.github.io/slides/d24_overfitting/d24_overfitting.html
[d25_crossvalidation]: https://datascience4psych.github.io/slides/d25_crossvalidation/d25_crossvalidation.html
[d26_quantify]: https://datascience4psych.github.io/slides/d26_quantify/d26_quantify.html
[d27_bootstrap]: https://datascience4psych.github.io/slides/d27_bootstrap/d27_bootstrap.html
[d28_interactive]: https://datascience4psych.github.io/slides/d28_interactive/d28_interactive.html
[d29_machine]: https://datascience4psych.github.io/slides/d29_machinelearning/d29_machine.html
[d30_simulations]: https://datascience4psych.github.io/slides/d30_simulations/d30_simulations.html
[d31_llmintro]: https://datascience4psych.github.io/slides/d31_llmintro/d31_llmintro.html
[d32_llmapplications]: https://datascience4psych.github.io/slides/d32_llmapplications/d32_llmapplications.html

<!--externals-->

[stat545]: https://stat545.com
[r4ds]: https://r4ds.had.co.nz
[cran]: https://cloud.r-project.org
