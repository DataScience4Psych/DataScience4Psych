

# Lecture: Meet our toolbox



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/SJaQtRLFb-Y" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


You can follow along with the slides [here][d02_toolkit] if you would like to open them full-screen. I recommend installing [R, Rstudio](#install), [git, and github](#installgit) before starting [activity 02](#bechdal)

<iframe src="https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html" width="672" height="400px" data-external="1"></iframe>


## Reproducible data analysis

What does it mean for a data analysis to be "reproducible"? This concept is at the heart of scientific integrity and a cornerstone of data science practice. It means that the results of your analysis can be recreated by others, and that your work is transparent and verifiable. Being able to reproduce the results of an analysis ensures that the conclusions drawn are reliable and can be built upon by future work.


### Reproducibility checklist

To gauge the reproducibility of a data analysis, consider the following near-term and long-term goals:


Near-term goals:

- __Are the tables and figures reproducible from the code and data?__ Everything we claim should be directly reproducible by running the code we’ve written.
- __Does the code actually do what you think it does?__ Verify that your code executes correctly and achieves its intended purpose.

Mid-term goals:

- __Is the code well-organized and documented?__ Structured and well-documented code is easier to understand and maintain.
- __Can someone else understand what you did?__  The code should be clear and well-documented so that others can understand and build upon it.

- __Can someone else understand why you did what you did?__ Understanding the rationale behind decisions, such as parameter settings, enhances clarity and reproducibility.

Long-term goals:

- __Can the code be used for other data?__ Flexibility in code for reuse with different datasets broadens the applicability of your work.
- __Can you extend the code to do other things?__ Structure your projects so that your codebase can be easily expanded for additional analyses or functionalities. Being able to build upon existing code without starting from scratch each time accelerates progress.


## Toolkit for Reproducible Data Analysis
A successful data analyst in psychology relies on a core set of tools:

- __Scriptability using R__, enabling direct manipulation of data.
- __Literate programming with R Markdown__, which integrates code, narrative, and output.
- __Version control through Git/GitHub__, documenting project evolution and facilitating collaboration.

The toolkit empowers us to achieve our reproducibility goals and supports a structured and efficient workflow:


## R and RStudio

### Install R and RStudio {#install}



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/kVIZGCT5p9U" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


* Install [R, a free software environment for statistical computing and graphics](https://www.r-project.org) from [CRAN][cran], the Comprehensive R Archive Network. I **highly recommend** you install a precompiled binary distribution for your operating system -- use the links up at the top of the CRAN page linked above!

* Install RStudio's IDE (stands for _integrated development environment_), a powerful user interface for R. Get the Open Source Edition of RStudio Desktop.

  * You can run either the [Preview version](https://www.rstudio.com/products/rstudio/download/preview/) or the official releases available [here](https://www.rstudio.com/products/rstudio/#Desktop).
  * RStudio comes with a **text editor**, so there is no immediate need to install a separate stand-alone editor.
  * RStudio can **interface with Git(Hub)**. However, you must do all the Git(Hub) set up [described elsewhere](https://happygitwithr.com) before you can take advantage of this.

If you have a pre-existing installation of R and/or RStudio, I **highly recommend** that you reinstall both and get as current as possible. It can be considerably harder to run old software than new.

* If you upgrade R, you will need to update any packages you have installed. The command below should get you started, though you may need to specify more arguments if, e.g., you have been using a non-default library for your packages.

``` r
update.packages(ask = FALSE, checkBuilt = TRUE)
```

**Note:** this  code will only look for updates on [CRAN][cran]. So if you use a package that lives _only_ on GitHub or if you want a development version from GitHub, you will need to  update manually, e.g. via `devtools::install_github()`.

### Testing testing

* Do whatever is appropriate for your OS to launch RStudio. You should get a window similar to the screenshot you see [here](https://www.rstudio.com/wp-content/uploads/2014/04/rstudio-workbench.png), but yours will be more boring because you haven't written any code or made any figures yet!

* Put your cursor in the pane labeled Console, which is where you interact with the live R process. Create a simple object with code like `x <- 3 * 4` (followed by enter or return). Then inspect the `x` object by typing `x` followed by enter or return. You should see the value 12 print to screen. If yes, you've succeeded in installing R and RStudio.

### Add-on packages

R is an extensible system and many people share useful code they have developed as a _package_ via [CRAN][cran] and GitHub. To install a package from [CRAN][cran], for example the [dplyr](https://CRAN.R-project.org/package=dplyr) package for data manipulation, here is one way to do it in the R console (there are others).

```r
install.packages("dplyr", dependencies = TRUE)
```

By including `dependencies = TRUE`, we are being explicit and extra-careful to install any additional packages the target package, dplyr in the example above, needs to have around.

You could use the above method to install the following packages, all of which we will use:

* tidyr, [package webpage](https://tidyr.tidyverse.org)
* ggplot2, [package webpage](https://ggplot2.tidyverse.org)

### Further resources

The above will get your basic setup ready but here are some links if you are interested in reading a bit further.

* [How to Use RStudio](https://support.rstudio.com/hc/en-us)
* [RStudio's leads for learning R](https://support.rstudio.com/hc/en-us/articles/200552336-Getting-Help-with-R)
* [R FAQ](https://cran.r-project.org/faqs.html)
* [R Installation and Administration](http://cran.r-project.org/doc/manuals/R-admin.html)
* [More about add-on packages in the R Installation and Administration Manual](https://cran.r-project.org/doc/manuals/R-admin.html#Add_002don-packages)




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
