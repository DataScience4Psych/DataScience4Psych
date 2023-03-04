# Importing data!



## Importing data!


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/hnUGwlyqx1M" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here][d12_import] if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d12_import/d12_import.html" width="672" height="400px" data-external="1"></iframe>

### Another Activity

<iframe src="https://datascience4psych.github.io/slides/d12_import/d12_import.html#9" width="672" height="400px" data-external="1"></iframe>

You can find the materials for the Nobels and sales activities [here](https://github.com/DataScience4Psych/ae-06-nobels-sales-dataimport).

## Importing and Variable Types!


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/g7G8ZTnDSv8" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here][d12_import] if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d12_import/d12_import.html#17" width="672" height="400px" data-external="1"></iframe>

### More Activity

<iframe src="https://datascience4psych.github.io/slides/d12_import/d12_import.html#22" width="672" height="400px" data-external="1"></iframe>

You can find the materials for the Nobels and sales activities [here](https://github.com/DataScience4Psych/ae-06-nobels-sales-dataimport).

## Vroom!


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/EmB1yyzRX0c" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here][#d12_import] if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d12_import/d12_import.html#30" width="672" height="400px" data-external="1"></iframe>


```{=html}
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">Live look at me opening a &quot;dataset&quot; <a href="https://t.co/eaBEguiA11">pic.twitter.com/eaBEguiA11</a></p>&mdash; Darren Dahly https://mastodon.social/@statsepi (@statsepi) <a href="https://twitter.com/statsepi/status/1323619993263755264?ref_src=twsrc%5Etfw">November 3, 2020</a></blockquote>

```

# Writing and reading files {#import-export}

This deep dive has been adapted from Jenny Bryan's Stat545.

## File I/O overview

For the most part, we've been working with (p)reprocessed data, like the Gapminder data from the gapminder data package or data from any of the labs. In other words, we haven't been explicitly writing any data or derived results to file. In real life (and in this class), you'll have to bring rectangular data into and out of R. Sometimes you'll need to do same for non-rectangular objects.

How do you do this? What issues should you think about?

### Data import mindset

Data import generally feels one of two ways:

-   "Surprise me!" You probably have to adopt this attitude when you first get a dataset. You are just happy to import without an error. You start to explore. You discover flaws in the data and/or the import. You address them. Lather, rinse, repeat.
-   "Another day in paradise." This attitude is when you bring in a tidy dataset you have maniacally cleaned in one or more cleaning scripts. There should be no surprises. You should express your expectations about the data in formal assertions at the very start of these downstream scripts.

In the second case, and as the first cases progresses, you actually know a lot about how the data is / should be. My main import advice: **use the arguments of your import function to get as far as you can, as fast as possible**. Novice code often has a great deal of unnecessary post import fussing around. Read the docs for the import functions and take maximum advantage of the arguments to control the import.

### Data export mindset

There will be many occasions when you need to write data from R. Two main examples:

-   a tidy ready-to-analyze dataset that you heroically created from messy data
-   a numerical result from data aggregation or modelling or statistical inference

First tip: **today's outputs are tomorrow's inputs**. Think back on all the pain you have suffered importing data and don't inflict such pain on yourself!

Second tip: don't be too cute or clever. A plain text file that is readable by a human being in a text editor should be your default until you have **actual proof** that this will not work. Reading and writing to exotic or proprietary formats will be the first thing to break in the future or on a different computer. It also creates barriers for anyone who has a different toolkit than you do. Be software-agnostic. Aim for future-proof and forgetfu-proof.

How does this approach fit with our emphasis on dynamic reporting via R Markdown? There is a time and place for everything. There are projects and documents where the scope and personnel will allow you to geek out with knitr and R Markdown. But there are lots of good reasons why (parts of) an analysis should not (only) be embedded in a dynamic report. Maybe you are just doing data cleaning to produce a valid input dataset. Maybe you are making a small but crucial contribution to a giant multi-author paper. Etc. Also remember there are other tools and workflows for making something reproducible. I'm looking at you, [make](https://kbroman.org/minimal_make/).

## Let's Begin!

### Load the tidyverse

The main package we will be using is [readr](https://readr.tidyverse.org), which provides drop-in substitute functions for `read.table()` and friends. However, to make some points about data export and import, it is nice to reorder factor levels. For that, we will use the [forcats](https://forcats.tidyverse.org) package, which is also included in the tidyverse package.


```r
library(tidyverse)
```

### Locate the Gapminder data

We could load the data from the package as usual, but instead we will load it from tab delimited file. The gapminder package includes the data normally found in the `gapminder` data frame as a `.tsv`. So let's get the path to that file on *your* system using the [`fs` package](https://fs.r-lib.org/index.html).


```r
library(fs)
(gap_tsv <- path_package("gapminder", "extdata", "gapminder.tsv"))
#> C:/Users/smaso/AppData/Local/R/win-library/4.2/gapminder/extdata/gapminder.tsv
```

### Bring rectangular data in

The workhorse data import function of readr is `read_delim()`. Here we'll use a variant, `read_tsv()`, that anticipates tab-delimited data:


```r
gapminder <- read_tsv(gap_tsv)
#> Rows: 1704 Columns: 6
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: "\t"
#> chr (2): country, continent
#> dbl (4): year, lifeExp, pop, gdpPercap
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
str(gapminder, give.attr = FALSE)
#> spc_tbl_ [1,704 × 6] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
#>  $ country  : chr [1:1704] "Afghanistan" "Afghanistan" "Afghanistan" "Afghani"..
#>  $ continent: chr [1:1704] "Asia" "Asia" "Asia" "Asia" ...
#>  $ year     : num [1:1704] 1952 1957 1962 1967 1972 ...
#>  $ lifeExp  : num [1:1704] 28.8 30.3 32 34 36.1 ...
#>  $ pop      : num [1:1704] 8425333 9240934 10267083 11537966 13079460 ...
#>  $ gdpPercap: num [1:1704] 779 821 853 836 740 ...
```

For full flexibility re: specifying the delimiter, you can always use `readr::read_delim()`.

There's a similar convenience wrapper for comma-separated values, `read_csv()`.

The most noticeable difference between the readr functions and base is that readr does NOT convert strings to factors by default. In the grand scheme of things, this default behavior is better, although we go ahead and convert them to factor here. Do not be deceived -- in general, you will do less post-import fussing if you use readr.


```r
gapminder <- gapminder %>%
  mutate(country = factor(country),
         continent = factor(continent))
str(gapminder)
#> tibble [1,704 × 6] (S3: tbl_df/tbl/data.frame)
#>  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
#>  $ year     : num [1:1704] 1952 1957 1962 1967 1972 ...
#>  $ lifeExp  : num [1:1704] 28.8 30.3 32 34 36.1 ...
#>  $ pop      : num [1:1704] 8425333 9240934 10267083 11537966 13079460 ...
#>  $ gdpPercap: num [1:1704] 779 821 853 836 740 ...
```

#### Bring rectangular data in -- summary

Default to `readr::read_delim()` and friends. Use the arguments!

The Gapminder data is too clean and simple to show off the great features of readr, so I encourage you to check out the part of the introduction vignette on [column types](https://cran.r-project.org/web/packages/readr/vignettes/readr.html). There are many variable types that you will be able to parse correctly upon import, thereby eliminating a great deal of post-import fussing.

## Compute something worthy of export

We need compute something worth writing to file. Let's create a country-level summary of maximum life expectancy.


```r
gap_life_exp <- gapminder %>%
  group_by(country, continent) %>% 
  summarize(life_exp = max(lifeExp)) %>% 
  ungroup()
#> `summarise()` has grouped output by 'country'. You can override using the
#> `.groups` argument.
gap_life_exp
#> # A tibble: 142 × 3
#>    country     continent life_exp
#>    <fct>       <fct>        <dbl>
#>  1 Afghanistan Asia          43.8
#>  2 Albania     Europe        76.4
#>  3 Algeria     Africa        72.3
#>  4 Angola      Africa        42.7
#>  5 Argentina   Americas      75.3
#>  6 Australia   Oceania       81.2
#>  7 Austria     Europe        79.8
#>  8 Bahrain     Asia          75.6
#>  9 Bangladesh  Asia          64.1
#> 10 Belgium     Europe        79.4
#> # … with 132 more rows
```

The `gap_life_exp` data frame is an example of an intermediate result that we want to store for the future and for downstream analyses or visualizations.

### Write rectangular data out

The workhorse export function for rectangular data in readr is `write_delim()` and friends. Let's use `write_csv()` to get a comma-delimited file.


```r
write_csv(gap_life_exp, "gap_life_exp.csv")
```

Let's look at the first few lines of `gap_life_exp.csv`. If you're following along, you should be able to open this file or, in a shell, use `head()` on it.


```
country,continent,life_exp
Afghanistan,Asia,43.828
Albania,Europe,76.423
Algeria,Africa,72.301
Angola,Africa,42.731
Argentina,Americas,75.32
```

This output is pretty decent looking, though there is no visible alignment or separation into columns. Had we used the base function `read.csv()`, we would be seeing rownames and lots of quotes, unless we had explicitly shut that down. Nicer default behavior is the main reason we are using `readr::write_csv()` over `write.csv()`.

-   It's not really fair to complain about the lack of visible alignment. Remember we are ["writing data for computers"](https://twitter.com/vsbuffalo/statuses/358699162679787521). If you really want to browse around the file, use `View()` in RStudio or open it in Microsoft Excel (!) but don't succumb to the temptation to start doing artisanal data manipulations there ... get back to R and construct commands that you can re-run the next 15 times you import/clean/aggregate/export the same dataset. Trust me, it will happen.


```{=html}
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">If I had one thing to tell biologists learning bioinformatics, it would be &quot;write code for humans, write data for computers&quot;.</p>&mdash; Vince Buffalo (@vsbuffalo) <a href="https://twitter.com/vsbuffalo/status/358699162679787521?ref_src=twsrc%5Etfw">July 20, 2013</a></blockquote>

```

### Invertibility

It turns out these self-imposed rules are often in conflict with one another:

-   Write to plain text files
-   Break analysis into pieces: the output of script `i` is an input for script `i + 1`
-   Be the boss of factors: order the levels in a meaningful, usually non-alphabetical way
-   Avoid duplication of code and data

**Example:** after performing the country-level summarization, we reorder the levels of the country factor, based on life expectancy. This reordering operation is conceptually important and must be embodied in R commands stored in a script. However, as soon as we write `gap_life_exp` to a plain text file, that meta-information about the countries is lost. Upon re-import with `read_delim()` and friends, we are back to alphabetically ordered factor levels. Any measure we take to avoid this loss immediately breaks another one of our rules.

So what do I do? I must admit I save (and re-load) R-specific binary files. Right after I save the plain text file. [Belt and suspenders](https://www.wisegeek.com/what-does-it-mean-to-wear-belt-and-suspenders.htm)!

I have toyed with the idea of writing import helper functions for a specific project, that would re-order factor levels in principled ways. They could be defined in one file and called from many. This would also have a very natural implementation within [a workflow where each analytic project is an R package](https://www.carlboettiger.info/2012/05/06/research-workflow.html). But so far it has seemed too much like [yak shaving](https://seths.blog/2005/03/dont_shave_that/). I'm intrigued by a recent discussion of putting such information in YAML frontmatter (see Martin Fenner's blog post [Using YAML frontmatter with CSV](https://blog.datacite.org/using-yaml-frontmatter-with-csv/)).

### Reordering the levels of the country factor

I reorder the country factor levels according to the life expectancy summary we've already computed.


```r
head(levels(gap_life_exp$country)) # alphabetical order
#> [1] "Afghanistan" "Albania"     "Algeria"     "Angola"      "Argentina"  
#> [6] "Australia"
gap_life_exp <- gap_life_exp %>% 
  mutate(country = fct_reorder(country, life_exp))
head(levels(gap_life_exp$country)) # in increasing order of maximum life expectancy
#> [1] "Sierra Leone" "Angola"       "Afghanistan"  "Liberia"      "Rwanda"      
#> [6] "Mozambique"
head(gap_life_exp)
#> # A tibble: 6 × 3
#>   country     continent life_exp
#>   <fct>       <fct>        <dbl>
#> 1 Afghanistan Asia          43.8
#> 2 Albania     Europe        76.4
#> 3 Algeria     Africa        72.3
#> 4 Angola      Africa        42.7
#> 5 Argentina   Americas      75.3
#> 6 Australia   Oceania       81.2
```

Note that the **row order of `gap_life_exp` has not changed**. I could choose to reorder the rows of the data frame if, for example, I was about to prepare a table to present to people. But I'm not, so I won't.

### `saveRDS()` and `readRDS()`

If you have a data frame AND you have exerted yourself to rationalize the factor levels, you have my blessing to save it to file in a way that will preserve this hard work upon re-import. Use `saveRDS()`.


```r
saveRDS(gap_life_exp, "gap_life_exp.rds")
```

`saveRDS()` serializes an R object to a binary file. It's not a file you will able to open in an editor, diff nicely with Git(Hub), or share with non-R friends. It's a special purpose, limited use function that I use in specific situations.

The opposite of `saveRDS()` is `readRDS()`. You must assign the return value to an object. I highly recommend you assign back to the same name as before. Why confuse yourself?!?


```r
rm(gap_life_exp)
gap_life_exp
#> Error in eval(expr, envir, enclos): object 'gap_life_exp' not found
gap_life_exp <- readRDS("gap_life_exp.rds")
gap_life_exp
#> # A tibble: 142 × 3
#>    country     continent life_exp
#>    <fct>       <fct>        <dbl>
#>  1 Afghanistan Asia          43.8
#>  2 Albania     Europe        76.4
#>  3 Algeria     Africa        72.3
#>  4 Angola      Africa        42.7
#>  5 Argentina   Americas      75.3
#>  6 Australia   Oceania       81.2
#>  7 Austria     Europe        79.8
#>  8 Bahrain     Asia          75.6
#>  9 Bangladesh  Asia          64.1
#> 10 Belgium     Europe        79.4
#> # … with 132 more rows
```

`saveRDS()` has more arguments, in particular `compress` for controlling compression, so read the help for more advanced usage. It is also very handy for saving non-rectangular objects, like a fitted regression model, that took a nontrivial amount of time to compute.

You will eventually hear about `save()` + `load()` and even `save.image()`. You may even see them in documentation and tutorials, but don't be tempted. Just say no. These functions encourage unsafe practices, like storing multiple objects together and even entire workspaces. There are legitimate uses of these functions, but not in your typical data analysis.

### Retaining factor levels upon re-import

Here is a concrete demonstration of how non-alphabetical factor level order is lost with `write_delim()` / `read_delim()` workflows but maintained with `saveRDS()` / `readRDS()`.


```r
(country_levels <- tibble(original = head(levels(gap_life_exp$country))))
#> # A tibble: 6 × 1
#>   original    
#>   <chr>       
#> 1 Sierra Leone
#> 2 Angola      
#> 3 Afghanistan 
#> 4 Liberia     
#> 5 Rwanda      
#> 6 Mozambique
write_csv(gap_life_exp, "gap_life_exp.csv")
saveRDS(gap_life_exp, "gap_life_exp.rds")
rm(gap_life_exp)
head(gap_life_exp) # will cause error! proving gap_life_exp is really gone 
#> Error in head(gap_life_exp): object 'gap_life_exp' not found
gap_via_csv <- read_csv("gap_life_exp.csv") %>% 
  mutate(country = factor(country))
#> Rows: 142 Columns: 3
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (2): country, continent
#> dbl (1): life_exp
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
gap_via_rds <- readRDS("gap_life_exp.rds")
country_levels <- country_levels %>% 
  mutate(via_csv = head(levels(gap_via_csv$country)),
         via_rds = head(levels(gap_via_rds$country)))
country_levels
#> # A tibble: 6 × 3
#>   original     via_csv     via_rds     
#>   <chr>        <chr>       <chr>       
#> 1 Sierra Leone Afghanistan Sierra Leone
#> 2 Angola       Albania     Angola      
#> 3 Afghanistan  Algeria     Afghanistan 
#> 4 Liberia      Angola      Liberia     
#> 5 Rwanda       Argentina   Rwanda      
#> 6 Mozambique   Australia   Mozambique
```

Note how the original, post-reordering country factor levels are restored using the `saveRDS()` / `readRDS()` strategy but revert to alphabetical ordering using `write_csv()` / `read_csv()`.

### `dput()` and `dget()`

One last method of saving and restoring data deserves a mention: `dput()` and `dget()`. `dput()` offers this odd combination of features: it creates a plain text representation of an R object which still manages to be quite opaque. If you use the `file =` argument, `dput()` can write this representation to file but you won't be tempted to actually read that thing. `dput()` creates an R-specific-but-not-binary representation. Let's try it out.


```r
## first restore gap_life_exp with our desired country factor level order
gap_life_exp <- readRDS("gap_life_exp.rds")
dput(gap_life_exp, "gap_life_exp-dput.txt")
```

Now let's look at the first few lines of the file `gap_life_exp-dput.txt`.


```
structure(list(country = structure(c(3L, 107L, 74L, 2L, 98L, 
138L, 128L, 102L, 49L, 125L, 26L, 56L, 96L, 47L, 75L, 85L, 18L, 
12L, 37L, 24L, 133L, 13L, 16L, 117L, 84L, 82L, 53L, 9L, 28L, 
120L, 22L, 104L, 114L, 109L, 115L, 23L, 73L, 97L, 66L, 71L, 15L, 
29L, 20L, 122L, 134L, 40L, 35L, 123L, 38L, 126L, 60L, 25L, 7L, 
39L, 59L, 141L, 86L, 140L, 51L, 63L, 64L, 52L, 121L, 135L, 132L, 
```

Huh? Don't worry about it. Remember we are ["writing data for computers"](https://twitter.com/vsbuffalo/statuses/358699162679787521). The partner function `dget()` reads this representation back in.


```r
gap_life_exp_dget <- dget("gap_life_exp-dput.txt")
country_levels <- country_levels %>% 
  mutate(via_dput = head(levels(gap_life_exp_dget$country)))
country_levels
#> # A tibble: 6 × 4
#>   original     via_csv     via_rds      via_dput    
#>   <chr>        <chr>       <chr>        <chr>       
#> 1 Sierra Leone Afghanistan Sierra Leone Sierra Leone
#> 2 Angola       Albania     Angola       Angola      
#> 3 Afghanistan  Algeria     Afghanistan  Afghanistan 
#> 4 Liberia      Angola      Liberia      Liberia     
#> 5 Rwanda       Argentina   Rwanda       Rwanda      
#> 6 Mozambique   Australia   Mozambique   Mozambique
```

Note how the original, post-reordering country factor levels are restored using the `dput()` / `dget()` strategy.

But why on earth would you ever do this?

The main application of this is [the creation of highly portable, self-contained minimal examples](https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example). For example, if you want to pose a question on a forum or directly to an expert, it might be required or just plain courteous to NOT attach any data files. You will need a monolithic, plain text blob that defines any necessary objects and has the necessary code. `dput()` can be helpful for producing the piece of code that defines the object. If you `dput()` without specifying a file, you can copy the return value from Console and paste into a script. Or you can write to file and copy from there or add R commands below.

### Other types of objects to use `dput()` or `saveRDS()` on

My special dispensation to abandon human-readable, plain text files is even broader than I've let on. Above, I give my blessing to store data.frames via `dput()` and/or `saveRDS()`, when you've done some rational factor level re-ordering. The same advice and mechanics apply a bit more broadly: you're also allowed to use R-specific file formats to save vital non-rectangular objects, such as a fitted nonlinear mixed effects model or a classification and regression tree.

## Clean up

We've written several files in this tutorial. Some of them are not of lasting value or have confusing filenames. I choose to delete them, while demonstrating some of the many functions R offers for interacting with the filesystem. It's up to you whether you want to submit this command or not.


```r
file.remove(list.files(pattern = "^gap_life_exp"))
#> [1] TRUE TRUE TRUE
```

### Pitfalls of delimited files

If a delimited file contains fields where a human being has typed, be proactive! Expect the unexpected. People do all sorts of things. Especially people who aren't in the business of programming and have never had to compute on text. Claim: a person's regular expression skill is inversely proportional to the skill required to handle the files they create. Implication: if someone has never heard of regular expressions, prepare for lots of pain working with their files.

When the header fields (often, but not always, the variable names) or actual data contain the delimiter, it can lead to parsing and import failures. Two popular delimiters are the comma `,` and the TAB `\t` and humans tend to use these when typing. If you can design this problem away during data capture, such as by using a drop down menu on an input form, by all means do so. Sometimes this is impossible or undesirable and you must deal with fairly free form text. That's a good time to allow/force text to be protected with quotes, because it will make parsing the delimited file go more smoothly.

Sometimes, instead of rigid tab-delimiting, whitespace is used as the delimiter. That is, in fact, the default for both `read.table()` and `write.table()`. Assuming you will write/read variable names from the first line (a.k.a. the `header` in `write.table()` and `read.table()`), they must be valid R variable names ... or they will be coerced into something valid. So, for these two reasons, it is good practice to use "one word" variable names whenever possible. If you need to evoke multiple words, use `snake_case` or `camelCase` to cope. **Example:** the header entry for the field holding the subject's last name should be `last_name` or `lastName` NOT `last name`. With the readr package, "column names are left as is, not munged into valid R identifiers (i.e. there is no `check.names = TRUE`)". So you can get away with whitespace in variable names and yet I recommend that you do not.

## Resources

[Data import](http://r4ds.had.co.nz/data-import.html) chapter of [R for Data Science][r4ds] by Hadley Wickham and Garrett Grolemund [-@wickham2016].

White et al.'s "Nine simple ways to make it easier to (re)use your data" [-@white2013].

-   First appeared [in PeerJ Preprints](https://doi.org/10.7287/peerj.preprints.7v2)
-   Published in [Ideas in Ecology and Evolution in 2013](https://ojs.library.queensu.ca/index.php/IEE/article/view/4608)
-   Section 4 "Use Standard Data Formats" is especially good reading.

Wickham's paper on tidy data in the Journal of Statistical Software [-@wickham2014].

-   Available as a PDF [here](http://vita.had.co.nz/papers/tidy-data.pdf)

Data Manipulation in R by Phil Spector [-@spector2008].

-   Available via [SpringerLink](https://www.springer.com/gp/book/9780387747309)
-   [Author's webpage](https://www.stat.berkeley.edu/%7Espector/)
-   [GoogleBooks search](https://books.google.com/books?id=grfuq1twFe4C&lpg=PP1&dq=data%2520manipulation%2520spector&pg=PP1#v=onepage&q&f=false)



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


<!-- Lab Links-->

[lab01_hello]: https://github.com/DataScience4Psych/lab-01-hello-r

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


<!--externals-->

[stat545]: https://stat545.com
[r4ds]: https://r4ds.had.co.nz
[cran]: https://cloud.r-project.org
