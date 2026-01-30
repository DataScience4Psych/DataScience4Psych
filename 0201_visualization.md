# (PART) Module 02 {-}



# Welcome to Data and Visualization

This module is designed to introduce you to exploratory and graphical data analysis.
Please watch the videos and work your way through the notes. **The videos start on the next page.**  
You can find the video playlist for this module [here][pl_02]. The slides used to make the videos in this module can be found in the [slides repo][course_slides].

## Module Materials

* Slides from Lectures
  * [Data and visualization][d03_dataviz]
  * [Visualizing data with ggplot2][d04_ggplot2]
  * [Visualizing numerical data][d05_viznum]
  * [Visualizing categorical data][d06_vizcat]
* Suggested Readings
  * All subchapters of this module, including
    * [Basic care and feeding of data in R](#basiccare)
  * R4DS
    * [Data Exploratation Section](https://r4ds.had.co.nz/explore-intro.html), including
    * [Data visualization](https://r4ds.had.co.nz/data-visualization.html)
    * [Exploratory Data Analysis](https://r4ds.had.co.nz/exploratory-data-analysis.html)
* Activities
  * [Star Wars!][ae03_starwars]
* Lab
  * [Plastic waste](#lab02)
  
### Estimated Video Length

<!-- https://www.youtube.com/playlist?list=PLKrrdtYgOUYZmr_T3PnuxjVIlj0C0kUNI & https://ytplaylist-len.herokuapp.com/ -->

No of videos : 9

Average length of video : 13 minutes, 34 seconds

Total length of playlist : 2 hours, 2 minutes, 11 seconds

# Exploratory Data Analysis

You can follow along with the slides [here][d03_dataviz] if you would like to open them full-screen.



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/IUP3qCIjk4Q" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d03_dataviz/d03_dataviz.html" width="672" height="400px" data-external="1"></iframe>

## What is in a dataset?



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/J6arziOCQpk" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d03_dataviz/d03_dataviz.html#23" width="672" height="400px" data-external="1"></iframe>

### Why do we visualize?



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/E5IY1FQv0OM" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d03_dataviz/d03_dataviz.html#35" width="672" height="400px" data-external="1"></iframe>


```{=html}
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">New preprint with <a href="https://twitter.com/Mark_A_Thornton?ref_src=twsrc%5Etfw">@Mark_A_Thornton</a>! Very grateful for the opportunity to learn many new tools and expand my thinking in this project! We found that beautiful data visualizations bias the popularity of scientific papers and the circulation of information on social media and news. <a href="https://t.co/hPfbyFsNdJ">https://t.co/hPfbyFsNdJ</a></p>&mdash; Chujun Lin 林楚君 (@LinChujun) <a href="https://twitter.com/LinChujun/status/1478075789379653633?ref_src=twsrc%5Etfw">January 3, 2022</a></blockquote>

```


Data visualization is a powerful tool for understanding and communicating insights from data. Research has shown that effective visualizations can reveal patterns, relationships, and anomalies that might be missed in raw numerical data [@lin2022power].

# Visualizing data with ggplot2


```{=html}
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">Does anyone else feel that their affinity for an artistic skill helps them with statistics? Just me?</p>&mdash; Valerie Polad (@valeriepolad) <a href="https://twitter.com/valeriepolad/status/1388733898926870533?ref_src=twsrc%5Etfw">May 2, 2021</a></blockquote>

```

```{=html}
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">Your data visualizations suck.<br><br>In the beginning, at least. <br><br>See, that’s the secret no one tells you. We all sucked when we got started. <br><br>Make bad visualizations and share them. A lot of them. Then people will help you and they’ll get better. <br><br>That’s how you learn.</p>&mdash; Oh, Friend. (@oh__friend) <a href="https://twitter.com/oh__friend/status/1469332905503731713?ref_src=twsrc%5Etfw">December 10, 2021</a></blockquote>

```


You can follow along with the slides [here][d04_ggplot2] if you would like to open them full-screen.



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/-tdEQXdx-SA" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d04_ggplot2/d04_ggplot2.html" width="672" height="400px" data-external="1"></iframe>

## ggplot2 and aesthetics



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/K2u2_lcgdks" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d04_ggplot2/d04_ggplot2.html#26" width="672" height="400px" data-external="1"></iframe>

# Visualizing numerical data

You can follow along with the slides [here][d05_viznum] if you would like to open them full-screen.



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/hGylk9UaM2k" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d05_viznum/d05_viznum.html" width="672" height="400px" data-external="1"></iframe>

## Looking at Data



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/sN2gCCd2Rr8" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


## More on visualizing numerical data

Fun fact, when you screen capture with [f.lux](https://justgetflux.com/) running in the background, f.lux is captured too.



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/7OWyhBWMoM8" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d05_viznum/d05_viznum.html#12" width="672" height="400px" data-external="1"></iframe>

# Visualizing categorical data

You can follow along with the slides [here][d06_vizcat] if you would like to open them full-screen.



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/xY819zNKdnY" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d06_vizcat/d06_vizcat.html" width="672" height="400px" data-external="1"></iframe>

# Star Wars Activity

<iframe src="https://datascience4psych.github.io/slides/d06_vizcat/d06_vizcat.html#15" width="672" height="400px" data-external="1"></iframe>

You can find the materials for the Star Wars activity [here][ae03_starwars]. The compiled version should look something like the following...

<iframe src="https://datascience4psych.github.io/ae-03-starwars-dataviz/starwars.html" width="672" height="400px" data-external="1"></iframe>




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
