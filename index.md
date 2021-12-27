--- 
title: "Data Science for Psychologists"
subtitle: "A Refreshed Exploratory & Graphical Data Analysis in R"
author: 
- S. Mason Garrison
date: "2021-12-27"
knit: "bookdown::render_book"
site: bookdown::bookdown_site
url: 'https\://github.com/DataScience4Psych/DataScience4Psych'
github-repo: DataScience4Psych/DataScience4Psych
twitter-handle: smasongarrison
cover-image: assets/logo.png
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "PSY 703: Data Science for Psychologists: A Refreshed Exploratory and Graphical Data Analysis in R"
favicon: assets/favicon.ico

---


# (PART\*) Front Matter {-}

# Welcome to PSY 703 {-}




Welcome to class! This website is designed to accompany Mason Garrison's Data Science for Psychologists (DS4P). DS4P is a graduate-level quantitative methods course at Wake Forest University. This class assumes zero knowledge of programming, computer science, linear algebra, probability, or really anything fancy. I encourage anyone who is quant-curious to work their way through these course notes. The course notes include lectures, worked examples, readings, activities, and labs. You can find the current version of the course syllabus [here](https://github.com/smasongarrison/Syllabi/blob/master/syllabus_datascience.pdf), along with all of the [other syllabi for my classes]( https://github.com/smasongarrison/Syllabi). All the embedded lecture videos can be found on a [youtube playlist][pl_all]. 


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/nYYJmmcgzr8" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


## Mason Notes {-}





This website is constantly changing. This new course is in active development, and approximately 100% done. I have made this process explicitly transparent because I want you to see how you can use R to produce some pretty neat things. Indeed, I've included the source code for this website in the class [github](https://github.com/DataScience4Psych). I encourage you to contribute to the [course code](https://github.com/DataScience4Psych/DataScience4Psych). If you catch typos, errors, please issue a pull request with the fixes. If you find cool / useful resources, please add them. By the end of the semester, I would love for everyone to have contributed to the course materials. It can be as simple as adding a course request to the [wishlist](#course-wishlist). I believe that it is useful skill to be able to do. 



### How to use these notes {-}

This document is broken down into multiple chapters. Use the table of contents on the left side of the screen to navigate, and use the hamburger icon (horizontal bars) at the top of the document to open or close the table of contents. At the top of the document, you'll see additional icons which you can click to search the document, change the size, font or color scheme of the page. The document will be updated (unpredictably) throughout the semester.


Every module corresponds to a weeks worth of material. Most modules are dedicated to improving a specific skill or at the very least dedicated to a specific theme. Within each module, there are embedded videos, slides, activities, labs, and tutorials. The skills developed in each module build upon skills you've developed in previous modules. Eventually, this class will have more modules available than weeks in a semester, so that you -- the reader can choose your own adventure (err... module) you'd like to start with. 


Although these notes share some of the features of a textbook, they are neither comprehensive nor completely original. The main purpose is to give you all a set of common materials on which to draw during the course. In class, we will sometimes do things outside the notes. The idea here is that you will read the materials and try to learn from them, just as you will attend classes and try to learn from them.

### Status of course {-}

In terms of timing, I will have each module completed by the start of the week. Given that the class meets either on Monday or Friday, the start of the "week" will be Wednesday at 12 p.m. EST. It is possible that I will get ahead of this deadline. You can see the current status of the course below. Although you are welcome to work ahead, be aware that I will be making changes to modules that haven't officially started yet. In addition, I may add optional materials to previous modules that might be helpful. 



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/fwJHNw9jU_U" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

This table provides the current status of the course. It lists proportions of specific components by module. Overall it is 100% complete. 



```{=html}
<div id="htmlwidget-5d0541b497387a5dd005" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-5d0541b497387a5dd005">{"x":{"filter":"none","vertical":false,"data":[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,null],[null,1,1,1,1,1,1,1,1,1,null,1,null,1,null,null],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,null,null],[null,1,1,1,1,1,null,1,1,null,null,null,null,null,null,null],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>Module<\/th>\n      <th>Slides<\/th>\n      <th>Lab<\/th>\n      <th>Videos<\/th>\n      <th>Application<\/th>\n      <th>Lecture Notes<\/th>\n      <th>Status<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"autoWidth":true,"bInfo":false,"paging":false,"columnDefs":[{"className":"dt-right","targets":[0,1,2,3,4,5,6]}],"order":[],"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```






<!--DS4P Links-->
[course_web]: https://datascience4psych.github.io/DataScience4Psych
[course_git]: https://github.com/DataScience4Psych/DataScience4Psych
[course_slides]: https://github.com/DataScience4Psych/slides

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
[pl_all]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbWGmSnbLIYwdLOnGm6une6


<!--AE. Links-->
[ae01a_unvotes]: https://github.com/DataScience4Psych/ae-01a-un-votes
[ae01b_covid]: https://github.com/DataScience4Psych/ae-01b-covid
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
