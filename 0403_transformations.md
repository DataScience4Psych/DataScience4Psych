# ODD: Transformations data!




This optional deep dive covers data transformations, and Tukey's ladder of powers. 

## Transforming Data: Tukey's Ladder of Powers

<!-- http://blackwell.math.yorku.ca/math4939/lectures/transforming_data_tukeys_ladder_of_powers.R -->

This material is based on @fox2016applied ch. 4, pp. 28 - 80.

We will use the following data set(s) from @fox2016applied.


```r
# Download these files manually.
# Make sure to the directory to the file in which this file was saved
#fox_data <- "http://socserv.socsci.mcmaster.ca/jfox/Books/Applied-Regression-3E/datasets/"
#download.file(paste0(fox_data,'UnitedNations.txt'),'UnitedNations.txt')

# 
if (!require("spida2"))  devtools::install_github('gmonette/spida2')
#> Loading required package: spida2
#> 
#> Attaching package: 'spida2'
#> The following object is masked from 'package:lubridate':
#> 
#>     years
#> The following object is masked from 'package:purrr':
#> 
#>     map
#> The following object is masked from 'package:readr':
#> 
#>     cols
#> The following object is masked from 'package:ggplot2':
#> 
#>     labs
if (!require("p3d"))  install.packages("p3d", repos = "http://R-Forge.R-project.org")
#> Loading required package: p3d
#> Loading required package: rgl
#> Loading required package: car
#> Loading required package: carData
#> 
#> Attaching package: 'car'
#> The following object is masked from 'package:dplyr':
#> 
#>     recode
#> The following object is masked from 'package:purrr':
#> 
#>     some
#> Loading required package: mgcv
#> Loading required package: nlme
#> 
#> Attaching package: 'nlme'
#> The following object is masked from 'package:spida2':
#> 
#>     getData
#> The following object is masked from 'package:dplyr':
#> 
#>     collapse
#> This is mgcv 1.8-41. For overview type 'help("mgcv-package")'.
#> 
#> Attaching package: 'p3d'
#> The following object is masked from 'package:car':
#> 
#>     Identify3d
#> The following objects are masked from 'package:spida2':
#> 
#>     cell, center, ConjComp, dell, disp, ell, ell.conj, ellbox, ellplus,
#>     ellpt, ellptc, elltan, elltanc, uv
#> The following object is masked from 'package:knitr':
#> 
#>     spin

library(p3d)
library(car)
library(spida2)
library(latticeExtra)
#> Loading required package: lattice
#> 
#> Attaching package: 'latticeExtra'
#> The following object is masked from 'package:ggplot2':
#> 
#>     layer

# read data
un <- read.table('data/UnitedNations.txt', header = TRUE)
head(un)
#>                region  tfr contraception educationMale educationFemale lifeMale
#> Afghanistan      Asia 6.90            NA            NA              NA     45.0
#> Albania        Europe 2.60            NA            NA              NA     68.0
#> Algeria        Africa 3.81            52          11.1             9.9     67.5
#> American.Samoa   Asia   NA            NA            NA              NA     68.0
#> Andorra        Europe   NA            NA            NA              NA       NA
#> Angola         Africa 6.69            NA            NA              NA     44.9
#>                lifeFemale infantMortality GDPperCapita economicActivityMale
#> Afghanistan          46.0             154         2848                 87.5
#> Albania              74.0              32          863                   NA
#> Algeria              70.3              44         1531                 76.4
#> American.Samoa       73.0              11           NA                 58.8
#> Andorra                NA              NA           NA                   NA
#> Angola               48.1             124          355                   NA
#>                economicActivityFemale illiteracyMale illiteracyFemale
#> Afghanistan                       7.2         52.800            85.00
#> Albania                            NA             NA               NA
#> Algeria                           7.8         26.100            51.00
#> American.Samoa                   42.4          0.264             0.36
#> Andorra                            NA             NA               NA
#> Angola                             NA             NA               NA
un$country <- rownames(un)
```

Finding transformations to make regressions behave


```r
gd() 
xyplot(infantMortality ~ GDPperCapita, un)
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-3-1.png" width="672" />

```r
xyplot(log(infantMortality) ~ log(GDPperCapita), un)
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-3-2.png" width="672" />


John Tukey suggested this simple toolkit, like a set drill bits of varying sizes, to modify the shape of distributions  and the shape of relationships between variables. The basic idea stems from the fact that functions of the form

$$y' = y^p, \quad y > 0$$

have a graph that is concave up if $p >1$, and concave down if $0<p<1$.


For $p < 0$,

$$y' = - y^p, \quad y > 0$$

The graph is also concave down.

This graph leaves out $p=0$ but we will see shortly that $y' = \ln y$ is the sensible transformation that corresponds to $p = 0$.

Now, we standardize the family of power transformations so that they have the value 0 when $y = 1$ and so their derivative is equal to 1 when $y=1$.

For $p \ne 0$, this yields $$y' = \frac{y^p - 1}{p}$$

Note that, by l’Hôpital’s rule: 

$$\lim_{p \to 0} \frac{y^p - 1}{p}= \lim_{p \to 0}\, e^{\, p \ln y} \ln  y = \ln  y$$

We define a function that produces this transformation. The easy way to define it is:


```r
pow <- function(y, p) {
  if (p == 0) {
    log(y) 
  } else (y^p - 1)/p 
}

# test:
x <- seq(-1,3,.5)
x # note that these transformations are really intended for y > 0
#> [1] -1.0 -0.5  0.0  0.5  1.0  1.5  2.0  2.5  3.0
pow(x, 2) 
#> [1]  0.000 -0.375 -0.500 -0.375  0.000  0.625  1.500  2.625  4.000
pow(x, 0)  %>% 
  name(x)
#> Warning in log(y): NaNs produced
#>     -1   -0.5      0    0.5      1    1.5      2    2.5      3 
#>    NaN    NaN   -Inf -0.693  0.000  0.405  0.693  0.916  1.099
pow(x, -1) %>% 
  name(x) %>% 
  cbind
#>           .
#> -1    2.000
#> -0.5  3.000
#> 0      -Inf
#> 0.5  -1.000
#> 1     0.000
#> 1.5   0.333
#> 2     0.500
#> 2.5   0.600
#> 3     0.667
plot(exp) # easy plotting of a function
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-4-1.png" width="672" />

```r
plot(function(x) pow(x, p=2)) # anonymous function or 'lambda'
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-4-2.png" width="672" />

```r
plot(function(x) pow(x, p=.5), xlim=c(0,3)) 
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-4-3.png" width="672" />

But this approach has the disadvantage that it works correctly only for a single value of $p$ because the statement `if(p == 0)` only tests the first element of `p`.

## Vectorizing a function

Most operators in R are __vectorized__ so they work element-wise when their arguments are vectors. When the arguments have incompatible lengths, the shorter argument is __recycled__ to have the same length as the longer one. That is why the following produces sensible results:


```r
z <- c(3,5,9)
z + c(1,1,1)
#> [1]  4  6 10
z + 1  # 1 is recycled so the result is equivalent to the previous line
#> [1]  4  6 10
z + c(1,2,3)
#> [1]  4  7 12
z + c(1,2) # recycles but gives a warning
#> Warning in z + c(1, 2): longer object length is not a multiple of shorter
#> object length
#> [1]  4  7 10
z + z
#> [1]  6 10 18
z^2
#> [1]  9 25 81
z^z
#> [1] 2.70e+01 3.12e+03 3.87e+08
```

We can use `ifelse` which works on a vector instead of a single value.


```r
pow <- function(y, p) {
  p <- rep(p, length.out = length(y))
  y <- rep(y, length.out = length(p))
  ifelse(p==0, log(y), (y^p - 1)/p) 
}
# test:
pow(-1:4, c(2,0,-1,1,3))
#> Warning in log(y): NaNs produced
#> [1] 0.00 -Inf 0.00 1.00 8.67 7.50
pow(-1:4, 2)
#> [1]  0.0 -0.5  0.0  1.5  4.0  7.5
```

With a bit more work, we can avoid unnecessary evaluations:


```r
pow <- function(y, p) {
  p <- rep(p, length.out = length(y))
  y <- rep(y, length.out = length(p))
  y[p==0] <- log(y[p==0])
  y[p!=0] <- (y[p!=0]^p[p!=0] -1) / p[p!=0]
  y
}

# Test:

pow(1:10,0) == log(1:10)
#>  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
pow(1:10,-1)
#>  [1] 0.000 0.500 0.667 0.750 0.800 0.833 0.857 0.875 0.889 0.900
pow(1:10,.5)
#>  [1] 0.000 0.828 1.464 2.000 2.472 2.899 3.292 3.657 4.000 4.325
pow(1:10,-1:8)
#>  [1] 0.00e+00 6.93e-01 2.00e+00 7.50e+00 4.13e+01 3.24e+02 3.36e+03 4.37e+04
#>  [9] 6.83e+05 1.25e+07
```


Let's plot this transformation for a range of values of $p$. The value of `expand.grid` is a data frame whose rows consist of the Cartesian product (i.e. all possible combinations) of its arguments.


```r
expand.grid(a = c("A","B"), x = 1:3) 
#>   a x
#> 1 A 1
#> 2 B 1
#> 3 A 2
#> 4 B 2
#> 5 A 3
#> 6 B 3


dd <- expand.grid(y = seq(.01,3,.01), p = c(-2,-1,-.5,0,.5,1,2,3))
dim(dd)
#> [1] 2400    2
head(dd)
#>      y  p
#> 1 0.01 -2
#> 2 0.02 -2
#> 3 0.03 -2
#> 4 0.04 -2
#> 5 0.05 -2
#> 6 0.06 -2
some(dd) # 10 rows at random
#>         y    p
#> 362  0.62 -1.0
#> 559  2.59 -1.0
#> 588  2.88 -1.0
#> 678  0.78 -0.5
#> 897  2.97 -0.5
#> 1019 1.19  0.0
#> 1026 1.26  0.0
#> 1376 1.76  0.5
#> 1643 1.43  1.0
#> 2096 2.96  2.0


dd$yval <- with(dd, pow(y,p))
xyplot(yval ~ y| factor(p), dd, type = 'l')
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-8-1.png" width="672" />

```r
xyplot(yval ~ y| factor(p), dd, type = 'l', ylim =c(-2,max(dd$yval)))
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-8-2.png" width="672" />

```r
xyplot(yval ~ y , dd, groups = p, type = 'l', ylim =c(-2,max(dd$yval)))
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-8-3.png" width="672" />

```r
xyplot(yval ~ y , dd, 
       groups = p, 
       type = 'l',
       xlim = c(0,3),
       ylim =c(-2,max(dd$yval)))
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-8-4.png" width="672" />

```r
gd(8, lwd = 2) # number of colours needed
xyplot(yval ~ y , dd, 
       groups = p, 
       type = 'l',
       xlim = c(0,3),
       ylim =c(-2,max(dd$yval)))
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-8-5.png" width="672" />

```r
xyplot(yval ~ y , dd, 
       groups = p, 
       type = 'l',
       auto.key = list(space = 'right',lines = T, points = F),
       xlim = c(0,3),
       ylim =c(-2,max(dd$yval)))
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-8-6.png" width="672" />

It's much better to have the legend in the same order as the lines in the graph. We can turn `p` into a factor and reverse its order.


```r
dd$po <- factor(dd$p)
dd$po <- reorder(dd$po, -dd$p)
xyplot(yval ~ y , dd, 
       groups = po, 
       type = 'l',
       auto.key = list(space = 'right',lines = T, points = F, title='power'),
       xlim = c(0,3),
       ylim =c(-2,max(dd$yval)))
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-9-1.png" width="672" />

From quantile plots:

Uniform quantiles...


```r

xqplot(un)
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-10-1.png" width="672" /><img src="0403_transformations_files/figure-html/unnamed-chunk-10-2.png" width="672" />

Normal quantiles


```r
xqplot(un, ptype = 'normal')
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-11-1.png" width="672" /><img src="0403_transformations_files/figure-html/unnamed-chunk-11-2.png" width="672" />

We see that none of the numeric variables have normal distributions.  

- 'age' is somewhat platykurtic compared with a normal
- 'compositeHourlyWages' has both a categorical (0) and  a continuous component
- 'education' is also platykurtic
- 'working' is dichotomous
- 'familyIncome' is skewed to the right

Note that the fact that $x$ or $y$ variables are not normal does not mean that the conditional distribution of $y$ given $x$ is not normal.  


Let's explore wages of working women as a function of education.


```r
library(latticeExtra)
un %>% 
  xyplot(infantMortality ~ GDPperCapita, .) +
  layer(panel.loess(..., lwd = 2))


# Scatterplot showing curvature in relationship

trellis.focus()
panel.identify(labels=rownames(un))
#> integer(0)
trellis.unfocus()
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-12-1.png" width="672" />

```r

un %>% 
  xyplot(log(infantMortality) ~ GDPperCapita | region, .) +
  layer(panel.loess(..., lwd = 2))
```

<img src="0403_transformations_files/figure-html/unnamed-chunk-12-2.png" width="672" />

```r

un %>% subset(country %in% c('United.States','Canada'))
#>                region  tfr contraception educationMale educationFemale lifeMale
#> Canada        America 1.61            66          17.2            17.8     76.1
#> United.States America 1.96            71          15.4            16.2     73.4
#>               lifeFemale infantMortality GDPperCapita economicActivityMale
#> Canada              81.8               6        18943                 72.4
#> United.States       80.1               7        26037                 74.9
#>               economicActivityFemale illiteracyMale illiteracyFemale
#> Canada                          57.6             NA               NA
#> United.States                   59.3           2.24             2.23
#>                     country
#> Canada               Canada
#> United.States United.States
```

between wage and education, and heteroskedasticity in wage as a function of education.


```r


#library(p3d)

#slid %>% 
#  xyplot(sqrt(wage) ~ education, .) + 
#  layer(panel.loess(...))

#Init3d()
#Plot3d(log(infantMortality) ~ GDPperCapita + lifeFemale | region, un)
#Id3d()
#Id3d('United.States')
#Id3d('Canada')
#rownames(un)
#names(un)
```


## Box Cox Transformation


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/vGOpEpjz2Ks" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

This video was made by [math et al](https://www.youtube.com/channel/UCYNVcihAKkRW-bhzIrguvVw). I like their channel and found this video to be a good one.



### Additional Resources

* Salvatore S. Mangiafico's Summary and Analysis of Extension Program Evaluation in R, [rcompanion.org/handbook/](http://rcompanion.org/handbook/). [Pdf version]( http://rcompanion.org/documents/RHandbookProgramEvaluation.pdf)

* http://www.unige.ch/ses/sococ/cl//stat/eda/ladder.html
* https://www.statisticshowto.com/tukey-ladder-of-powers/
* http://blackwell.math.yorku.ca/math4939/lectures/transforming_data_tukeys_ladder_of_powers.html
* https://thomaselove.github.io/431-notes/re-expression-tukeys-ladder-box-cox-plot.html



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
