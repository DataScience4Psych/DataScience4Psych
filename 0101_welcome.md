# (PART) Module 01 {-}



# Welcome to Data Science

This module is designed to introduce you to data science. Please watch the videos and work your way through the notes. **The videos start on the next page.**  You can find the module playlist [here][pl_01]. Most of the slides used to make the videos in this module can be found in the [slides repo][course_slides]. You can always open the slides directly from the links in the notes.

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
<iframe src="https://www.youtube.com/embed/7uVbGcBpXU0" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```


You can follow along with the slides [here][d01_welcome] if they are too small or do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html" width="672" height="400px" data-external="1"></iframe>

## See for yourselves

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
<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">Good reasons to not be a Data Scientist:<br><br>- It is a lot of work<br>- Literally nobody will know what you&#39;re talking about<br>- In the end, your computer will be your only real friend</p>&mdash; Dr Kareem Carr (@kareem_carr) <a href="https://twitter.com/kareem_carr/status/1352655262054834182?ref_src=twsrc%5Etfw">January 22, 2021</a></blockquote>

```


### Read for yourselves
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


You can follow along with the slides [here](https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html#28) if you would like to open them full-screen.

<iframe src="https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html#28" width="672" height="400px" data-external="1"></iframe>
