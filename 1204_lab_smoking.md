# Lab: So what if you smoke when pregnant? {#lab12}

## Non-parametric-based inference {.unnumbered}



In 2004, North Carolina released a comprehensive birth record dataset that holds valuable insights for researchers examining the connection between expectant mothers' habits and practices and their child's birth. In this lab, we'll be exploring a randomly selected subset of that data to evaluate whether maternal smoking influences infant birthweight, and how other factors (like maternal age) relate to birth outcomes.

You'll practice non-parametric inference techniques such as bootstrapping and permutation testing. These methods allow you to test hypotheses and estimate uncertainty without assuming normally distributed populations. You'll also practice key data science skills: cleaning, filtering, visualizing, and interpreting real-world health data. You can find the lab [here](https://github.com/DataScience4Psych/lab-12-inference-smoking)


## Getting started {.unnumbered}

### Packages {.unnumbered}

In this lab, we will work with the **tidyverse**, **infer**, and **openintro** packages. We can install and load them with the following code:


``` r
library(tidyverse)
library(infer)
library(openintro)
```

### Housekeeping {.unnumbered}

#### Git configuration / password caching {.unnumbered}

Configure your Git user name and email. If you cannot remember the instructions, refer to an earlier lab. Also remember that you can cache your password for a limited amount of time.

#### Project name {.unnumbered}

Update the name of your project to match the lab's title.

### Warm up {.unnumbered}

Before diving into the dataset, let's warm up with some simple exercises.

#### YAML {.unnumbered}

Open the R Markdown (Rmd) file in your project, change the author name to your name, and knit the document. Doing so will allow you to personalize your Rmd file.

#### Commiting and pushing changes {.unnumbered}

- Go to the **Git** pane in your RStudio.
- View the **Diff** and confirm that you are happy with the changes.
- Add a commit message like "Update team name" in the **Commit message** box and hit **Commit**.
- Click on **Push**. This will prompt a dialogue box where you first need to enter your user name, and then your password.

### Set a seed! {.unnumbered}

In this lab, we'll be generating random samples. To make sure our results stay consistent, make sure to set a seed before you dive into the sampling process. Otherwise, the data will change each time you knit your lab. Set your seed in the chunk labeled "setup" so that your sampling and bootstrapping results stay consistent across runs and when knitting.

## The data

Load the `ncbirths` data from the `openintro` package:


``` r
data(ncbirths)
```

We have observations on 13 different variables, some categorical and some numerical. The meaning of each variable is provided in the following table.

variable         | description
---------------- | ---------------------------------------------
`fage`           | father's age in years.
`mage`           | mother's age in years.
`mature`         | maturity status of mother.
`weeks`          | length of pregnancy in weeks.
`premie`         | whether the birth was classified as premature (premie) or full-term.
`visits`         | number of hospital visits during pregnancy.
`marital`        | whether mother is `married` or `not married` at birth.
`gained`         | weight gained by mother during pregnancy in pounds.
`weight`         | weight of the baby at birth in pounds.
`lowbirthweight` | whether baby was classified as low birthweight (`low`) or not (`not low`).
`gender`         | gender of the baby, `female` or `male`.
`habit`          | status of the mother as a `nonsmoker` or a `smoker`.
`whitemom`       | whether mom is `White` or `not White`.

Before analyzing any new dataset, it's important to get to know your data...

## Exercises

1. Which variables in this dataset are numeric, and what do their distributions look like? Are there any outliers or extreme values that might affect your analysis?

Support your answers with both summary statistics and visualizations. You can use tools such as summary(), map_dfr(), or skim() for numerical summaries, and faceted boxplots or histograms to visualize distributions.  If you're not sure how to check efficiently, consider transforming the data into long format and using faceted boxplots.



### Baby weights

> Wen, Shi Wu, Michael S. Kramer, and Robert H. Usher. "Comparison of birth weight distributions between Chinese and Caucasian infants." American Journal of Epidemiology 141.12 (1995): 1177-1187.

<!-- I've decided to capitalize "White" to not perpetuate the idea that it is someone more generic/the default compared to other ancestries. "When we ignore the specificity and significance of Whiteness—the things that it is, the things that it does—we contribute to its seeming neutrality and thereby grant it power to maintain its invisibility."  https://zora.medium.com/im-a-black-scholar-who-studies-race-here-s-why-i-capitalize-white-f94883aa2dd3 -->

A 1995 study suggests that average weight of White babies born in the US is 3,369 grams (7.43 pounds). In this dataset, we have pretty limited information on race, we only know whether the mother is White. We will make the simplifying assumption that babies of White mothers are also White, i.e. `whitemom = "white"`. (Yes, I know that this assumption is a gross oversimplification).

We want to evaluate whether the average weight of White babies has changed since 1995.

Our null hypothesis should state "there is nothing going on", i.e. no change since 1995: $H_0: \mu = 7.43~pounds$.

Our alternative hypothesis should reflect the research question, i.e., some change since 1995. Since the research question doesn't state a direction for the change, we use a two-sided alternative hypothesis: $H_A: \mu \ne 7.43~pounds$.

2. To test whether the average birth weight of White babies has changed since 1995, we first need to isolate that group in our data. Create a filtered data frame called `ncbirths_white` that contains data only from White mothers. Then, calculate the mean of the weights of their babies.

> This sample mean will serve as your observed statistic when we build a null distribution in the next exercise.

<!-- Mason make this clearer to what this means -->

3. Are the criteria necessary for conducting simulation-based inference satisfied? Briefly consider whether simulation-based inference (e.g., bootstrapping) is appropriate in this context by addressing the following:
- Are observations in the sample independent of each other?
- Is the sample size reasonably large?
- Does the shape of the distribution pose any concerns (e.g., extreme skew or clustering)?

Use graphical summaries (histogram, boxplot) and/or numerical summaries to support your answer. Refer back to your plots or output from Exercise 1.


Let's discuss how this test would work. Our goal is to simulate what the distribution of sample means might look like if the true population mean were 7.43 pounds. To do that, we’ll use bootstrapping and then shift the resulting distribution to be centered under the null hypothesis.

You saw this process in the bootstrapping lecture (the "Rent in Edinburgh" example)—where we estimated a sampling distribution from a real dataset, then aligned it with a hypothetical population value in order to test whether the data were consistent with that value. The same logic applies here.

Here’s the general procedure:
- Take a bootstrap sample (with replacement) from ncbirths_white.
- Calculate the mean of this bootstrapped resample.
- Repeat these two steps many times (e.g., 1,000 or more) to create a bootstrap distribution of sample means.
- This distribution will be centered at the observed sample mean.
- To simulate the null hypothesis, shift the entire distribution so that its mean equals 7.43. You can do this by subtracting the bootstrap distribution’s mean from each value, and then adding 7.43 back.
- Once shifted, compare the observed mean to this distribution: calculate the proportion of simulated means that are at least as extreme as the observed mean (i.e., the p-value).

> 📌 If this logic feels abstract, go back and review the Lecture on Bootstrapping. The same shifting strategy was used there to simulate a null centered at a hypothesized rent value. 

4. Run a hypothesis test using simulation-based inference. Your goal is to simulate a null distribution of sample means assuming a population mean of 7.43 pounds, and then assess how unusual the observed sample mean is within that distribution.

To structure your analysis, work through the following steps:

4a. Use bootstrapping to simulate a distribution of sample means from ncbirths_white.

4b. Shift the distribution so that its center aligns with the null hypothesis value (7.43 pounds).

4c. Create a histogram of your shifted null distribution. Overlay a dashed vertical line to show your observed sample mean.

4d. Calculate the two-tailed p-value: what proportion of simulated means are at least as extreme (in both directions) as your observed value?

4e. Interpret your results. Based on the p-value and your visualization, what do you conclude about whether birth weight has changed since 1995?

### Baby weight vs. smoking

Consider the relationship between a mother's smoking habit and the weight of her baby. Plotting the data is a useful first step because it helps us quickly visualize trends, identify strong associations, and develop research questions.

5. Make side-by-side box plots displaying the relationship between `habit` and `weight`. What do you notice about the shape, center, and spread of the two groups? Are there any clear differences?

> Use this visualization to inform the question you’ll test in the next few exercises.


6. Before comparing the two groups, remove any rows with missing values in either habit or weight. Name this version `ncbirths_clean`. Why is it important to do this before calculating group summaries?



7. What is the observed difference in mean birth weight between babies born to smoking and non-smoking mothers?

Use the cleaned dataset to calculate the average birth weight for each group. Then compute the difference in means (non-smokers minus smokers).


``` r
ncbirths_clean %>%
  group_by(habit) %>%
  summarize(mean_weight = mean(weight))
```
> This observed difference is the statistic you’ll use to anchor your inference in the next step.

We can see that there's an observable difference, but is this difference meaningful? Is it statistically significant? We can answer this question by conducting a hypothesis test.
<!-- better scaffolding here to prep students -->

8. What are the hypotheses for testing whether smoking is associated with a difference in birth weight?

Formulate your hypotheses in both words and symbols.

- What does the null hypothesis say about the difference in average weights?

- What does the alternative hypothesis suggest?

Write your hypotheses clearly using:

- A contextual statement (in words)

- A symbolic version using $\mu_1$ and $\mu_2$, where each symbol refers to one of the two groups

> Optional: Sketch or describe what the null distribution might look like if the null hypothesis were true.


9. How can we use simulation-based inference to test whether maternal smoking is associated with a difference in birth weight?

Run the appropriate hypothesis test using either a bootstrap or permutation method. Use your cleaned dataset (`ncbirths_clean`) and compare the average birth weight between smokers and non-smokers.

To organize your analysis, consider the following:

- What kind of inference method is most appropriate here—bootstrap or permutation?

- What is your observed test statistic?

- How can you generate the sampling distribution under the null?

- What is the resulting p-value?

> You saw a similar structure when testing whether the average birth weight of White babies had changed. This time, you’re comparing two groups, so consider how the structure of the null distribution and test statistic changes.

10. How large could the difference in average birth weights plausibly be, based on your data?

Construct a 95% confidence interval for the difference in means between babies born to smoking and non-smoking mothers. Use a non-parametric method (e.g., bootstrapped difference in means) and report your results.


### Mother's age vs. baby weight

In this portion of the analysis, we focus on two variables. The first one is `maturemom`, which classifies mothers as either "younger" or "mature."

The second variable is `lowbirthweight`, a binary indicator of whether the baby’s birth weight was classified as "low."

In the following exercises, you’ll determine how `maturemom` is constructed and then test whether the rate of low birth weight differs between the two age groups.

11. First, a non-inference task: Determine the age cutoff for younger and mature mothers.

Use a method of your choice to determine where the cutoff lies between "younger" and "mature" mothers, based on the mature variable. How does this variable appear to be coded, and what is the minimum age that qualifies as a "mature" mother?

12. Is the proportion of low birth weight babies higher for mature mothers than for younger mothers?

Conduct a hypothesis test to evaluate whether the proportion of low birth weight babies differs between younger and mature mothers. Use a significance level of $\alpha = 0.05$.

Work through the following steps:

- Clearly state your null and alternative hypotheses (in words and in symbols).

- Consider the conditions for simulation-based inference. Are they met here?

- Choose an appropriate test (e.g., bootstrapped or permuted difference in proportions).

- Calculate the p-value and interpret the result in the context of the research question.

13. What is a plausible range for the difference in proportions of low birth weight babies between mature and younger mothers?

Construct a 95% confidence interval for the difference in proportions of low birth weight babies between the two groups. Then interpret the interval: what do the bounds tell you?


## Wrap up

In this lab, you practiced using non-parametric inference to analyze the impact of maternal smoking during pregnancy on the weight of the baby. Specifically, you used bootstrapping and permutation testing to analyze real-world health data from North Carolina birth records. You tested whether:
- The average birth weight of White babies has changed since 1995
- Maternal smoking is associated with lower average birth weight
- Mature mothers are more likely to have babies with low birth weight

Along the way, you also:
- Cleaned and filtered messy real-world data

- Explored variable distributions and checked model assumptions

- Interpreted p-values and confidence intervals in context

- Applied core concepts from earlier lectures, including simulation-based inference.

Remember to save your work, commit your changes, and push them to your Git repository!



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
