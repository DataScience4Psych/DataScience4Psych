--- 
title: "PYS 70X"
subtitle: "Data Science for Psychologists: A Modernized Exploratory and Graphical Data Analysis with R"
author: 
- S. Mason Garrison

knit: "bookdown::render_book"
site: bookdown::bookdown_site
url: 'https\://github.com/R-Computing-Lab/DataScience4Psych'
github-repo: R-Computing-Lab/DataScience4Psych
twitter-handle: smasongarrison
cover-image: assets/stat545-logo.png
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "PSY 70x: Data Science for Psychologists: A Modernized Exploratory and Graphical Data Analysis with R"
favicon: assets/favicon.ico
---

# Welcome to STAT 545 {-}



Learn how to:

* explore, groom, visualize, and analyze data,
* make all of that reproducible, reusable, and shareable,
* using R.

This site is about everything that comes up during data analysis **except for statistical modeling and inference**. This might strike you as strange, given R's statistical roots. First, let me assure you we believe that modeling and inference are important. But the world already offers a lot of great resources for doing statistics with R.

The design of STAT 545 was motivated by the need to provide more balance in applied statistical training. Data analysts spend a considerable amount of time on project organization, data cleaning and preparation, and communication. These activities can have a profound effect on the quality and credibility of an analysis. Yet these skills are rarely taught, despite how important and necessary they are. STAT 545 aims to address this gap.

## History and future {-}

These materials originated in the STAT 545 course at the University of British Columbia:

> "The STAT 545 course became notable as an early example of a data science course taught in a statistics program. It is also notable for its focus on teaching using modern R packages, Git and GitHub, its extensive sharing of teaching materials openly online, and its strong emphasis on practical data cleaning, exploration, and visualization skills, rather than algorithms and theory." 
>  
> --- [Wikipedia](https://en.wikipedia.org/wiki/Jenny_Bryan)

The main author, Jenny Bryan ([jennybryan.org](https://jennybryan.org)), developed this version of STAT 545 as a professor at UBC. She has since joined [RStudio](https://www.rstudio.com/) as a Software Engineer, on the [tidyverse](https://www.tidyverse.org/) and [r-lib](https://github.com/r-lib/) teams and is an adjunct professor at UBC. In September 2019, we (amicably) created separate spaces for the ongoing maintenance of this content and the continued offerings of STAT 545 at UBC (<https://stat545.stat.ubc.ca>), which is alive and well.

We plan to continue maintaining these resources, as they are still used in [STAT 545 at UBC](https://stat545.stat.ubc.ca) and by people teaching themselves R. Some topics have since been developed more fully elsewhere and we may link out to those resources. For example, the Git and GitHub content of STAT 545 eventually grew into its own website: [happygitwithr.com](https://happygitwithr.com). Some material has been retired, but is archived in the [repository of the old website](https://github.com/STAT545-UBC/STAT545-UBC-original-website). Finally, the new website has URLs that are more human-friendly; we believe we created the necessary redirects, so we don't break other people's links. If you think we've missed one, please let us know [in an issue](https://github.com/rstudio-education/stat545/issues).

## Other contributors {-}

Several STAT 545 TAs were instrumental in the development of these materials and members of the RStudio Education Team ported the [original website](https://github.com/STAT545-UBC/STAT545-UBC-original-website) into the modern and more maintainable framework we enjoy today:

  * TAs who contributed content: [Dean Attali](http://deanattali.com/) (web applications with Shiny), [Julia Gustavsen](https://www.juliagustavsen.com) (Shiny), [Shaun Jackman](http://sjackman.ca) (automating workflows), [Bernhard Konrad](https://twitter.com/BernhardKonrad) (system setup, package development, the shell), [Gloria Li](https://twitter.com/LuolanLi) (regular expressions), [Andrew MacDonald](https://twitter.com/polesasunder) (getting data from the web), [Kieran Samuk](https://ksamuk.github.io) (regular expressions)
  * RStudio: Alison Hill (<https://alison.rbind.io>) and intern Grace Lawley (<https://grace.rbind.io>) lead the heroic effort to port a vintage R Markdown website into bookdown. Intern Desirée De Leon (<https://desiree.rbind.io>) contributed design expertise.

## Colophon {-}

This book was written in [bookdown](http://bookdown.org/) inside [RStudio](http://www.rstudio.com/ide/). The website [stat545.com](https://stat545.com) is hosted with [Netlify](https://www.netlify.com), and automatically updated after every commit by [Travis-CI](https://travis-ci.org). The complete source is available from [GitHub](https://github.com/rstudio-education/stat545).

The [STAT 545 logo](assets/stat545-logo.png) and the book style was designed by [Desirée De Leon](https://desiree.rbind.io/).

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
#>  date     2020-11-18
```

Along with these packages:

<!--html_preserve--><div id="htmlwidget-24d678555e4014060079" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-24d678555e4014060079">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","data":[["askpass","assertthat","backports","base64enc","BH","blob","bookdown","brew","broom","callr","cellranger","checkmate","cli","clipr","colorspace","commonmark","conflicted","covr","cpp11","crayon","crosstalk","crul","curl","DBI","dbplyr","desc","devtools","dichromat","digest","dplyr","DT","ellipsis","evaluate","fansi","farver","forcats","fs","gapminder","gender","genderdata","generics","geonames","ggplot2","gh","git2r","glue","gridExtra","gt","gtable","haven","highr","hms","htmltools","htmlwidgets","httpcode","httr","ini","isoband","jsonlite","knitr","labeling","later","lattice","lazyeval","lifecycle","lubridate","magrittr","markdown","MASS","Matrix","memoise","mgcv","mime","modelr","munsell","nlme","openssl","pillar","pkgbuild","pkgconfig","pkgload","plyr","praise","prettyunits","processx","progress","promises","ps","purrr","R6","rcmdcheck","RColorBrewer","Rcpp","readr","readxl","rebird","rematch","rematch2","remotes","reprex","reshape2","rex","rjson","rlang","rmarkdown","roxygen2","rplos","rprojroot","rstudioapi","rversions","rvest","sass","scales","selectr","sessioninfo","solrium","stringi","stringr","sys","testthat","tibble","tidyr","tidyselect","tidyverse","tinytex","triebeard","urltools","usethis","utf8","vctrs","viridis","viridisLite","whisker","withr","xfun","xml2","xopen","yaml"],[null,"0.2.1","1.1.10",null,null,"1.2.1","0.21",null,"0.7.1","3.5.1","1.1.0",null,"2.0.2",null,"1.4-1",null,null,null,null,"1.3.4",null,null,null,"1.1.0","1.4.4","1.2.0","2.3.2",null,"0.6.25","1.0.2","0.16","0.3.1","0.14","0.4.1",null,"0.5.0","1.5.0",null,null,null,"0.0.2",null,"3.3.2",null,null,"1.4.2",null,null,"0.3.0","2.3.1",null,"0.5.3","0.5.0","1.5.2",null,"1.4.2",null,null,"1.7.1","1.30",null,null,null,null,"0.2.0","1.7.9","1.5",null,null,null,"1.1.0",null,null,"0.1.8","0.5.0",null,null,"1.4.6","1.1.0","2.0.3","1.1.0",null,null,"1.1.1","3.4.4",null,null,"1.3.4","0.3.4","2.4.1",null,null,"1.0.5","1.3.1","1.3.1",null,null,null,"2.2.0","0.3.0",null,null,null,"0.4.7","2.5",null,null,"1.3-2","0.11",null,"0.3.6",null,"1.1.1",null,"1.1.1",null,"1.5.3","1.4.0",null,"2.3.2","3.0.3","1.1.2","1.1.0","1.3.0",null,null,null,"1.6.3",null,"0.3.4",null,null,null,"2.3.0","0.18","1.3.2",null,"2.2.1"],["2019-01-13","2019-03-21","2020-09-15","2015-07-28","2020-01-08","2020-01-20","2020-10-13","2011-04-13","2020-10-02","2020-10-13","2016-07-27","2020-02-06","2020-02-28","2019-07-23","2019-03-18","2018-12-01",null,"2020-09-16","2020-10-01","2017-09-16","2020-03-13","2020-07-30","2019-12-02","2019-12-15","2020-05-27","2018-05-01","2020-09-18","2013-01-24","2020-02-23","2020-08-18","2020-10-13","2020-05-15","2019-05-28","2020-01-08","2020-01-16","2020-03-01","2020-07-31","2017-10-31","2020-05-15","2020-11-17","2018-11-29","2019-02-19","2020-06-19","2020-01-24","2020-05-03","2020-08-27","2017-09-09","2020-08-05","2019-03-25","2020-06-01","2019-03-20","2020-01-08","2020-06-16","2020-10-03","2020-04-10","2020-07-20","2018-05-20","2020-06-20","2020-09-07","2020-09-22","2014-08-23","2020-06-05","2020-04-02","2019-03-15","2020-03-06","2020-06-08","2014-11-22","2019-08-07","2020-09-09","2019-11-27","2017-04-21","2020-08-27","2020-02-04","2020-05-19","2018-06-12","2020-08-23","2020-09-18","2020-07-10","2020-07-13","2019-09-22","2020-05-29","2020-03-03","2015-08-11","2020-01-24","2020-09-03","2019-05-16","2020-06-09","2020-08-11","2020-04-17","2019-11-12","2019-05-07","2014-12-07","2020-07-06","2018-12-21","2019-03-13","2019-10-24","2016-04-21","2020-05-01","2020-07-21","2019-05-16","2020-04-09","2020-04-21","2018-06-08","2020-07-09","2020-10-21","2020-06-27","2020-04-08","2018-01-03","2020-02-07","2020-05-25","2020-07-25","2020-03-18","2020-05-11","2019-11-20","2018-11-05","2019-11-02","2020-09-09","2019-02-10","2020-07-23","2020-03-02","2020-07-10","2020-08-27","2020-05-11","2019-11-21","2020-09-22","2016-08-04","2019-04-14","2020-09-17","2018-05-24","2020-08-29","2018-03-29","2018-02-01","2019-08-28","2020-09-22","2020-09-29","2020-04-23","2018-09-17","2020-02-01"],["CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)",null,"CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","local","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.0)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.0)","CRAN (R 4.0.0)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.3)","CRAN (R 4.0.2)","CRAN (R 4.0.0)"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>package<\/th>\n      <th>loadedversion<\/th>\n      <th>date<\/th>\n      <th>source<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":138,"autoWidth":true,"bInfo":false,"paging":false,"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[10,25,50,100,138]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

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


