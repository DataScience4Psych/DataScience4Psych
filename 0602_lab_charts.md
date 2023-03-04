# Lab: Ugly charts and Simpson's paradox{#lab06}





The two data visualized embedded in this lab violate many data visualization best practices.
Improve these visualizations using R and the tips for effective visualizations that we've introduced.
You should produce one visualization per dataset.
Your visualization should be accompanied by a brief paragraph describing the choices you made in your improvement, specifically discussing what you didn't like in the original plots and why, and how you addressed them in the visualization you created.


The learning goals for this lab are:

-   Telling a story with data
-   Data visualization best practices
-   Reshaping data

## Getting started {.unnumbered}

Go to the course GitHub organization and locate your lab repo. Either Fork it or copy it as a template. Then clone it in RStudio.
Refer to Lab 01 if you would like to see step-by-step instructions for cloning a repo into an RStudio project.

First, open the R Markdown document and Knit it. Make sure it compiles without errors. (Also, remember to check the final version after you upload!)

The output will be in the file markdown `.md` file with the same name.

### Housekeeping {.unnumbered}


> Remember: Your email address is the address tied to your GitHub account and your name should be first and last name.


Before we can get started we need to take care of some required housekeeping.
Specifically, we need to do some configuration so that RStudio can communicate with GitHub.
This requires two pieces of information: your email address and your name.

Run the following (but update it for your name and email!) in the Console to configure git:


```r
library(usethis)
use_git_config(user.name = "Your Name", 
               user.email = "your.email@address.com")
```

## Packages {.unnumbered}

Run the following code in the Console to load this package.


```r
library(tidyverse)
```

## Take a sad plot and make it better {.unnumbered}

### Instructional staff employment trends {.unnumbered}

The American Association of University Professors (AAUP) is a nonprofit membership association of faculty and other academic professionals.
[This report](https://www.aaup.org/sites/default/files/files/AAUP_Report_InstrStaff-75-11_apr2013.pdf) compiled by the AAUP shows trends in instructional staff employees between 1975 and 2011, and contains an image very similar to the one given below.

<img src="img/staff-employment.png" width="822" />

Let's start by loading the data used to create this plot.


```r
staff <- read_csv("data/instructional-staff.csv")
```

Each row in this dataset represents a faculty type, and the columns are the years for which we have data.
The values are percentage of hires of that type of faculty for each year.


```
## # A tibble: 5 × 12
##   facult…¹ `1975` `1989` `1993` `1995` `1999` `2001` `2003` `2005` `2007` `2009`
##   <chr>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
## 1 Full-Ti…   29     27.6   25     24.8   21.8   20.3   19.3   17.8   17.2   16.8
## 2 Full-Ti…   16.1   11.4   10.2    9.6    8.9    9.2    8.8    8.2    8      7.6
## 3 Full-Ti…   10.3   14.1   13.6   13.6   15.2   15.5   15     14.8   14.9   15.1
## 4 Part-Ti…   24     30.4   33.1   33.2   35.5   36     37     39.3   40.5   41.1
## 5 Graduat…   20.5   16.5   18.1   18.8   18.7   19     20     19.9   19.5   19.4
## # … with 1 more variable: `2011` <dbl>, and abbreviated variable name
## #   ¹​faculty_type
```

To recreate this visualization, we must first reshape the data by separating it into two variables: one for faculty type and one for year. In other words, we will be converting our data from wide format to long format.


However, before we do so, consider this thought exercise: *How many rows will the long-format data have?* Each combination of year and faculty type will have its own row. If there are 5 faculty types and 11 years of data, how many rows would we have?

We can perform the conversion from wide to long format using a new function: `pivot_longer()`. The animation below demonstrates how this function works, as well as its counterpart `pivot_wider()`.

![](img/tidyr-longer-wider.gif)<!-- -->

The function has the following arguments:


```r
pivot_longer(data,
             cols,
             names_to = "name")
```

-   The first argument is `data` as usual.
-   The second argument, `cols`, is where you specify which columns to pivot into longer format -- in this case all columns except for the `faculty_type`
-   The third argument, `names_to`, is a string specifying the name of the column to create from the data stored in the column names of data -- in this case `year`


```r
staff_long <- staff %>%
  pivot_longer(cols = -faculty_type, names_to = "year") %>%
  mutate(value = as.numeric(value))
```

Let's take a look at what the new longer data frame looks like.


```r
staff_long
```

```
## # A tibble: 55 × 3
##    faculty_type              year  value
##    <chr>                     <chr> <dbl>
##  1 Full-Time Tenured Faculty 1975   29  
##  2 Full-Time Tenured Faculty 1989   27.6
##  3 Full-Time Tenured Faculty 1993   25  
##  4 Full-Time Tenured Faculty 1995   24.8
##  5 Full-Time Tenured Faculty 1999   21.8
##  6 Full-Time Tenured Faculty 2001   20.3
##  7 Full-Time Tenured Faculty 2003   19.3
##  8 Full-Time Tenured Faculty 2005   17.8
##  9 Full-Time Tenured Faculty 2007   17.2
## 10 Full-Time Tenured Faculty 2009   16.8
## # … with 45 more rows
```

And now, let's plot it as a line graph. A possible approach for creating a line plot and differentiating the lines by faculty type is to use the following method:


```r
staff_long %>%
  ggplot(aes(x = year, y = value, color = faculty_type)) +
  geom_line()
```

```
## `geom_line()`: Each group consists of only one observation.
## ℹ Do you need to adjust the group aesthetic?
```

<img src="0602_lab_charts_files/figure-html/unnamed-chunk-7-1.png" width="960" />

But note that this code results in a message, as well as an unexpected plot. The message informs us that there is only one observation for each faculty type and year combination. To address this, we can use the `group` aesthetic in the following code.


```r
staff_long %>%
  ggplot(aes(x = year,
             y = value,
             group = faculty_type,
             color = faculty_type)) +
  geom_line()
```

1. Include the line plot you made above in your report and make sure the figure width is large enough to make it legible.
>    Also fix the title, axis labels, and legend label.

2.  Suppose the objective of this plot was to show that the proportion of part-time faculty have gone up over time compared to other instructional staff types.
> What changes would you propose making to this plot to tell this story?


✅ ⬆️ *Commit and push your changes to GitHub with an appropriate commit message again. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*

### Fisheries {.unnumbered}

The Fisheries and Aquaculture Department of the Food and Agriculture Organization of the United Nations (FAO) collects data on the fisheries production of different countries. You can find a list of fishery production for various countries in 2016 on [this Wikipedia page](https://en.wikipedia.org/wiki/Fishing_industry_by_country).
The data includes the tonnage of fish captured and farmed for each country.
Note that countries whose total harvest was less than 100,000 tons are excluded from the visualization.

A researcher has shared a visualization they created using these data with you.

<img src="img/fisheries.png" width="1121" />

3.  Can you help them make improve it? First, brainstorm how you would improve it. Then create the improved visualization and document your changes/decisions with bullet points. It's ok if some of your improvements are aspirational, i.e. you don't know how to implement it, but you think it's a good idea. Implement what you can and leave notes identifying the aspirational improvements that could not be made. (You don't need to recreate their plots in order to improve them)



```r
fisheries <- read_csv("data/fisheries.csv")
```

✅ ⬆️ *Commit and push your changes to GitHub with an appropriate commit message again. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*


## Stretch Practice with Smokers in Whickham {.unnumbered}


<img src="img/whickham.png" width="527" />

A study conducted in Whickham, England recorded participants' age and smoking status at baseline, and then 20 years later, their health outcome was recorded.

### Packages {.unnumbered}

Now, we will work with the `mosaicData` package.

Because this is first time we're using the `mosaicData` package, you need to make sure to install it first by running `install.packages("mosaicData")` in the console.


```r
library(tidyverse) 
library(mosaicData) 
```

Note that these packages are also loaded in your R Markdown document.

### The data {.unnumbered}

The data is in the `mosaicData` package. You can load it with


```r
data(Whickham)
```

Take a peek at the codebook with


```r
?Whickham
library(performance)
performance::compare_performance()
```

### Exercises {.unnumbered}

1. What type of study do you think these data come from: observational 
   or experiment? Why?

2. How many observations are in this dataset? What does each observation 
   represent?

3. How many variables are in this dataset? What type of variable is each? 
   Display each variable using an appropriate visualization.

4. What would you expect the relationship between smoking status and health outcome to be?

5. Create a visualization depicting the relationship between smoking status and health outcome. Briefly describe the relationship, and evaluate whether this meets your expectations. Additionally, calculate the relevant conditional probabilities to help your narrative. Here is some code to get you started:


```r
Whickham %>%
  count(smoker, outcome)
```

6. Create a new variable called `age_cat` using the following scheme:

- `age <= 44 ~ "18-44"`
- `age > 44 & age <= 64 ~ "45-64"`
- `age > 64 ~ "65+"`

7. Re-create the visualization depicting the relationship between smoking status and health outcome, faceted by `age_cat`. What changed? What might explain this change? Extend the contingency table from earlier by 
breaking it down by age category and use it to help your narrative. We can use the contingency table to examine how the relationship between smoking status and health outcome differs between different age groups. This extension will help us better understand the patterns we see in the visualization, and explain any changes we observe.


```r
Whickham %>%
  count(smoker, age_cat, outcome)
```

## Wrapping up {.unnumbered}

Go back through your write up to make sure you're following coding style guidelines we discussed in class.
Make any edits as needed.

Also, make sure all of your R chunks are properly labeled, and your figures are reasonably sized.


## More ugly charts {.unnumbered}

Want to see more ugly charts?

-   [Flowing Data - Ugly Charts](https://flowingdata.com/category/visualization/ugly-visualization/)
-   [Reddit - Data is ugly](https://www.reddit.com/r/dataisugly/)
-   [Missed Opportunities and Graphical Failures](http://www.datavis.ca/gallery/missed.php)
-   [(Mostly Bad) Graphics and Tables](http://users.stat.umn.edu/~rend0020/Teaching/STAT8801-resources/graphics/index.html)



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
