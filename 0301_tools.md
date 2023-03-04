# (PART) Module 03 {-}





# Welcome to the tidyverse!

Welcome to the world of data wrangling and the tidyverse! This module is designed to guide you through the essential process of transforming and reshaping raw data into a more usable format. As you'll soon discover, data wrangling is a crucial step in the data pipeline and plays a vital role in ensuring that your data are of high quality and ready for analysis.

You're in for an exciting journey as you learn about your data and discover how to avoid biases and misunderstandings due to poor data quality. The best part is, getting started is easy! Simply watch the instructional videos and follow along with the accompanying notes. The video playlist for this module can be found [here][pl_03], and the slides used in the videos are available in the [slides repo][course_slides]. To start watching the videos, simply turn to the next page and dive in!


## Module Materials

* Slides from Lectures
  * [Tidy data][d07_tidy]
  * [Grammar of data wrangling][d08_grammar]
  * [Hands on Data Wrangling][d09_wrangle]
  * [Working with Multiple Data Frames][d10_dfs]
* Suggested Readings
  * All subchapters of this module, including
      * [Introduction to dplyr](#dplyr_intro)
      * [Merges on Github](#merges)
  * R4DS     
      * [Data Wrangling](https://r4ds.had.co.nz/wrangle-intro.html), including
        * [Tidy Data](https://r4ds.had.co.nz/tidy-data.html)
        * [Pipes](https://r4ds.had.co.nz/pipes.html)
* Activities
  * [Hotels!](https://github.com/DataScience4Psych/ae-04-hotels-datawrangling)
* Lab
  * [Nobel Laureates](#lab03)

## Estimated Video Length

<!--https://ytplaylist-len.herokuapp.com/ -->


No of videos : 8

Average length of video : 14 minutes, 11 seconds

Total length of playlist : 1 hour, 53 minutes, 34 seconds



# Tidy data

You can follow along with the slides [here][d07_tidy] if they do not appear below.


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/wdDKr92ZT3s" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```



<iframe src="https://datascience4psych.github.io/slides/d07_tidy/d07_tidy.html" width="672" height="400px" data-external="1"></iframe>

## Data structures in R


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/fE2zILoY53Y" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


<iframe src="https://datascience4psych.github.io/slides/d07_tidy/d07_tidy.html#11" width="672" height="400px" data-external="1"></iframe>


# Grammar of data wrangling

You can follow along with the slides [here][d08_grammar] if they do not appear below.


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/XLj1sJWIv84" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

<iframe src="https://datascience4psych.github.io/slides/d08_grammar/d08_grammar.html" width="672" height="400px" data-external="1"></iframe>

## Piping


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/nOrblReuiiA" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```



<iframe src="https://datascience4psych.github.io/slides/d08_grammar/d08_grammar.html#19" width="672" height="400px" data-external="1"></iframe>



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
