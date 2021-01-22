--- 
title: "Data Science for Psychologists"
subtitle: "A Modernized Exploratory & Graphical Data Analysis in R"
author: 
- S. Mason Garrison
date: "2021-01-21"
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
description: "PSY 703: Data Science for Psychologists: A Modernized Exploratory and Graphical Data Analysis in R"
favicon: assets/favicon.ico

---

# Welcome to PSY 703 {-}


Welcome to class! This website is designed to accompany Mason Garrison's Data Science for Psychologists (DS4P). DS4P is a graduate-level quantitative methods course at Wake Forest University. This website hosts the lab notes.  All the embedded lecture videos can be found on a [youtube playlist](https://www.youtube.com/playlist?list=PLKrrdtYgOUYbWGmSnbLIYwdLOnGm6une6). You can find the current version of the course syllabus [here](https://github.com/smasongarrison/Syllabi/blob/master/syllabus_datascience.pdf), along with all of the [other syllabi for my classes]( https://github.com/smasongarrison/Syllabi).


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/nYYJmmcgzr8" width="533" height="300" frameborder="0" allowfullscreen=""></iframe>
</div>
</div>
```




# Course Introduction: Module 00 {-}

This overview is designed to orient you to the class. Please watch the videos from this [playlist](https://www.youtube.com/playlist?list=PLKrrdtYgOUYaEAnJX20Ryy4OSie375rVY) and work your way through the notes. Although the module-level playlists are embedded in the course, you can find the full-course video playlist [here](https://www.youtube.com/playlist?list=PLKrrdtYgOUYaEAnJX20Ryy4OSie375rVY). 




```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/HU39nOxcJYg" width="533" height="300" frameborder="0" allowfullscreen=""></iframe>
</div>
</div>
```

Data Science for Psychologists (DS4P) introduces on the principles of data science, including:

* data wrangling, 
* modeling, 
* visualization, and 
* communication. 

In this class, we link those principles to psychological methods and open science practices by emphasizing exploratory analyses and description, rather than confirmatory analyses and prediction. Through the semester we will work our way thru [Wickham and Grolemund's R for Data Science text](http://r4ds.had.co.nz/) and develop proficiency with [tidyverse](https://www.tidyverse.org/). This class emphasizes replication and reproducibility. DS4P is a practical skilled-based class and should be useful to students aiming for academia as well as those interested in industry. Applications of these methods can be applied to a full range of psychological areas, including perception (e.g, eye-tracking data), neuroscience (e.g., visualizing neural networks), and individual differences (e.g., valence analysis).


## Big Ideas {-}
This class covers the following broad five areas:

* Reproducibility;
* Replication;
* Robust Methods;
* Resplendent Visualizations; and
* R Programming.


## Materials {-}

### Hardware {-}

This class is requires that you have a laptop that can run R.

### Required Texts {-}

The text is intended to supplement the videos, lecture notes, and in-class tutorials. You need to consume all four in order to be successful in this class.

* [R for Data Science text](http://r4ds.had.co.nz/)

### Software {-}

#### R and RStudio{-}


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/kVIZGCT5p9U" width="533" height="300" frameborder="0" allowfullscreen=""></iframe>
</div>
</div>
```


R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows, and MacOS.

RStudio is a free _integrated development environment_ (IDE), a powerful user interface for R.

### Git and Github {-}

Git is a version control system. Its original purpose was to help groups of developers work collaboratively on big software projects. Git manages the evolution of a set of files – called a repository – in a structured way. Think of it like the "Track Changes" features from Microsoft Word.

Github is a free IDE and hosting service for Git. As a Wake Forest student, you should be able to access the [GitHub Student Developer Pack for free](https://education.github.com/benefits?type=student). It includes a free PRO upgrade for your github account


## Knowledge is Power {-}


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/dc3D2tbl8G0" width="533" height="300" frameborder="0" allowfullscreen=""></iframe>
</div>
</div>
```

This brief video is covers the icebreaker I do in all of my classes. I encourage you to watch it. In it, I discuss stereotype threats and statistics anxiety.

## Course Modality {-}

This class is a blended class. The online portions are asynchronous. I've created a video highlighting how to be a successful asynchronous learner. 



```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/kVIZGCT5p9U" width="533" height="300" frameborder="0" allowfullscreen=""></iframe>
</div>
</div>
```

Much of this information comes from Northeastern University's [Tips for Taking Online Classes](https://www.northeastern.edu/graduate/blog/tips-for-taking-online-classes/)


# Attribution  {-}

This class leans heavily on other peoples' materials and ideas. I have done my best to document the origin of the materials and ideas. They include: 

* Jenny Bryan's ([jennybryan.org](https://jennybryan.org)) [STAT 545](https://www.Stat545.com);

* Joe Rodgers's PSY 8751 Exploratory and Graphical Data Analysis Course

* [Julia Fukuyama](https://jfukuyama.github.io/)'s [EXPLORATORY DATA ANALYSIS](https://jfukuyama.github.io/teaching/stat670/)

* Mine Çetinkaya-Rundel's [Data Science in a Box](https://datasciencebox.org/).

You can see specific changes by examining the [edit history on the git repo](https://github.com/DataScience4Psych/DataScience4Psych/commits/master)



# Colophon {-}

This book was written in [bookdown](http://bookdown.org/) inside [RStudio](http://www.rstudio.com/ide/). The [website]( datascience4psych.github.io/DataScience4Psych) is hosted with [github](https://www.github.com), The complete source is available from [GitHub](https://github.com/DataScience4Psych/DataScience4Psych).

The book style was designed by [Desirée De Leon](https://desiree.rbind.io/).

This version of the book was built with:


```
#> Finding R package dependencies ... Done!
#>  setting  value                       
#>  version  R version 4.0.3 (2020-10-10)
#>  os       Windows 10 x64              
#>  system   x86_64, mingw32             
#>  ui       RTerm                       
#>  language (EN)                        
#>  collate  English_United States.1252  
#>  ctype    English_United States.1252  
#>  tz       America/New_York            
#>  date     2021-01-21
```

Along with these packages:


```{=html}
<div id="htmlwidget-1beaf45881a34968ff43" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1beaf45881a34968ff43">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","data":[["askpass","assertthat","backports","base64enc","BH","blob","bookdown","brew","brio","broom","callr","cellranger","checkmate","cli","clipr","colorspace","commonmark","conflicted","covr","cpp11","crayon","credentials","crosstalk","crul","curl","DBI","dbplyr","desc","devtools","dichromat","diffobj","digest","dplyr","DT","ellipsis","evaluate","fansi","farver","forcats","fs","gapminder","gender","genderdata","generics","geonames","gert","ggplot2","gh","gitcreds","glue","gridExtra","gt","gtable","haven","highr","hms","htmltools","htmlwidgets","httpcode","httr","ini","isoband","jsonlite","knitr","labeling","later","lattice","lazyeval","lifecycle","lubridate","magrittr","markdown","MASS","Matrix","memoise","mgcv","mime","modelr","munsell","nlme","openssl","pillar","pkgbuild","pkgconfig","pkgload","plyr","praise","prettyunits","processx","progress","promises","ps","purrr","R6","rappdirs","rcmdcheck","RColorBrewer","Rcpp","readr","readxl","rebird","rematch","rematch2","remotes","reprex","reshape2","rex","rjson","rlang","rmarkdown","roxygen2","rplos","rprojroot","rstudioapi","rversions","rvest","sass","scales","selectr","sessioninfo","solrium","stringi","stringr","sys","testthat","tibble","tidyr","tidyselect","tidyverse","tinytex","triebeard","urltools","usethis","utf8","vctrs","viridis","viridisLite","waldo","whisker","withr","xfun","xml2","xopen","yaml","zip"],[null,"0.2.1","1.2.1",null,null,null,"0.21",null,null,"0.7.3","3.5.1","1.1.0",null,"2.2.0",null,"2.0-0",null,null,null,null,"1.3.4",null,null,null,"4.3","1.1.1","2.0.0","1.2.0","2.3.2",null,null,"0.6.27","1.0.2","0.17","0.3.1","0.14","0.4.1",null,"0.5.0","1.5.0",null,null,null,"0.1.0",null,null,"3.3.3",null,null,"1.4.2",null,null,"0.3.0","2.3.1",null,"1.0.0","0.5.1","1.5.3",null,"1.4.2",null,null,"1.7.2","1.30",null,null,null,null,"0.2.0","1.7.9.2","2.0.1",null,null,null,"1.1.0",null,null,"0.1.8","0.5.0",null,null,"1.4.7","1.2.0","2.0.3","1.1.0",null,null,"1.1.1","3.4.5",null,null,"1.5.0","0.3.4","2.5.0",null,null,null,"1.0.5","1.4.0","1.3.1",null,null,null,"2.2.0","0.3.0",null,null,null,"0.4.10","2.6",null,null,"2.0.2","0.13",null,"0.3.6",null,"1.1.1",null,"1.1.1",null,"1.5.3","1.4.0",null,"3.0.1","3.0.5","1.1.2","1.1.0","1.3.0",null,null,null,"2.0.0",null,"0.3.6",null,null,null,null,"2.4.0","0.20","1.3.2",null,"2.2.1",null],["2019-01-13","2019-03-21","2020-12-09","2015-07-28","2021-01-11","2020-01-20","2020-10-13","2011-04-13","2020-08-31","2020-12-16","2020-10-13","2016-07-27","2020-02-06","2020-11-20","2020-10-08","2020-11-11","2018-12-01","2019-06-21","2020-09-16","2021-01-12","2017-09-16","2020-07-21","2021-01-12","2020-07-30","2019-12-02","2021-01-15","2020-11-03","2018-05-01","2020-09-18","2013-01-24","2021-01-07","2020-10-24","2020-08-18","2021-01-06","2020-05-15","2019-05-28","2020-01-08","2020-01-16","2020-03-01","2020-07-31","2017-10-31","2020-05-15","2020-11-17","2020-10-31","2019-02-19","2020-11-12","2020-12-30","2020-11-27","2020-12-04","2020-08-27","2017-09-09","2020-08-05","2019-03-25","2020-06-01","2019-03-20","2021-01-13","2021-01-12","2020-12-10","2020-04-10","2020-07-20","2018-05-20","2020-12-01","2020-12-09","2020-09-22","2020-10-20","2020-06-05","2020-04-02","2019-03-15","2020-03-06","2020-11-13","2020-11-17","2019-08-07","2020-09-09","2019-11-27","2017-04-21","2020-08-27","2020-02-04","2020-05-19","2018-06-12","2020-08-23","2020-09-18","2020-11-20","2020-12-15","2019-09-22","2020-05-29","2020-03-03","2015-08-11","2020-01-24","2020-11-30","2019-05-16","2020-06-09","2020-12-05","2020-04-17","2020-10-28","2016-03-28","2019-05-07","2014-12-07","2020-07-06","2020-10-05","2019-03-13","2019-10-24","2016-04-21","2020-05-01","2020-07-21","2019-05-16","2020-04-09","2020-04-21","2018-06-08","2020-12-30","2020-12-14","2020-06-27","2020-04-08","2020-11-15","2020-11-12","2020-05-25","2020-07-25","2020-03-18","2020-05-11","2019-11-20","2018-11-05","2019-11-02","2020-09-09","2019-02-10","2020-07-23","2020-12-17","2021-01-15","2020-08-27","2020-05-11","2019-11-21","2020-12-14","2016-08-04","2019-04-14","2020-12-10","2018-05-24","2020-12-17","2018-03-29","2018-02-01","2020-11-09","2019-08-28","2021-01-16","2021-01-06","2020-04-23","2018-09-17","2020-02-01","2020-08-27"],["CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","local","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>package<\/th>\n      <th>loadedversion<\/th>\n      <th>date<\/th>\n      <th>source<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":145,"autoWidth":true,"bInfo":false,"paging":false,"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[10,25,50,100,145]}},"evals":[],"jsHooks":[]}</script>
```

## License {-}

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

<center>
<i class="fab fa-creative-commons fa-2x"></i><i class="fab fa-creative-commons-by fa-2x"></i><i class="fab fa-creative-commons-sa fa-2x"></i>
</center>

*This is a human-readable summary of (and not a substitute for) the license.
Please see <https://creativecommons.org/licenses/by-sa/4.0/legalcode> for the full legal text.*

**You are free to:**

- **Share**---copy and redistribute the material in any medium or
  format

- **Remix**---remix, transform, and build upon the material for any
  purpose, even commercially.

The licensor cannot revoke these freedoms as long as you follow the
license terms.

**Under the following terms:**

- **Attribution**---You must give appropriate credit, provide a link
  to the license, and indicate if changes were made. You may do so in
  any reasonable manner, but not in any way that suggests the licensor
  endorses you or your use.
  
- **ShareAlike**---If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 

- **No additional restrictions**---You may not apply legal terms or
  technological measures that legally restrict others from doing
  anything the license permits.

**Notices:**

You do not have to comply with the license for elements of the
material in the public domain or where your use is permitted by an
applicable exception or limitation.

No warranties are given. The license may not give you all of the
permissions necessary for your intended use. For example, other rights
such as publicity, privacy, or moral rights may limit how you use the
material.



# Sitemap {-}

```{=html}
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#sxrrqnclbl .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#sxrrqnclbl .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sxrrqnclbl .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#sxrrqnclbl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#sxrrqnclbl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sxrrqnclbl .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sxrrqnclbl .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#sxrrqnclbl .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#sxrrqnclbl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#sxrrqnclbl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#sxrrqnclbl .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#sxrrqnclbl .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#sxrrqnclbl .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#sxrrqnclbl .gt_from_md > :first-child {
  margin-top: 0;
}

#sxrrqnclbl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#sxrrqnclbl .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#sxrrqnclbl .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#sxrrqnclbl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sxrrqnclbl .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#sxrrqnclbl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sxrrqnclbl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#sxrrqnclbl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#sxrrqnclbl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sxrrqnclbl .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sxrrqnclbl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#sxrrqnclbl .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sxrrqnclbl .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#sxrrqnclbl .gt_left {
  text-align: left;
}

#sxrrqnclbl .gt_center {
  text-align: center;
}

#sxrrqnclbl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#sxrrqnclbl .gt_font_normal {
  font-weight: normal;
}

#sxrrqnclbl .gt_font_bold {
  font-weight: bold;
}

#sxrrqnclbl .gt_font_italic {
  font-style: italic;
}

#sxrrqnclbl .gt_super {
  font-size: 65%;
}

#sxrrqnclbl .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="sxrrqnclbl" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">title</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">link</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">attribution</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/attribution.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">colophon</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/colophon.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">course introduction module 00</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/course-introduction-module-00.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">cross validation</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/cross-validation.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">data and ethics</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/data-and-ethics.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">data and visualization</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/data-and-visualization.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">data types and data transformations</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/data-types-and-data-transformations.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">fitting and interpreting models</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/fitting-and-interpreting-models.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">functions</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/functions.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">grammar of data wrangling</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/grammar-of-data-wrangling.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">index</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/index.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">interactive web apps</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/interactive-web-apps.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab work on portfolios</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab-work-on-portfolios.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab01</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab01.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab02</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab02.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab03</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab03.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab04</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab04.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab05</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab05.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab06</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab06.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab07</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab07.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab08</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab08.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab09</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab09.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab10</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab10.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab11</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab11.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lab13</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/lab13.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">prediction and overfittinga</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/prediction-and-overfittinga.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">quantifying uncertainty</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/quantifying-uncertainty.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">references</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/references.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">scientific studies and confounding module 06</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/scientific-studies-and-confounding-module-06.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">sitemap</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/sitemap.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">special topics</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/special-topics.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">tips for effective data visualization</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/tips-for-effective-data-visualization.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">web scraping</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/web-scraping.html">website</a></td>
    </tr>
    <tr>
      <td class="gt_row gt_left">welcome to data science</td>
      <td class="gt_row gt_center"><a href="https://datascience4psych.github.io/DataScience4Psych/welcome-to-data-science.html">website</a></td>
    </tr>
  </tbody>
  
  
</table></div>
```
