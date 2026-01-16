# Lab: Nobel laureates {#lab03}



In January 2017, Buzzfeed published an article titled ["These Nobel Prize Winners Show Why Immigration Is So Important for American Science"](https://www.buzzfeednews.com/article/peteraldhous/immigration-and-science). The article highlighted that many U.S.-based Nobel laureates in the sciences were born outside the United States, emphasizing the role of immigration in scientific innovation. More recently, in December 2025, The New York Times published a related article ["Nobel Prize Winners Show Why Immigration Is Vital to Science"](https://www.nytimes.com/2025/12/10/science/nobel-prize-immigrants-science.html) [@gorman2025nobel], further reinforcing this important relationship between immigration and scientific achievement.

In this lab, you will analyze Nobel laureate data to replicate and extend some of the visualizations from the article.

## Learning goals {.unnumbered}

By completing this lab, you will:

- Practice replicating published results
- Perform data wrangling and visualization using `tidyverse`

## Lab prep {.unnumbered}

- **Task:** Read the Buzzfeed article titled [*These Nobel Prize Winners Show Why Immigration Is So Important For American Science*](https://www.buzzfeednews.com/article/peteraldhous/immigration-and-science)*.* We will be replicating this analysis in the lab. So it's pretty important that you're familiar with it ahead of time.

## Getting started {.unnumbered}

To begin this lab, navigate to our course's GitHub organization and locate the repository named `lab-03-nobel-laureates`. Follow these steps:

1. **Repository Setup:**
   - **Forking:** If you are working individually, fork the repository to create a personal copy under your GitHub account.
   - **Template Copying:** If you prefer not to fork, you can also use the repository as a template. This option is particularly useful if you're working as a group.

2. **Clone and Open:**
   - **Cloning:** Use GitHub Desktop or the command line to clone the repository to your local machine.
   - **Opening the Project:** Open the cloned directory in RStudio by clicking on the `lab-03-nobel-laureates.Rproj` file.

3. **Open and Knit the R Markdown File:**
   - Open the `lab-03.Rmd` file in RStudio. Knit the document to ensure all code chunks run correctly and the markdown file (`lab-03.md`) is generated without errors.

4. **Update YAML Header:**
   - Modify the YAML header in the R Markdown document to include your name as the author and ensure other settings like date and output format are correctly specified. Knit the document again to see the updates in the output.

5. **Commit and Push Changes:**
   Commit your changes with a meaningful message using Git, such as "Updated YAML header with author details." Push these changes to your GitHub repository to ensure they are properly uploaded and visible online.

6. **Verify Changes on GitHub:**
   Visit your GitHub repository to confirm that your changes appear correctly in both the `.Rmd` **and** `.md` files. This ensures that your setup is correct and that you are ready to proceed with the lab exercises.


### Packages {.unnumbered}

We'll use the **tidyverse** package for much of the data wrangling.
This package is already installed for you.
You can load them by running the following in your Console:


``` r
library(tidyverse)
```

### Data {.unnumbered}

The dataset for this assignment can be found as a csv (comma separated values) file in the `data` folder of your repository.
You can read it in using the following.


``` r
nobel <- read_csv("data/nobel.csv")
```

The variable descriptions are as follows:

- `id`: ID number
- `firstname`: First name of laureate
- `surname`: Surname of laureate
- `year`: Year prize won
- `category`: Category of prize
- `affiliation`: Affiliation of laureate
- `city`: City of laureate in prize year
- `country`: Country of laureate in prize year
- `born_date`: Birth date of laureate
- `died_date`: Death date of laureate
- `gender`: Gender of laureate
- `born_city`: City where laureate was born
- `born_country`: Country where laureate was born
- `born_country_code`: Code of country where laureate was born
- `died_city`: City where laureate died
- `died_country`: Country where laureate died
- `died_country_code`: Code of country where laureate died
- `overall_motivation`: Overall motivation for recognition
- `share`: Number of other winners award is shared with
- `motivation`: Motivation for recognition

In a few cases, the name of the city/country changed after laureate was given (e.g., in 1975, Bosnia and Herzegovina was called the Socialist Federative Republic of Yugoslavia).
In these cases the variables below reflect a different name than their counterparts without the suffix \`\_original\`.

- `born_country_original`: Original country where laureate was born
- `born_city_original`: Original city where laureate was born
- `died_country_original`: Original country where laureate died
- `died_city_original`: Original city where laureate died
- `city_original`: Original city where laureate lived at the time of winning the award
- `country_original`: Original country where laureate lived at the time of winning the award

## Exercises {.unnumbered}

### Get to know your data {.unnumbered}

1. How many observations and how many variables are in the dataset? Use inline code to answer this question. What does each row represent?

There are some observations in this dataset that we will exclude from our analysis to match the Buzzfeed results.

2. Create a new data frame called `nobel_living` that filters for
- laureates who are still alive (their `died_date` is `NA`), as well as 
- laureates for whom `country` is available
- laureates who are people as opposed to organizations (organizations are denoted with `"org"` as their `gender`)



Confirm that once you have filtered for these characteristics you are left with a data frame with 228 observations, once again using inline code.

🧶 ✅ ⬆️ Knit, *commit, and push your changes to GitHub with an appropriate commit message. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*

### Most living Nobel laureates were based in the US when they won their prizes {.unnumbered}

... says the Buzzfeed article.
Let's see if that's true.

First, we'll create a new variable to identify whether the laureate was in the US when they won their prize.
We'll use the `mutate()` function for this.
The following pipeline mutates the `nobel_living` data frame by adding a new variable called `country_us`.
We use an if statement to create this variable.
The first argument in the `if_else()` function we're using to write this if statement is the condition we're testing for.
If `country` is equal to `"USA"`, we set `country_us` to `"USA"`.
If not, we set the `country_us` to `"Other"`.

> Note: We can achieve the same result using the `fct_other()` function we've seen before (i.e. with `country_us = fct_other(country, "USA")`). We decided to use the `if_else()` here to show you one example of an if statement in R.


``` r
nobel_living <- nobel_living %>%
  mutate(
    country_us = if_else(country == "USA", "USA", "Other")
  )
```

Next, we will limit our analysis to only the following categories: Physics, Medicine, Chemistry, and Economics.

> Note: Technically, the Nobel Prize in Economics is a memorial prize. It was established in 1968. If you want to annoy an economist, point that distinction out to them... More info  [here](https://en.wikipedia.org/wiki/Nobel_Memorial_Prize_in_Economic_Sciences) if you want to learn some more.


``` r
nobel_living_science <- nobel_living %>%
  filter(category %in% c("Physics", "Medicine", "Chemistry", "Economics"))
```

For the next exercise, work with the `nobel_living_science` data frame you created above.
You'll need to define this data frame in your R Markdown document, even though the next exercise doesn't explicitly ask you to do so.

3. Create a faceted bar plot visualizing the relationship between the category of prize and whether the laureate was in the US when they won the nobel prize.
    Interpret your visualization, and say a few words about whether the Buzzfeed headline is supported by the data.

    - Your visualization should be faceted by category.
    - For each facet you should have two bars, one for winners in the US and one for Other.
    - Flip the coordinates so the bars are horizontal, not vertical.




🧶 ✅ ⬆️ Knit, *commit, and push your changes to GitHub with an appropriate commit message. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*

## But of those US-based Nobel laureates, many were born in other countries {.unnumbered}

> **Hint:** You should be able to ~~cheat~~ borrow from code you used earlier to create the `country_us` variable.

4. Create a new variable called `born_country_us` that has the value `"USA"` if the laureate is born in the US, and `"Other"` otherwise.
    How many of the winners are born in the US?

5. Add a second variable to your visualization from Exercise 3 based on whether the laureate was born in the US or not.
    Based on your visualization, do the data appear to support Buzzfeed's claim?
    Explain your reasoning in 1-2 sentences.

    - Your final visualization should contain a facet for each category.
    - Within each facet, there should be a bar for whether the laureate won the award in the US or not.
    - Each bar should have segments for whether the laureate was born in the US or not.

🧶 ✅ ⬆️ Knit, *commit, and push your changes to GitHub with an appropriate commit message. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards.*

### Here's where those immigrant Nobelists were born {.unnumbered}

> Note: Your bar plot won't exactly match the one from the Buzzfeed article. This is likely because the data has been updated since the article was published.

6. In a single pipeline, filter for laureates who won their prize in the US, but were born outside of the US, and then create a frequency table (with the `count()` function) for their birth country (`born_country`) and arrange the resulting data frame in descending order of number of observations for each country. Which country is the most common?

🧶 ✅ ⬆️ Knit, *commit, and push your changes to GitHub with an appropriate commit message. Make sure to commit and push all changed files so that your Git pane is cleared up afterwards and review the md document on GitHub to make sure you're happy with the final state of your work.*

Now go back through your write up to make sure you've answered all questions and all of your R chunks are properly labeled.

## Interested in how Buzzfeed made their visualizations? {.unnumbered}

The plots in the Buzzfeed article are called waffle plots.
You can find the code used for making these plots in Buzzfeed's GitHub repo (yes, they have one!) [here](https://buzzfeednews.github.io/2017-01-immigration-and-science/).
You're not expected to recreate them as part of your assignment, but you're welcomed to do so for fun!
