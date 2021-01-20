--- 
title: "Data Science for Psychologists"
subtitle: "A Modernized Exploratory and Graphical Data Analysis with R"
author: 
- S. Mason Garrison
date: "2021-01-20"
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
description: "PSY 703: Data Science for Psychologists: A Modernized Exploratory and Graphical Data Analysis with R"
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




# Course Introduction: Module 0  {-}

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


## Attribution  {-}

This class leans heavily on other peoples' materials and ideas. I have done my best to document the origin of the materials and ideas. They include: 

* Jenny Bryan's ([jennybryan.org](https://jennybryan.org)) [STAT 545](https://www.Stat545.com);

* Joe Rodgers's PSY 8751 Exploratory and Graphical Data Analysis Course

* [Julia Fukuyama](https://jfukuyama.github.io/)'s [EXPLORATORY DATA ANALYSIS](https://jfukuyama.github.io/teaching/stat670/)

* Mine Çetinkaya-Rundel's [Data Science in a Box](https://datasciencebox.org/).

You can see specific changes by examining the [edit history on the git repo](https://github.com/DataScience4Psych/DataScience4Psych/commits/master)



## Colophon {-}

This book was written in [bookdown](http://bookdown.org/) inside [RStudio](http://www.rstudio.com/ide/). The website [r-computing-lab.github.io/DataScience4Psych](https://r-computing-lab.github.io/DataScience4Psych) is hosted with [github](https://www.github.com), The complete source is available from [GitHub](https://github.com/R-Computing-Lab/DataScience4Psych).

The [Psych 703 logo](assets/logo.png) was designed by me and the book style was designed by [Desirée De Leon](https://desiree.rbind.io/).

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
#>  date     2021-01-20
```

Along with these packages:


```{=html}
<div id="htmlwidget-cf58913da07627418413" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cf58913da07627418413">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","data":[["askpass","assertthat","backports","base64enc","BH","blob","bookdown","brew","brio","broom","callr","cellranger","cli","clipr","colorspace","commonmark","conflicted","covr","cpp11","crayon","credentials","crosstalk","curl","DBI","dbplyr","desc","devtools","dichromat","diffobj","digest","dplyr","DT","ellipsis","evaluate","fansi","farver","forcats","fs","gapminder","gender","genderdata","generics","geonames","gert","ggplot2","gh","gitcreds","glue","gridExtra","gt","gtable","haven","highr","hms","htmltools","htmlwidgets","httr","ini","isoband","jsonlite","knitr","labeling","later","lattice","lazyeval","lifecycle","lubridate","magrittr","markdown","MASS","Matrix","memoise","mgcv","mime","modelr","munsell","nlme","openssl","pillar","pkgbuild","pkgconfig","pkgload","praise","prettyunits","processx","progress","promises","ps","purrr","R6","rappdirs","rcmdcheck","RColorBrewer","Rcpp","readr","readxl","rebird","rematch","rematch2","remotes","reprex","rex","rlang","rmarkdown","roxygen2","rplos","rprojroot","rstudioapi","rversions","rvest","scales","selectr","sessioninfo","stringi","stringr","sys","testthat","tibble","tidyr","tidyselect","tidyverse","tinytex","usethis","utf8","vctrs","viridis","viridisLite","waldo","whisker","withr","xfun","xml2","xopen","yaml","zip"],[null,"0.2.1","1.2.1",null,null,null,"0.21",null,null,"0.7.3","3.5.1","1.1.0","2.2.0",null,"2.0-0",null,null,null,null,"1.3.4",null,null,"4.3","1.1.1","2.0.0","1.2.0","2.3.2",null,null,"0.6.27","1.0.2","0.17","0.3.1","0.14","0.4.1",null,"0.5.0","1.5.0",null,null,null,"0.1.0",null,null,"3.3.3",null,null,"1.4.2",null,null,"0.3.0","2.3.1",null,"1.0.0","0.5.1.9000","1.5.3","1.4.2",null,null,"1.7.2","1.30",null,null,null,null,"0.2.0","1.7.9.2","2.0.1",null,null,null,"1.1.0",null,null,"0.1.8","0.5.0",null,null,"1.4.7","1.2.0","2.0.3","1.1.0",null,"1.1.1","3.4.5",null,null,"1.5.0","0.3.4","2.5.0",null,null,null,"1.0.6","1.4.0","1.3.1",null,null,null,"2.2.0","0.3.0",null,"0.4.10","2.6",null,null,"2.0.2","0.13",null,"0.3.6","1.1.1",null,"1.1.1","1.5.3","1.4.0",null,"3.0.1","3.0.4","1.1.2","1.1.0","1.3.0",null,"2.0.0",null,"0.3.6",null,null,null,null,"2.4.0","0.20","1.3.2",null,"2.2.1",null],["2019-01-13","2019-03-21","2020-12-09","2015-07-28","2021-01-11","2020-01-20","2020-10-13","2011-04-13","2020-08-31","2020-12-16","2020-10-13","2016-07-27","2020-11-20","2020-10-08","2020-11-11","2018-12-01","2019-06-21","2020-09-16","2021-01-12","2017-09-16","2020-07-21","2021-01-12","2019-12-02","2021-01-15","2020-11-03","2018-05-01","2020-09-18",null,"2021-01-07","2020-10-24","2020-08-18","2021-01-06","2020-05-15","2019-05-28","2020-01-08","2020-01-16","2020-03-01","2020-07-31",null,null,null,"2020-10-31",null,"2020-11-12","2020-12-30","2020-11-27","2020-12-04","2020-08-27","2017-09-09",null,"2019-03-25","2020-06-01","2019-03-20","2021-01-13","2021-01-12","2020-12-10","2020-07-20","2018-05-20","2020-12-01","2020-12-09","2020-09-22","2020-10-20","2020-06-05","2020-04-02","2019-03-15","2020-03-06","2020-11-13","2020-11-17","2019-08-07","2020-09-09","2019-11-27","2017-04-21","2020-08-27","2020-02-04","2020-05-19","2018-06-12","2020-08-23","2020-09-18","2020-11-20","2020-12-15","2019-09-22","2020-05-29","2015-08-11","2020-01-24","2020-11-30","2019-05-16","2020-06-09","2020-12-05","2020-04-17","2020-10-28","2016-03-28","2019-05-07","2014-12-07","2021-01-15","2020-10-05","2019-03-13",null,"2016-04-21","2020-05-01","2020-07-21","2019-05-16","2020-04-21","2020-12-30","2020-12-14","2020-06-27",null,"2020-11-15","2020-11-12","2020-05-25","2020-07-25","2020-05-11","2019-11-20","2018-11-05","2020-09-09","2019-02-10","2020-07-23","2020-12-17","2020-10-12","2020-08-27","2020-05-11","2019-11-21","2020-12-14","2020-12-10","2018-05-24","2020-12-17","2018-03-29","2018-02-01","2020-11-09","2019-08-28","2021-01-16","2021-01-06","2020-04-23","2018-09-17","2020-02-01","2020-08-27"],["CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)",null,"CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)",null,null,null,"CRAN (R 4.0.3)",null,"CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)",null,"CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","Github (rstudio/htmltools@11cfbf3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)",null,"CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)",null,"CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>package<\/th>\n      <th>loadedversion<\/th>\n      <th>date<\/th>\n      <th>source<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":135,"autoWidth":true,"bInfo":false,"paging":false,"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[10,25,50,100,135]}},"evals":[],"jsHooks":[]}</script>
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


