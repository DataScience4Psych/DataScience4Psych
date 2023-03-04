# (PART) Module 01 {-}




# Welcome to Data Science

This module is designed to introduce you to data science. Please watch the videos and work your way through the notes. **The videos start on the next page.**  You can find the module playlist [here][pl_01]. Most of the slides used to make the videos in this module can be found in the [slides repo][course_slides].


## Module Materials
* Videos
  * Located in the subchapters of this module
* Slidedecks
  * [Welcome Slides][d01_welcome]
  * [Meet the toolkit][d02_toolkit]
* Suggested Readings
    * All subchapters of this module, including
        * [R basics and workflow](#r_basics)
    * R4DS
        * [Book Introduction](https://r4ds.had.co.nz/introduction.html)
        * [Data exploration Introduction](https://r4ds.had.co.nz/explore-intro.html)
    * [Happy Git with R](https://happygitwithr.com/)
        * If Happy Git is too much, start [here](#shorthappygit)
        * If Short Happy Git is too much, start with [Oh My Git](https://ohmygit.org/)
* Activities
  * [UN Voting][ae01a_unvotes]
  * [Covid Data][ae01b_covid]
  * [Bechdal Test][ae02_bechdel]
  * [Oh My Git](https://ohmygit.org/)
* Lab
  * [Hello R](#lab01)



### Estimated Video Length

<!--https://www.youtube.com/playlist?list=PLKrrdtYgOUYao_7t5ycK4KDXNKaY-ECup & https://ytplaylist-len.herokuapp.com/ -->

No of videos : 8

Average length of video: 12 minutes, 6 seconds

Total length of playlist: 1 hour, 36 minutes, 48 seconds

# What is Data Science?


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/BpKXkkU-NiY" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here][d01_welcome] if they do not appear below.


<iframe src="https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html" width="672" height="400px" data-external="1"></iframe>

## See for yourselves!
I've embedded a few examples below.

### Shiny App

<iframe src="https://minecr.shinyapps.io/unvotes/?showcase=0" width="672" height="400px" data-external="1"></iframe>


### Hans Rosling

The video below is the shorter version. Hans Rosling's 200 Countries, 200 Years, 4 Minutes - The Joy of Stats


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/jbkSRLYSojo" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can find a longer talk-length version below.


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/hVimVzgtD6w" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

### Social Media

Social media contains a ton of great (and terrible) examples of data science in action. These examples range from entire subreddits, such as
[/r/DataisBeautiful](https://www.reddit.com/r/dataisbeautiful/) ([be sure to check out the highest voted posts](https://www.reddit.com/r/dataisbeautiful/top/?sort=top&t=all)) to celebrity tweets about data scientists.


```{=html}
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">YASSSSSSSSSS MY LOVE STEVE IS BACK!!! <a href="https://twitter.com/hashtag/KornackiThirstcontinues?src=hash&amp;ref_src=twsrc%5Etfw">#KornackiThirstcontinues</a> <a href="https://t.co/ynK4D87Bhr">pic.twitter.com/ynK4D87Bhr</a></p>&mdash; Leslie Jones 🦋 (@Lesdoggg) <a href="https://twitter.com/Lesdoggg/status/1346584128368508930?ref_src=twsrc%5Etfw">January 5, 2021</a></blockquote>

```

```{=html}
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">Good reasons to not be a Data Scientist:<br><br>- It is a lot of work<br>- Literally nobody will know what you&#39;re talking about<br>- In the end, your computer will be your only real friend</p>&mdash; Kareem Carr | Data Scientist (@kareem_carr) <a href="https://twitter.com/kareem_carr/status/1352655262054834182?ref_src=twsrc%5Etfw">January 22, 2021</a></blockquote>

```

### Read for yourselves!
<!-- source: https://raw.githubusercontent.com/academic/awesome-datascience/live/README.md -->

| Link | Preview |
| --- | --- |
| [What is Data Science @ O'reilly](https://www.oreilly.com/ideas/what-is-data-science) | _Data scientists combine entrepreneurship with patience, the willingness to build data products incrementally, the ability to explore, and the ability to iterate over a solution. They are inherently interdiscplinary. They can tackle all aspects of a problem, from initial data collection and data conditioning to drawing conclusions. They can think outside the box to come up with new ways to view the problem, or to work with very broadly defined problems: "here's a lot of data, what can you make from it?"_ |
| [What is Data Science @ Quora](https://www.quora.com/Data-Science/What-is-data-science) | Data Science is a combination of a number of aspects of Data such as Technology, Algorithm development, and data interference to study the data, analyze it, and find innovative solutions to difficult problems. Basically Data Science is all about Analyzing data and driving for business growth by finding creative ways. |
| [The sexiest job of 21st century](https://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century) | _Data scientists today are akin to Wall Street "quants" of the 1980s and 1990s. In those days people with backgrounds in physics and math streamed to investment banks and hedge funds, where they could devise entirely new algorithms and data strategies. Then a variety of universities developed master's programs in financial engineering, which churned out a second generation of talent that was more accessible to mainstream firms. The pattern was repeated later in the 1990s with search engineers, whose rarefied skills soon came to be taught in computer science programs._ |
| [Wikipedia](https://en.wikipedia.org/wiki/Data_science) | _Data science is an inter-disciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from many structural and unstructured data. Data science is related to data mining, machine learning and big data._ |
| [How to Become a Data Scientist](https://www.mastersindatascience.org/careers/data-scientist/) | _Data scientists are big data wranglers, gathering and analyzing large sets of structured and unstructured data. A data scientist's role combines computer science, statistics, and mathematics. They analyze, process, and model data then interpret the results to create actionable plans for companies and other organizations._ |
| [a very short history of #datascience](http://www.forbes.com/sites/gilpress/2013/05/28/a-very-short-history-of-data-science/) | _The story of how data scientists became sexy is mostly the story of the coupling of the mature discipline of statistics with a very young one--computer science.  The term "Data Science" has emerged only recently to specifically designate a new profession that is expected to make sense of the vast stores of big data. But making sense of data has a long history and has been discussed by scientists, statisticians, librarians, computer scientists and others for years. The following timeline traces the evolution of the term "Data Science" and its use, attempts to define it, and related terms._ |


## Course structure and some other useful things


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/3mz3HNyew-s" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here](https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html#28) if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html#28" width="672" height="400px" data-external="1"></iframe>


## In-Class Activity

You can do either activity. The choice is yours.

### UN Votes
<iframe src="https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html#25" width="672" height="400px" data-external="1"></iframe>

You can find the materials for the UN activity [here][ae01a_unvotes]. The compiled version should look something like the following...

<iframe src="https://datascience4psych.github.io/ae01a_unvotes/unvotes.html" width="672" height="400px" data-external="1"></iframe>


### Covid Data

<iframe src="https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html#26" width="672" height="400px" data-external="1"></iframe>


You can find the materials for the Covid version of this activity [here][ae01b_covid]. The compiled version should look something like the following...

<iframe src="https://datascience4psych.github.io/ae01b_covid/covid.html" width="672" height="400px" data-external="1"></iframe>



# Meet our toolbox!


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/SJaQtRLFb-Y" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```
You can follow along with the slides [here][d02_toolkit] if they do not appear below. I recommend installing [R, Rstudio](#install), [git, and github](#installgit) before starting [activity 02](#bechdal)

<iframe src="https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html" width="672" height="400px" data-external="1"></iframe>

## R and RStudio

### Install R and RStudio {#install}

```r
"https://www.youtube.com/watch?v=kVIZGCT5p9U" %>%
embed_url() %>%
  use_align("center")
```

```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/kVIZGCT5p9U" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

* Install [R, a free software environment for statistical computing and graphics](https://www.r-project.org) from [CRAN][cran], the Comprehensive R Archive Network. I __highly recommend__ you install a precompiled binary distribution for your operating system -- use the links up at the top of the CRAN page linked above!

* Install RStudio's IDE (stands for _integrated development environment_), a powerful user interface for R. Get the Open Source Edition of RStudio Desktop.

  - You can run either the [Preview version](https://www.rstudio.com/products/rstudio/download/preview/) or the official releases available [here](https://www.rstudio.com/products/rstudio/#Desktop).
  - RStudio comes with a __text editor__, so there is no immediate need to install a separate stand-alone editor.
  - RStudio can __interface with Git(Hub)__. However, you must do all the Git(Hub) set up [described elsewhere](https://happygitwithr.com) before you can take advantage of this.
    
If you have a pre-existing installation of R and/or RStudio, I __highly recommend__ that you reinstall both and get as current as possible. It can be considerably harder to run old software than new.

* If you upgrade R, you will need to update any packages you have installed. The command below should get you started, though you may need to specify more arguments if, e.g., you have been using a non-default library for your packages.

``` r
update.packages(ask = FALSE, checkBuilt = TRUE)
```

__Note:__ this  code will only look for updates on [CRAN][cran]. So if you use a package that lives *only* on GitHub or if you want a development version from GitHub, you will need to  update manually, e.g. via `devtools::install_github()`.


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


# Bechdel Activity {#bechdal}

<iframe src="https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html#24" width="672" height="400px" data-external="1"></iframe>


You can find the materials for the Bechdel activity [here][ae02_bechdel]. The compiled version should look something like the following...


<iframe src="https://datascience4psych.github.io/ae-02-bechdel-rmarkdown/bechdel.html" width="672" height="400px" data-external="1"></iframe>



# Thoughtful Workflow

At this point, I recommend you pause and think about your workflow. I give you permission to spend some time and energy sorting this out! It can be as or more important than learning a new R function or package. The experts don't talk about this much, because they've already got a workflow; it's something they do almost without thinking.

Working through subsequent material in R Markdown documents, possibly using Git and GitHub to track and share your progress, is a great idea and will leave you more prepared for your future data analysis projects. Typing individual lines of R code is but a small part of data analysis and it pays off to think holistically about your workflow. 

If you want a lot more detail on workflows, you can wander over to the optional bit on [r basics and workflow](#r_basics).

## R Markdown {#rmarkdown}



If you'd rather just get on with it, here's the abridged version.

```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/fIhIqTy8PVw" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```
But, if you are in the mood to be entertained, start the video from the beginning. 


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/r5dlYNLIG4E" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


You can follow along with the slides [here][d02_toolkit] if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html#26" width="672" height="400px" data-external="1"></iframe>


<!--Original content: https://stat545.com/block007_first-use-rmarkdown.html-->

R Markdown is an accessible way to create computational documents that combine prose and tables and figures produced by R code.

An introductory R Markdown workflow, including how it intersects with Git, GitHub, and RStudio, is now maintained within the Happy Git site:

[Test drive R Markdown](https://happygitwithr.com/rmd-test-drive.html)




## Git and Github {#installgit}

![XKCD on Git](https://imgs.xkcd.com/comics/git.png)

<!-- source https://github.com/uo-ec607/lectures/blob/master/02-git/02-Git.Rmd -->

First, it's important to realize that Git and GitHub are distinct things. GitHub is an online hosting platform that provides an array of services built on top of the Git system. (Similar platforms include Bitbucket and GitLab.) Just like we don't *need* Rstudio to run R code, we don't *need* GitHub to use Git... But, it will make our lives so much easier. 

I recommend checking out Jenny Bryan's instructions around installation, setup, and early Git usage with her book [Happy Git with R](https://happygitwithr.com). I have a recommended deep dive in a later chapter](#shorthappygit).  


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/RIOp8biwBZ4" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here][d02_toolkit] if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html#30" width="672" height="400px" data-external="1"></iframe>



### What is Github?


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/w3jLJU7DT5E" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


### Git

Git is a **distributed Version Control System (VCS)**.  It is a useful tool for easily tracking changes to your code, collaborating, and sharing.

> (Wait, what?) 
> Okay, try this: Imagine if Dropbox and the "Track changes" feature in MS Word had a baby. Git would be that baby. 
> In fact, it's even better than that because Git is optimized for the things that social scientists and data scientists spend a lot of time working on (e.g. code).


The learning curve is worth it -- I promise you!

With Git, you can track the changes you make to your project so you always have a record of what you've worked on and can easily revert back to an older version if need be. It also makes working with others easier -— groups of people can work together on the same project and merge their changes into one final source!

GitHub is a way to use the same power of Git all online with an easy-to-use interface. It's used across the software world and beyond to collaborate and maintain the history of projects. 

> There's a high probability that your favorite app, program or package is built using Git-based tools. (RStudio is a case in point.)

Scientists and academic researchers are starting to use it as well. Benefits of version control and collaboration tools aside, Git(Hub) helps to operationalize the ideals of open science and reproducibility. Journals have increasingly strict requirements regarding reproducibility and data access. GH makes this easy (DOI integration, off-the-shelf licenses, etc.). I run my [entire lab on GH](https://github.com/R-Computing-Lab); this entire course is running on github; these lecture notes are hosted on github...





## Getting Help with R

You can follow along with the slides [here][d02_toolkit] if they do not appear below. Check out this helpful post on [asking good R questions...](https://www.r-project.org/posting-guide.html)


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/O2wfi7Z0Py4" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```



<iframe src="https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html#41" width="672" height="400px" data-external="1"></iframe>




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
