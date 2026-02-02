# Lab: Modeling professor attractiveness and course evaluations {#lab10}



## Why are hot professors “better” teachers? {.unnumbered}


At the end of most college courses, students are asked to evaluate the class and the instructor—usually anonymously, often hastily, sometimes with one hand already on the doorknob. These are often used to assess instructor effectiveness, allocate merit raises, and sometimes even decide whether people keep their jobs.

But are course evaluations actually measuring teaching quality? Or are they picking up on other things—like a professor’s appearance?


In a now-classic economics paper, Daniel Hamermesh and Amy Parker looked at whether professors who are considered more physically attractive get higher evaluation scores. The short answer? Yeah, they do. You can read their study [here](http://www.sciencedirect.com/science/article/pii/S0272775704001165).^[ Daniel S. Hamermesh, Amy Parker, Beauty in the classroom: instructors pulchritude and putative pedagogical productivity, Economics of Education Review, Volume 24, Issue 4, August 2005, Pages 369-376, ISSN 0272-7757, 10.1016/j.econedurev.2004.07.013.] The dataset we’ll use comes from a slightly modified version of the replication data included with [*Data Analysis Using Regression and Multilevel/Hierarchical Models*](https://www.cambridge.org/core/books/data-analysis-using-regression-and-multilevelhierarchical-models/2379C12C0ACB1E29B2DABF65E6EF1DC5) by Gelman and Hill.

In this lab, you'll explore that dataset—focusing on one predictor at a time—to get a feel for how linear models behave, how to interpret them, and how to visualize their results. Along the way, you’ll also get a preview of just how messy “evaluation” can be when the outcome depends on variables that have nothing to do with teaching.




### Packages {.unnumbered}


We'll use  **tidyverse**, **openintro**, and **broom** to wrangle, model, and tidy up our regression output.



``` r
library(tidyverse)
library(broom)
library(openintro)
```


## The data {.unnumbered}

The dataset we'll be using is called `evals` from the **openintro** package. Take a peek at the codebook with `?evals`.

## Exercises {.unnumbered}

### Part 1: Getting to know the outcome {.unnumbered}

Before we model anything, let’s look at what students actually do with the evaluation scale.

1. Visualize the distribution of `score`. Is the distribution skewed? Are students generous? Harsh? Do most scores pile up near the top? Include at least one plot and a couple of numerical summaries, and tell me what you notice.

Now let's introduce the main character in this dataset: `bty_avg`. This variable is a professor's average beauty rating.

2. Create a scatterplot of `score` versus `bty_avg`. Describe what you see. Trend? Noise? Clusters? Total chaos? Don’t overthink it; just describe what you see.

> **Hint:** See the help page for the function at <http://ggplot2.tidyverse.org/reference/index.html>.

3. Recreate your scatterplot, but use `geom_jitter()` instead of `geom_point()`. What does jittering fix here, and what would someone misunderstand if they only saw the non-jittered plot?


### Part 2: Beauty as a predictor {.unnumbered}

> **Recall:** Linear model is in the form $\hat{y} = b_0 + b_1 x$.

Let's see if the apparent trend in the plot is something more than natural variation. 

1. Fit a linear model called `m_bty` to predict average professor evaluation `score` by average beauty rating (`bty_avg`). Write the fitted regression equation, and then interpret the slope in plain language: What does a one-point increase in beauty predict for evaluation scores?

2. Replot your existing visualization, this time add a regression line in orange. Turn off the default shading around the line. (By default, the plot includes shading around the line.)

3. Then, stepping back, interpret what this model is really saying:

- How much do evaluation scores change with beauty ratings (slope)?
- What does the intercept represent here? Is it meaningful in this context, or just a mathematical artifact? Explain your reasoning.
- What is the $R^2$ value of this model? Interpret it in context. What does it tell you about whether beauty is a “big deal” or a pretty minor piece of the story?
- That shading you turned off represents uncertainty around the line—why might it be easy to read too much into it at this stage?


### Part 3: Linear regression with a categorical predictor {.unnumbered}

Let’s switch gears from numeric predictors to categorical ones. Beauty scores might be (somewhat) continuous, but characteristics like `gender` and `rank` are categorical, meaning they fall into distinct groups.

We’ll start by seeing whether evaluation scores differ by `gender`.



``` r
m_gen <- lm(score ~ gender, data = evals)
tidy(m_gen)
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)    4.09     0.0387    106.   0      
#> 2 gendermale     0.142    0.0508      2.78 0.00558
```

1. Take a look at the model output. What’s the reference level? What do the coefficients tell you about how evaluation scores differ between male and female professors? Write the predicted mean evaluation score for each gender.

Now let’s do one more categorical predictor: `rank`

Actually, let's do three slightly different versions of this model to see how changing the reference level or regrouping categories affects the output. 

Create a new variable from `rank` called `rank_relevel` where `"tenure track"` is the baseline level. Create another new variable called `tenure_eligible` that labels `"teaching"` faculty as `"no"` and labels `"tenure track"` and `"tenured"` faculty as `"yes"`.

2. Fit three different linear models to explore how `rank` affects evaluation scores. Each of these models will use a different version of the `rank` variable to predict average professor evaluation `score`

3. Based on the regression outputs, interpret how teaching faculty and tenured faculty differ from that baseline. (Hint you should interpret the slopes and intercepts for all three models in context of the data.)

4. Report the $R^2$. Does rank explain much, or not really?


### Part 4: Multiple linear regression {.unnumbered}

Now we’re going to ask a more interesting question:

Is the “beauty effect” still there once we account for gender?

Fit these two models:

- `m_bty: score ~ bty_avg`

- `m_bty_gen: score ~ bty_avg + gender`

Then answer:

1. What changes in the beauty slope when gender is added?

2. For two professors with the same beauty rating, does gender still shift the predicted score?

3. Compare the adjusted $R^2$ values. Is gender actually helping much, or is beauty doing most of the work already?

Finally, swap gender out and add rank instead.

4. Fit `m_bty_rank: score ~ bty_avg + rank`  and then interpret one rank coefficient and the beauty slope in context.


### Part 3: The search for the best model {.unnumbered}

Going forward, only consider the following variables as potential predictors: `rank`, `ethnicity`, `gender`, `language`, `age`, `cls_perc_eval`, `cls_did_eval`, `cls_students`, `cls_level`, `cls_profs`, `cls_credits`, `bty_avg`.

1. Which variable, on its own, would you expect to be the worst predictor of evaluation scores? Why? *Hint:* Think about which variable would you expect to not have any association with the professor's score.

2. Check your suspicions from the previous exercise. Include the model output for that variable in your response.

3. Suppose you wanted to fit a full model with the variables listed above. If you are already going to include `cls_perc_eval` and `cls_students`, which variable should you not include as an additional predictor? Why?

4. Fit a full model with all predictors listed above (except for the one you decided to exclude) in the previous question.

5. Using backward-selection with adjusted R-squared as the selection criterion, determine the *best* model. You do not need to show all steps in your answer, just the output for the final model. Also, write out the linear model for predicting score based on the final model you settle on.

6. Interpret the slopes of one numerical and one categorical predictor based on your final model.

7. Based on your final model, describe the characteristics of a professor and course at University of Texas at Austin that would be associated with a high evaluation score.

8. Would you be comfortable generalizing your conclusions to apply to professors generally (at any university)? Why or why not?



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
