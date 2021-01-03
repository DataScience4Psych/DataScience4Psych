--- 
title: "PSY 703"
subtitle: "Data Science for Psychologists: A Modernized Exploratory and Graphical Data Analysis with R"
author: 
- S. Mason Garrison

knit: "bookdown::render_book"
site: bookdown::bookdown_site
url: 'https\://github.com/R-Computing-Lab/DataScience4Psych'
github-repo: R-Computing-Lab/DataScience4Psych
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



Welcome to class! This website is designed to accompany Mason Garrison's Data Science for Psychologists (DS4P). DS4P is a graduate-level quantitative methods course at Wake Forest University. This website is both the syllabus and primary lecture materials. All the embedded lecture videos can be found on a [youtube playlist](https://www.youtube.com/playlist?list=PLKrrdtYgOUYbWGmSnbLIYwdLOnGm6une6)


<center><iframe width="560" height="315" src="http://www.youtube.com/embed/nYYJmmcgzr8?rel=0" frameborder="0" allowfullscreen></iframe></center>
## Course Introduction {-}

![](http://www.youtube.com/embed/HU39nOxcJYg?rel=0)


Data Science for Psychologists (DS4P) introduces on the principles of data science, including:

* data wrangling, 
* modeling, 
* visualization, and 
* communication. 

In this class, we link those principles to psychological methods and open science practices by emphasizing exploratory analyses and description, rather than confirmatory analyses and prediction. Through the semester we will work our way thru [Wickham and Grolemund's R for Data Science text](http://r4ds.had.co.nz/) and develop proficiency with [tidyverse](https://www.tidyverse.org/). This class emphasizes replication and reproducibility. DS4P is a practical skilled-based class and should be useful to students aiming for academia as well as those interested in industry. Applications of these methods can be applied to a full range of psychological areas, including perception (e.g, eye-tracking data), neuroscience (e.g., visualizing neural networks), and individual differences (e.g., valence analysis).





## Broad Topics {-}
This class cover the following broad five areas:

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

* [R for Data Science text](http://r4ds.had.co.nz/) [@Wickham2017R]

### Software {-}

#### R {-}

R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows, and MacOS.


#### R Studio {-}



#### GitHub {-}



## Course Modality

This class is a blended class. The online portions are asynchronous. I've created a video highlighting how to be a successful asynchronous learner. 

<center><iframe width="560" height="315" src="http://www.youtube.com/embed/dc3D2tbl8G0?rel=0" frameborder="0" allowfullscreen></iframe></center>

Much of this information comes from Northeastern University's [Tips for Taking Online Classes](https://www.northeastern.edu/graduate/blog/tips-for-taking-online-classes/)

## Attribution {-}

This class leans heavily on other peoples' materials and ideas. I have done my best to document the origin of the materials and ideas. They include: 

* Jenny Bryan's ([jennybryan.org](https://jennybryan.org)) [STAT 545](https://www.Stat545.com);

* Joe Rodgers's PSY 8751 Exploratory and Graphical Data Analysis Course

* [Julia Fukuyama](https://jfukuyama.github.io/)'s [EXPLORATORY DATA ANALYSIS](https://jfukuyama.github.io/teaching/stat670/)

You can see specific changes by examining the [edit history on the git repo](https://github.com/R-Computing-Lab/DataScience4Psych/commits/master)

### STAT 545 {-}

Jenny Bryan's ([jennybryan.org](https://jennybryan.org)) [STAT 545](https://www.Stat545.com) course is from the University of British Columbia.

> "The STAT 545 course became notable as an early example of a data science course taught in a statistics program. It is also notable for its focus on teaching using modern R packages, Git and GitHub, its extensive sharing of teaching materials openly online, and its strong emphasis on practical data cleaning, exploration, and visualization skills, rather than algorithms and theory." 
>  
> --- [Wikipedia](https://en.wikipedia.org/wiki/Jenny_Bryan)


### PSY 8751 {-}

Joe Rodgers's EXPLORATORY and GRAPHICAL DATA ANALYSIS course was developed at the University of Oklahoma. I took his class while a graduate student at Vanderbilt University.

### Stat 470/670 {-}

[Julia Fukuyama](https://jfukuyama.github.io/)'s [EXPLORATORY DATA ANALYSIS](https://jfukuyama.github.io/teaching/stat670/) is an R based class. She's an Assistant Professor in the Department of Statistics at Indiana University.

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
#>  date     2021-01-03
```

Along with these packages:

<!--html_preserve--><div id="htmlwidget-3b710f962c7e390ed773" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-3b710f962c7e390ed773">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","data":[["askpass","assertthat","backports","base64enc","BH","blob","bookdown","brew","broom","callr","cellranger","checkmate","cli","clipr","colorspace","commonmark","conflicted","covr","cpp11","crayon","crosstalk","crul","curl","DBI","dbplyr","desc","devtools","dichromat","digest","dplyr","DT","ellipsis","evaluate","fansi","farver","forcats","fs","gapminder","gender","genderdata","generics","geonames","ggplot2","gh","git2r","glue","gridExtra","gt","gtable","haven","highr","hms","htmltools","htmlwidgets","httpcode","httr","ini","isoband","jsonlite","knitr","labeling","later","lattice","lazyeval","lifecycle","lubridate","magrittr","markdown","MASS","Matrix","memoise","mgcv","mime","modelr","munsell","nlme","openssl","pillar","pkgbuild","pkgconfig","pkgload","plyr","praise","prettyunits","processx","progress","promises","ps","purrr","R6","rcmdcheck","RColorBrewer","Rcpp","readr","readxl","rebird","rematch","rematch2","remotes","reprex","reshape2","rex","rjson","rlang","rmarkdown","roxygen2","rplos","rprojroot","rstudioapi","rversions","rvest","sass","scales","selectr","sessioninfo","solrium","stringi","stringr","sys","testthat","tibble","tidyr","tidyselect","tidyverse","tinytex","triebeard","urltools","usethis","utf8","vctrs","viridis","viridisLite","whisker","withr","xfun","xml2","xopen","yaml"],[null,"0.2.1","1.1.10",null,null,"1.2.1","0.21",null,"0.7.1","3.5.1","1.1.0",null,"2.0.2",null,"1.4-1",null,null,null,null,"1.3.4",null,null,null,"1.1.0","1.4.4","1.2.0","2.3.2",null,"0.6.25","1.0.2","0.16","0.3.1","0.14","0.4.1",null,"0.5.0","1.5.0",null,null,null,"0.0.2",null,"3.3.2",null,null,"1.4.2",null,null,"0.3.0","2.3.1",null,"0.5.3","0.5.0","1.5.2",null,"1.4.2",null,null,"1.7.1","1.30",null,null,null,null,"0.2.0","1.7.9","1.5",null,null,null,"1.1.0",null,null,"0.1.8","0.5.0",null,null,"1.4.6","1.1.0","2.0.3","1.1.0",null,null,"1.1.1","3.4.4",null,null,"1.3.4","0.3.4","2.4.1",null,null,"1.0.5","1.3.1","1.3.1",null,null,null,"2.2.0","0.3.0",null,null,null,"0.4.7","2.5",null,null,"1.3-2","0.11",null,"0.3.6",null,"1.1.1",null,"1.1.1",null,"1.5.3","1.4.0",null,"2.3.2","3.0.3","1.1.2","1.1.0","1.3.0",null,null,null,"1.6.3",null,"0.3.4",null,null,null,"2.3.0","0.18","1.3.2",null,"2.2.1"],["2019-01-13","2019-03-21","2020-09-15","2015-07-28","2020-01-08","2020-01-20","2020-10-13","2011-04-13","2020-10-02","2020-10-13","2016-07-27","2020-02-06","2020-02-28","2019-07-23","2019-03-18","2018-12-01",null,"2020-09-16","2020-10-01","2017-09-16","2020-03-13","2020-07-30","2019-12-02","2019-12-15","2020-05-27","2018-05-01","2020-09-18","2013-01-24","2020-02-23","2020-08-18","2020-10-13","2020-05-15","2019-05-28","2020-01-08","2020-01-16","2020-03-01","2020-07-31","2017-10-31","2020-05-15","2020-11-17","2018-11-29","2019-02-19","2020-06-19","2020-01-24","2020-05-03","2020-08-27","2017-09-09","2020-08-05","2019-03-25","2020-06-01","2019-03-20","2020-01-08","2020-06-16","2020-10-03","2020-04-10","2020-07-20","2018-05-20","2020-06-20","2020-09-07","2020-09-22","2014-08-23","2020-06-05","2020-04-02","2019-03-15","2020-03-06","2020-06-08","2014-11-22","2019-08-07","2020-09-09","2019-11-27","2017-04-21","2020-08-27","2020-02-04","2020-05-19","2018-06-12","2020-08-23","2020-09-18","2020-07-10","2020-07-13","2019-09-22","2020-05-29","2020-03-03","2015-08-11","2020-01-24","2020-09-03","2019-05-16","2020-06-09","2020-08-11","2020-04-17","2019-11-12","2019-05-07","2014-12-07","2020-07-06","2018-12-21","2019-03-13","2019-10-24","2016-04-21","2020-05-01","2020-07-21","2019-05-16","2020-04-09","2020-04-21","2018-06-08","2020-07-09","2020-10-21","2020-06-27","2020-04-08","2018-01-03","2020-02-07","2020-05-25","2020-07-25","2020-03-18","2020-05-11","2019-11-20","2018-11-05","2019-11-02","2020-09-09","2019-02-10","2020-07-23","2020-03-02","2020-07-10","2020-08-27","2020-05-11","2019-11-21","2020-09-22","2016-08-04","2019-04-14","2020-09-17","2018-05-24","2020-08-29","2018-03-29","2018-02-01","2019-08-28","2020-09-22","2020-09-29","2020-04-23","2018-09-17","2020-02-01"],["CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)",null,"CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","local","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>package<\/th>\n      <th>loadedversion<\/th>\n      <th>date<\/th>\n      <th>source<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":138,"autoWidth":true,"bInfo":false,"paging":false,"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[10,25,50,100,138]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

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


