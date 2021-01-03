# (PART) All the automation things {-} 

# Overview {-#automation-overview}



<!--Original content: https://stat545.com/automation00_index.html-->
<!--TODO: All this section of website is specific to make - want to skip in favor of more WTF style workflows?-->

Although we spend a lot of time working with data interactively, this sort of hands-on babysitting is not always appropriate. We have a philosophy of "source is real" in this class and that philosophy can be implemented on a grander scale. Just as we save R code in a script so we can replay analytical steps, we can also record how a series of scripts and commands work together to produce a set of analytical results. This is what we mean by automating data analysis or building an analytical pipeline.

* Chapter \@ref(automation-slides) - Why and how we automate data analyses + examples
* Chapter \@ref(make-windows) - `make`: special considerations for Windows
  + *2015-11-17 NOTE: since we have already set up a build environment for R packages, it is my hope that everyone has `make`. These instructions were from 2014, when we did everything in a different order. Cross your fingers and ignore!*
  + (If you are running macOS or Linux, `make` should already be installed.)
* Chapter \@ref(make-test-drive) - Test drive `make` and RStudio
  + Walk before you run! Prove that `make` is actually installed and that it can be found and executed from the [shell][hg-shell] and from RStudio. It is also important to tell RStudio to NOT substitute spaces for tabs when editing a `Makefile` (applies to any text editor).
* Chapter \@ref(automating-pipeline) - Hands-on activity
  + This fully developed example shows you:
    * How to run an R script non-interactively
    * How to use `make`...
      - To record which files are inputs vs intermediates vs outputs
      - To capture how scripts and commands convert inputs to outputs
      - To re-run parts of an analysis that are out-of-date
    * The intersection of R and `make`, i.e. how to...
      - Run snippets of R code
      - Run an entire R script
      - Render an R Markdown document (or R script)
    * The interface between RStudio and `make`
    * How to use `make` from the [shell][hg-shell]
    * How Git facilitates the process of building a pipeline
  + *2015-11-19 Andrew MacDonald translated the above into a pipeline for the [`remake` package](https://github.com/richfitz/remake) from Rich Fitzjohn: see [this gist](https://gist.github.com/aammd/72a5b98356893c001001).*
* Chapter \@ref(example-pipelines) - Three more toy pipelines, using the Lord of the Rings data

## Resources {-}

<!--TODO: Link for Karl Broman's "Tools for Reproducible Research" course goes to a list of his courses instead, need to track down actual course-->

* [xkcd comic on automation](https://xkcd.com/1319/). 'Automating' comes from the roots 'auto-' meaning 'self-', and 'mating', meaning 'screwing'.
* Karl Broman covers [GNU Make](https://www.gnu.org/software/make/) in his course [Tools for Reproducible Research](https://kbroman.org/Tools4RR/pages/schedule.html).
* Karl Broman also wrote [minimal make: a minimal tutorial on make](https://kbroman.org/minimal_make/), aimed at stats / data science types.
* [Using Make for reproducible scientific analyses](https://web.archive.org/web/20160306042959/http://www.bendmorris.com/2013/09/using-make-for-reproducible-scientific.html), blog post by Ben Morris.
* Software Carpentry's [Slides on `Make`](https://web.archive.org/web/20150110211213/http://software-carpentry.org/v4/make/index.html).
* Zachary M. Jones wrote [GNU Make for Reproducible Data Analysis](http://zmjones.com/make/).
* [Keeping tabs on your data analysis workflow](https://adamlaiacano.tumblr.com/post/45356689519/keeping-tabs-on-your-data-analysis-workflow), blog post by Adam Laiacano.
* Mike Bostock, of D3.js and New York Times fame, explains [Why Use Make](https://bost.ocks.org/mike/make/): "it's about the benefits of capturing workflows via a file-based dependency-tracking build system".
* [Make for Data Scientists](https://paulbutler.org/2012/make-for-data-scientists/), blog post by Paul Butler, who also made a [beautiful map of Facebook connections](https://www.facebook.com/notes/facebook-engineering/visualizing-friendships/469716398919) using R.
* Other, more modern data-oriented alternatives to `make`:
  + [Drake](https://github.com/Factual/drake), a kind of "make for data"
  + [Nextflow](https://www.nextflow.io) for "data-driven computational pipelines"
  + [`remake`](https://github.com/richfitz/remake), "Make-like declarative workflows in R"
* [Managing Projects with GNU Make, 3rd Edition](http://shop.oreilly.com/product/9780596006105.do) by Robert Mecklenburg [-@mecklenburg2009] is a fantastic book but, sadly, is very focused on compiling software.
* [`littler`](http://dirk.eddelbuettel.com/code/littler.html) is an R package maintained by Dirk Eddelbuettel that "provides the `r` program, a simplified command-line interface for GNU R."


# Why and how we automate data analyses + examples {#automation-slides}

<!--Original content: https://stat545.com/automation01_slides/index.html-->
<!--TODO: Link currently leads to https://STAT545-UBC.github.io/STAT545-UBC.github.io/, wasn't able to get slides in supporting-docs/automation01_slides to render-->

See ["Automating data analysis pipelines" slides](https://github.com/STAT545-UBC/STAT545-UBC-original-website/blob/master/automation01_slides/slides.md) by Shaun Jackman and Jenny Bryan.

# `make`: special considerations for Windows {#make-windows}

<!--Original content: https://stat545.com/automation02_windows.html-->
<!--Original authors: Shaun Jackman, Dean Attali, Jenny Bryan-->

*2015-11-17 NOTE: This year we made R packages before we used `make` The hope is, therefore, that the `make` that ships with Rtools is all we need. So hopefully we can ignore this?*

## Install `make` on Microsoft Windows

We are still working out the best way to install `make` on Windows. Our current best recommendation is to install *msysGit*, which includes `make` as well as `git` and `bash`.

Download and [install msysGit](https://github.com/msysgit/msysgit/releases/download/Git-1.9.4-preview20140929/msysGit-netinstall-1.9.4-preview20140929.exe). The two software packages [msysGit](https://github.com/msysgit/msysgit) and [Git for Windows](http://msysgit.github.io/) are related. Both install `git` and `bash`, but only *msysGit* installs `make`. The programs installed by *msysGit* are found by default in `C:\msysGit\bin`. Here is the [complete list](https://github.com/msysgit/msysgit/tree/master/bin) of programs included with *msysGit*. For this activity, RStudio needs to be able to find in your `PATH` environment variable the program `make`, the [shell][hg-shell] `bash`, other utilities like `rm` and `cp`, and `Rscript`.

Here is another alternative for installing `make` alone:

* Go to the [Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) web site.
* Download the [Setup program](http://gnuwin32.sourceforge.net/downlinks/make.php).
* Install the file you just downloaded and copy to your clipboard the directory in which it is being installed.
  - FYI: The default directory is `C:\Program Files (x86)\GnuWin32\`
* You now have `make` installed, but you need to tell Windows where to find the program. This is called [updating your `PATH`](https://www.google.ca/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=windows%20update%20path%20variable). You will want to update the `PATH` to include the `bin` directory of the newly installed program.

## Update your `PATH`

If you installed Make for Windows (as opposed to the `make` that comes with Git for Windows), you still need to update your `PATH`.

These are the steps on Windows 7 (we don't have such a write-up yet for Windows 8 -- feel free to send one!):

* Click on the Windows logo.
* Right click on *Computer*.
* Select *Properties*.
* Select *Advanced System Settings*.
* Select *Environment variables*.
* Select the line that has the `PATH` variable. You may have to scroll down to find it.
* Select *Edit*.
* Go to the end of the line and add a semicolon `;`, followed by the path where the program was installed, followed by `\bin`.
  - Typical example of what one might add: `;C:\Program Files (x86)\GnuWin32\bin`
* Click Okay and close all the windows that you opened.
* Quit RStudio and open it again.
* You should now be able to use `make` from RStudio and the command line.

## Issues we are still clarifying

See [issue 58](https://github.com/STAT545-UBC/Discussion/issues/58) for what seems to be the most comprehensive statement of the Windows situation.

What are the tricky bits?

* Getting the same `Makefile` to "work" via RStudio's Build buttons/menus and in the [shell][hg-shell]. And, for that matter, which [shell][hg-shell]? Git Bash or ???
* Ensuring `make`, `Rscript`, `pandoc`, `rm`, etc. can be found = updating `PATH`.
* Getting `make` to use the correct [shell][hg-shell].
  - See [issue 54](https://github.com/STAT545-UBC/Discussion/issues/54) on the Discussion repo.


# Automation: test drive `make` {#make-test-drive}

<!--Original content: https://stat545.com/automation03_make-test-drive.html-->
<!--Original authors: Shaun Jackman, Jenny Bryan-->

Before we use `make` for real work, we want to prove beyond a shadow of a doubt that it's installed and findable from RStudio and/or the [shell][hg-shell].

## Create a temporary RStudio project

You can delete this project after this test drive, so don't sweat too much about what you name it or where you put it.

* Create an RStudio project: *File > New Project*
* Create a new text file: *File > New File > Text File*
* We are about to write our first `Makefile`!
  
But first ...

## Disable "insert spaces for tab"

Tabs are very meaningful in `Makefiles`, so it's important to make sure your text editor is not "helpfully" but silently converting tabs to spaces.

Here's how to disable this in RStudio.

* Global setting: *Tools > Global Options... > Code > Editing*. Make sure "Insert spaces for tab" is __unchecked__.
* Project-specific setting: *Tools > Project Options... > Code Editing*. Make sure "Insert spaces for tab" is __unchecked__.
  
RStudio can reveal information about the whitespace in a file: *RStudio > Preferences... > Code > Display >* "Show whitespace characters". When in doubt, make darn sure your `Makefile` is indented with tabs and not spaces!
  
## Write a toy `Makefile`

Type or paste this into your new text file. Make sure the indentation before `@echo` is always a tab! Save as `Makefile`:
  
```makefile
all:
	@echo Build all

clean:
	@echo Clean all
```

## Configure this RStudio project to use `make`

Select *Build > Configure Build Tools... > Build Tools > Project build tools > Makefile*.

This will make a new tab and buttons and menus available in RStudio, usually in the upper right-hand pane, similar to the Git stuff.

## Run `make` via RStudio

Select *Build > Build All* (the hammer icon).

The result and any error messages should appear under the *Build* tab.

Hopefully you will see this:

```sh
Build all
```

If you see something like this:

```sh
Makefile:2: *** missing separator.  Stop.
```
you probably have spaces instead of tabs as indentation. Fix that and try again.

RStudio offers these buttons or menu items to run things from your `Makefile`:

* *Build All* - runs `make all`, as we just saw
* *Clean All* - runs `make clean`
* *Clean and Rebuild* - runs `make clean all`

For these menu items to work, your `Makefile` needs to have targets named `all` and `clean`. These non-file targets are called phony targets.

You should be able to select *Build > More > Clean All* and get this:

```sh
Clean all
```

You should be able to select *Build > More > Clean and Rebuild* and get this:

```sh
Clean all
Build all
```

This proves that `make` is installed and working from RStudio.

## Run `make` from the shell

RStudio only provides access to a very limited bit of `make` -- it's even more limited than the RStudio Git client. In the long run, it's important to be able to run `make` from the [shell][hg-shell].

* Select *Tools > Shell*
* Run

	```sh
	make clean
	make all
	make clean all
	```

You should be seeing similar output as you saw in the Build tab of RStudio.

If you are not, are you getting the error message that's characteristic of a "spaces instead of tabs" problem? Or does it look more like `make` or other commands aren't being found? If the latter, go back to the [Windows installation page](#make-windows) or reach out to the course staff.


# Automating data-analysis pipelines {#automating-pipeline}

<!--Original content: https://stat545.com/automation04_make-activity.html-->
<!--Original authors: Shaun Jackman and Jenny Bryan-->

The goal of this activity is to create a pipeline that will...

* Obtain a large file of English words.
* Calculate a histogram of word lengths.
* Determine the most common word length.
* Generate a figure of this histogram.
* Render a R Markdown report in HTML and PDF.

You will automate this pipeline using `make`!

## Dependency graph of the pipeline

<!--TO DO (JB): remake the figure to say words.txt not words.tsv and the new words downloading strategy -->

<div class="figure">
<img src="supporting-docs/automation01_slides/images/activity.png" alt="Dependency graph of the pipeline" width="50%" />
<p class="caption">(\#fig:unnamed-chunk-2)Dependency graph of the pipeline</p>
</div>

## Set up a new RStudio project (and Git repo)

In RStudio: *File > New Project > New Directory > Empty Project.* If you're a Git user, we strongly encourage you to click on "Create a git repository."

This project will be useful as a reference in the future, so give it an informative name and location. If you're a GitHub user, you may want to push it there as well.

Git(Hub) users: from here on out, we assume you will be committing at regular intervals. At key points, we explicitly prompt you to commit.

*Git folks:* commit now.

## Sample project and Git repository

We walked through this activity ourselves and [this Git repo](https://github.com/STAT545-UBC/make-activity) reflects how our project evolved.

The project is set up for use with `make` at [this commit](https://github.com/STAT545-UBC/make-activity/tree/5d282f87ec3fd46d13b500be51a74c9df146d283).

## Create the `Makefile`

In RStudio: *File > New File > Text File.* Save it with the name `Makefile`. Keep adding the rules we write below to this file, saving regularly.

Once you've saved the file with the name `Makefile`, RStudio should indent with tabs instead of spaces. I recommend you display whitespace in order to visually confirm this: *RStudio > Preferences > Code > Display > Display whitespace characters*. A more extreme measure is to set project or global preferences to NOT replace tabs with spaces, but this will wreak havoc elsewhere.

You also want RStudio to recognize the presence of the `Makefile`. Pick one:

* Set Project Build Tools to `Makefile`
* Quit and relaunch

You should see a "Build" tab now in the same pane as "Environment", "History", and, if applicable, "Git".

*Git folks:* commit now.

## Get the dictionary of words

Depending on your OS and mood, you can get the file of English words by copying a local file or downloading from the internet.

### Download the dictionary

Our first `Makefile` rule will download the dictionary `words.txt`. The command of this rule is a one-line R script, so instead of putting the R script in a separate file, we'll include the command directly in the `Makefile`, since it's so short. *Sure, we could download a file without using R at all but humor us: this is a tutorial about `make` and R!*

```makefile
words.txt:
	Rscript -e 'download.file("https://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
```

__Suggested workflow:__

* *Git folks:* commit anything new/modified. Start with a clean working tree.
* Submit the above `download.file()` command in the R Console to make sure it works.
* Inspect the downloaded words file any way you know how; make sure it's not garbage. Size should be about 2.4MB.
* Delete `words.txt`.
* Put the above rule into your `Makefile`. From the [shell][hg-shell], enter `make words.txt` to verify rule works. Reinspect the words file.
* *Git folks:* commit `Makefile` and `words.txt`.
  
See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/c30ecc9c890a2f2261eb94118997f0774012eeb8).

### Copy the dictionary

On Mac or Linux systems, rather than download the dictionary, we can simply copy the file `/usr/share/dict/words` that comes with the operating system. In this alternative rule, we use the [shell][hg-shell] command `cp` to copy the file.

```makefile
words.txt: /usr/share/dict/words
	cp /usr/share/dict/words words.txt
```

This rule copies the input file `/usr/share/dict/words` to create the output file `words.txt`. We then repeat these file names in the command rule, which is redundant and leaves us vulnerable to typos. `make` offers many automatic variables, so the revised rule below uses `$<` and `$@` to represent the input file and output file, respectively.

```makefile
words.txt: /usr/share/dict/words
	cp $< $@
```

__Suggested workflow:__

* *Git folks:* commit anything new/modified. Start with a clean working tree.
* Remove `words.txt` if you succeeded with the download approach.
* Submit the above `cp` command in the [shell][hg-shell] to make sure it works.
* Inspect the copied words file any way you know how; make sure it's not garbage. Size should be about 2.4MB.
* Delete `words.txt`.
* Put the above rule into your `Makefile`. From the [shell][hg-shell], enter `make words.txt` to verify rule works. Reinspect the words file.
* *Git folks:* look at the diff. You should see how your `words.txt` rule has changed and you might also see some differences between the local and remote words files. Interesting! Commit `Makefile` and `words.txt`.

See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/1131791548e0c5bbc5104eebb19710ed435146e3).

## Create rules for all and clean

It would be nice to execute our `make` rules from RStudio. So it's urgent that we create phony targets `all` and `clean`, which are the only targets accessible from RStudio. These targets are phony in the sense that they do not specify an actual file to be made, rather they just make it easy to trigger a certain action. `all` and `clean` are phony targets that appear in most `Makefiles`, which is why RStudio makes it easy to access them from the IDE.

Edit your `Makefile` to look like this (where your `words.txt` rule can be the copy or download version):

```makefile
all: words.txt

clean:
	rm -f words.txt

words.txt: /usr/share/dict/words
	cp /usr/share/dict/words words.txt
```

Since our only output so far is `words.txt`, that's what we associate with the `all` target. Likewise, the only product we can re-make so far is `words.txt`, so it's the only thing we delete via `clean`.

__Suggested workflow:__

* Use `make clean` from the shell and/or *RStudio > Build > More > Clean All* to delete `words.txt`.
  - Does it go away?
  - *Git folks:* does the deletion of this file show up in your Git tab?
* Use `make all` from the shell and/or *RStudio > Build > Build All* to get `words.txt` back.
  - Does it come back?
  - *Git folks:* does the restoration of `words.txt` cause it to drop off your radar as a changed/deleted file? See how this stuff all works together?
* *Git folks:* Commit.

See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/9e1a556adc602ffce91b5c8edccd223237080c54).

## Create a table of word lengths

This rule will read the list of words and generate a table of word length frequency, stored in a tab-separated-values (TSV) file. This R script is a little longer, so we'll put it in its own file, named `histogram.r`. If either the script `histogram.r` or the data file `words.txt` were to change, we'd need to rerun this command to get up-to-date results, so both files are dependencies of this rule. The input-file variable `$<` refers to the *first* dependency, `histogram.r`.

```makefile
histogram.tsv: histogram.r words.txt
	Rscript $<
```

FYI: `Rscript` allows you to execute R scripts from the [shell][hg-shell]. It is a more modern replacement for `R CMD BATCH` (don't worry if you've never heard of that).

Create the R script `histogram.r` that reads the list of words from `words.txt` and writes the table of word length frequency to `histogram.tsv`. It should be a tab-delimited TSV file with a header and two columns, named `Length` and `Freq`. Hint: you can accomplish this task using four functions: `readLines`, `nchar`, `table` and `write.table`. Here's [one solution](https://raw.githubusercontent.com/STAT545-UBC/STAT545-UBC.github.io/master/automation10_holding-area/activity/histogram.r), but try not to peek until you've attempted this task yourself.

__Suggested workflow:__

* Develop your `histogram.r` script interactively. Make sure it works when you step through it line-by-line. Debugging only gets harder once you're running entire scripts at arm's length via `make`!
* Remove `histogram.tsv`. Clean out the workspace and restart R. Run `histogram.r` via `source()` or using RStudio's Source button. Make sure it works!
* Add the `histogram.tsv` rule to your `Makefile`.
* Remove `histogram.tsv` and regenerate it via `make histogram.tsv` from the [shell][hg-shell].
* *Git folks:* Commit.
  
See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/889e01a3d610e900c7e58ebd32a0506c61543fd9).

## Update rules for all and clean

The new output `histogram.tsv` can replace `words.txt` as our most definitive output. So it will go in the `all` rule. Likewise, we should add `histogram.tsv` to the `clean` rule. Edit your `all` and `clean` rules to look like this:

```makefile
all: histogram.tsv

clean:
	rm -f words.txt histogram.tsv
```

__Suggested workflow:__

* Use `make clean` from the shell and/or *RStudio > Build > More > Clean All*.
  - Do `words.txt` and `histogram.tsv` go away?
  - *Git folks:* does the deletion of these files show up in your Git tab?
* Use `make all` from the shell and/or *RStudio > Build > Build All* to get `words.txt` back.
  - Does it come back?
  - *Git folks:* does the restoration of the files cause them to drop off your radar as changed/deleted files?
* *Git folks:* Commit.

See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/4f392d0e20bb7e4bfcdc00a812190e40e27ae3d4).

## Plot a histogram of word lengths, update all and clean

This rule will read the table of word lengths and plot a histogram using `ggplot2::qplot()`. The R snippet is three lines long, but we'll still include the script in the `Makefile` directly, and use semicolons `;` to separate the R commands. The variable `$@` refers to the output file, `histogram.png`.

```makefile
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
```

__Suggested workflow:__

* Test the histogram-drawing code in the R Console to make sure it works.
* Inspect the resulting PNG to make sure it's good.
* Clean up after yourself.
* Add the above rule to your `Makefile`.
* Test that new rule works.
* If you get an unexpected empty plot `Rplots.pdf`, don't worry about it yet.
* Update the `all` and `clean` targets in light of this addition to the pipeline.
* Test the new definitions of `all` and `clean`.
* *Git folks:* commit.

*NOTE: Why are we writing this PNG to file when, by the end of the activity, we are writing an R Markdown report? We could include this figure-making code in an R chunk there. We're doing it this way to demonstrate more about R and `make` workflows. Plus sometimes we do work this way in real life, if a figure has a life outside one specific R Markdown report.*

See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/221c2d66fe9fd7a359835492db6557e258178780).

## Use `make` to deal with an annoyance

The code used above to create `histogram.png` usually leaves an empty `Rplots.pdf` file behind. You can read [this thread on stackoverflow](http://stackoverflow.com/questions/17348359/how-to-stop-r-from-creating-empty-rplots-pdf-file-when-using-ggsave-and-rscript) if you'd like to know more.

We'll just use this as a teachable moment to demonstrate how handy an automated pipeline is for dealing with such annoyances and to show a multi-line `make` rule.

Update the `histogram.png` rule like so:

```makefile
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf
```

__Suggested workflow:__

* Remove `Rplots.pdf` manually
* Add the `rm Rplots.pdf` command to the `histogram.png` rule.
* Test that new rule works.
* Test that behavior of `all` and `clean` still good.
* *Git folks:* commit.

See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/3b75dac0d0cd8dd7e7cd3c2e66799a65d90b9fff).

## Render an HTML report

Finally, we'll use `rmarkdown::render()` to generate an HTML report. If we think narrowly, we might say that the HTML report depends only on its Markdown predecessor, which would lead to a rule like this: 

```makefile
report.html: report.md
	Rscript -e 'rmarkdown::render("$<")'
```

But we really shouldn't hard-wire statements about word length in Markdown; we should use inline R code to compute that from the word length table. Similarly, if the plotted histogram were to change, we'd need to remake the HTML report. Here is a better rule that captures all of these dependencies:

```makefile
report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'
```

Create the R Markdown file `report.rmd` that reads the table of word lengths `histogram.tsv`, reports the most common word length, and displays the pre-made histogram `histogram.png`. Here's [one solution](https://raw.githubusercontent.com/STAT545-UBC/STAT545-UBC.github.io/master/automation10_holding-area/activity/report.rmd), but try not to peek until you've attempted this task yourself.

__Suggested workflow:__

* Develop `report.rmd`, running the R chunks often, from a clean workspace and fresh R session. Debugging only gets harder once you're rendering entire reports at arm's length via `make`!
* Render the report using `rmarkdown::render()` in the Console or RStudio's Preview HTML button.
* Clean up after yourself.
* Add the above rule for `report.html` to your `Makefile`.
* Test that new rule works.
* Update the `all` and `clean` targets in light of this addition to the pipeline.
* Test the new definitions of `all` and `clean`.
* *Git folks:* commit.
  
See the sample project at this point in [this commit](https://github.com/STAT545-UBC/make-activity/tree/91ebcfc7d25743ebd8d6c9684ed7923ad4758585).

<!-- TO DO: this PDF bit awaiting attention from Shaun -->
 
<!--

Render a PDF report
================================================================================

Can you modify the `rmarkdown::render` command to generate a PDF report instead of an HTML report? Hint: look at the optional second argument of `rmarkdown::render`. Alternatively, click the *Knit* dropdown box and select *Knit PDF*, and look at how RStudio modifies the header of your R Markdown script.

--> 

## The final `Makefile`

At this point, your `Makefile` should look something like this:

```makefile
all: report.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html

words.txt: /usr/share/dict/words
	cp /usr/share/dict/words words.txt

histogram.tsv: histogram.r words.txt
	Rscript $<

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'
```

Remember, you can review the entire activity via the commit history of the sample project: <https://github.com/STAT545-UBC/make-activity>.

And that's how a data analytical pipeline gets built using `make`, the shell, R, RStudio, and optionally Git.

## Extending the `Makefile`

Here are [some additions](https://www.gnu.org/software/make/manual/html_node/Special-Targets.html) you might like to include in your `Makefile`:

```sh
.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:
```

The `.PHONY` line is where you declare which targets are *phony*, i.e. are not actual files to be made in the literal sense. It's a good idea to explicitly tell `make` which targets are phony, instead of letting it try to deduce this. `make` can get confused if you create a file that has the same name as a phony target. If for example you create a directory named `clean` to hold your clean data and run `make clean`, then `make` will report `'clean' is up to date`, because a directory with that name already exists.

`.DELETE_ON_ERROR` causes `make` to "delete the target of a rule if it has changed and its recipe exits with a nonzero exit status". In English, this means that -- if a rule starts to run but then exits due to error -- any outputs written in the course of that fiasco will be deleted. This can protect you from having half-baked, erroneous files lying around that will just confuse you later.

`.SECONDARY` tells `make` not to delete intermediate files of a chain of pattern rules. Consider creating a `Makefile` with two pattern rules, `%.md: %.rmd` and `%.html: %.md`, and then running `make report.html`. After `make` has created `report.md` and `report.html`, it will delete the intermediate file `report.md`. Adding `.SECONDARY` to your `Makefile` prevents the intermediate file from being deleted.

# More example pipelines {#example-pipelines}

There are three more toy pipelines, using the Lord of the Rings data, that reinforce:

* [`01_automation-example_just-r`](https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/01_automation-example_just-r) - use of an R script as a pseudo-`Makefile`.
* [`02_automation-example_r-and-make`](https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/02_automation-example_r-and-make) - use of a simple `Makefile`.
* [`03_automation-example_render-without-rstudio`](https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/03_automation-example_render-without-rstudio) - use of `rmarkdown::render()` from a `Makefile`, as the default way of running an R script or an R Markdown document, leading to pretty HTML reports without any mouse clicks.



[cran]: https://cloud.r-project.org
[cran-faq]: https://cran.r-project.org/faqs.html
[cran-R-admin]: http://cran.r-project.org/doc/manuals/R-admin.html
[cran-add-ons]: https://cran.r-project.org/doc/manuals/R-admin.html#Add_002don-packages
[r-proj]: https://www.r-project.org
[stat-545]: https://stat545.com
[software-carpentry]: https://software-carpentry.org
[cran-r-extensions]: https://cran.r-project.org/doc/manuals/r-release/R-exts.html


<!--RStudio Links-->
[rstudio-preview]: https://www.rstudio.com/products/rstudio/download/preview/
[rstudio-official]: https://www.rstudio.com/products/rstudio/#Desktop
[rstudio-workbench]: https://www.rstudio.com/wp-content/uploads/2014/04/rstudio-workbench.png
[rstudio-support]: https://support.rstudio.com/hc/en-us
[rstudio-R-help]: https://support.rstudio.com/hc/en-us/articles/200552336-Getting-Help-with-R
[rstudio-customizing]: https://support.rstudio.com/hc/en-us/articles/200549016-Customizing-RStudio
[rstudio-key-shortcuts]: https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts
[rstudio-command-history]: https://support.rstudio.com/hc/en-us/articles/200526217-Command-History
[rstudio-using-projects]: https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects
[rstudio-code-snippets]: https://support.rstudio.com/hc/en-us/articles/204463668-Code-Snippets
[rstudio-dplyr-cheatsheet-download]: https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf
[rstudio-regex-cheatsheet]: https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf
[rstudio-devtools]: https://www.rstudio.com/products/rpackages/devtools/

<!--HappyGitWithR Links-->
[happy-git]: https://happygitwithr.com
[hg-install-git]: https://happygitwithr.com/install-git.html
[hg-git-client]: https://happygitwithr.com/git-client.html
[hg-github-account]: https://happygitwithr.com/github-acct.html
[hg-install-r-rstudio]: https://happygitwithr.com/install-r-rstudio.html
[hg-connect-intro]: https://happygitwithr.com/connect-intro.html
[hg-browsability]: https://happygitwithr.com/workflows-browsability.html
[hg-shell]: https://happygitwithr.com/shell.html

<!--Package Links-->
[rmarkdown]: https://rmarkdown.rstudio.com
[knitr-faq]: https://yihui.name/knitr/faq/

[tidyverse-main-page]: https://www.tidyverse.org
[tidyverse-web]: https://tidyverse.tidyverse.org
[tidyverse-github]: https://github.com/hadley/tidyverse

[dplyr-web]: https://dplyr.tidyverse.org
[dplyr-cran]: https://CRAN.R-project.org/package=dplyr
[dplyr-github]: https://github.com/hadley/dplyr
[dplyr-vignette-intro]: https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html
[dplyr-vignette-window-fxns]: https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html
[dplyr-vignette-two-table]: https://dplyr.tidyverse.org/articles/two-table.html

[lubridate-web]: https://lubridate.tidyverse.org
[lubridate-cran]: https://CRAN.R-project.org/package=lubridate
[lubridate-github]: https://github.com/tidyverse/lubridate
[lubridate-vignette]: https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html

[tidyr-web]: https://tidyr.tidyverse.org
[tidyr-cran]: https://CRAN.R-project.org/package=tidyr 

[readr-web]: https://readr.tidyverse.org
[readr-vignette-intro]: https://cran.r-project.org/web/packages/readr/vignettes/readr.html

[stringr-web]: https://stringr.tidyverse.org
[stringr-cran]: https://CRAN.R-project.org/package=stringr

[ggplot2-web]: https://ggplot2.tidyverse.org
[ggplot2-tutorial]: https://github.com/jennybc/ggplot2-tutorial
[ggplot2-reference]: https://docs.ggplot2.org/current/
[ggplot2-cran]: https://CRAN.R-project.org/package=ggplot2
[ggplot2-github]: https://github.com/tidyverse/ggplot2
[ggplot2-theme-args]: https://ggplot2.tidyverse.org/reference/ggtheme.html#arguments

[gapminder-web]: https://www.gapminder.org
[gapminder-cran]: https://CRAN.R-project.org/package=gapminder

[assertthat-cran]: https://CRAN.R-project.org/package=assertthat
[assertthat-github]: https://github.com/hadley/assertthat

[ensurer-cran]: https://CRAN.R-project.org/package=ensurer
[ensurer-github]: https://github.com/smbache/ensurer

[assertr-cran]: https://CRAN.R-project.org/package=assertr
[assertr-github]: https://github.com/ropensci/assertr

[assertive-cran]: https://CRAN.R-project.org/package=assertive
[assertive-bitbucket]: https://bitbucket.org/richierocks/assertive/src/master/

[testthat-cran]: https://CRAN.R-project.org/package=testthat
[testthat-github]: https://github.com/r-lib/testthat
[testthat-web]: https://testthat.r-lib.org

[viridis-cran]: https://CRAN.R-project.org/package=viridis
[viridis-github]: https://github.com/sjmgarnier/viridis
[viridis-vignette]: https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

[colorspace-cran]: https://CRAN.R-project.org/package=colorspace
[colorspace-vignette]: https://cran.r-project.org/web/packages/colorspace/vignettes/hcl-colors.pdf

[cowplot-cran]: https://CRAN.R-project.org/package=cowplot
[cowplot-github]: https://github.com/wilkelab/cowplot
[cowplot-vignette]: https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html

[devtools-cran]: https://CRAN.R-project.org/package=devtools
[devtools-github]: https://github.com/r-lib/devtools
[devtools-web]: https://devtools.r-lib.org
[devtools-cheatsheet]: https://www.rstudio.com/wp-content/uploads/2015/03/devtools-cheatsheet.pdf
[devtools-cheatsheet-old]: https://rawgit.com/rstudio/cheatsheets/master/package-development.pdf
[devtools-1-6]: https://blog.rstudio.com/2014/10/02/devtools-1-6/
[devtools-1-8]: https://blog.rstudio.com/2015/05/11/devtools-1-9-0/
[devtools-1-9-1]: https://blog.rstudio.com/2015/09/13/devtools-1-9-1/

[googlesheets-cran]: https://CRAN.R-project.org/package=googlesheets
[googlesheets-github]: https://github.com/jennybc/googlesheets

[tidycensus-cran]: https://CRAN.R-project.org/package=tidycensus
[tidycensus-github]: https://github.com/walkerke/tidycensus
[tidycensus-web]: https://walkerke.github.io/tidycensus/index.html

[fs-web]: https://fs.r-lib.org/index.html
[fs-cran]: https://CRAN.R-project.org/package=fs
[fs-github]: https://github.com/r-lib/fs

[plumber-web]: https://www.rplumber.io
[plumber-docs]: https://www.rplumber.io/docs/
[plumber-github]: https://github.com/trestletech/plumber
[plumber-cran]: https://CRAN.R-project.org/package=plumber

[plyr-web]: http://plyr.had.co.nz

[magrittr-web]: https://magrittr.tidyverse.org
[forcats-web]: https://forcats.tidyverse.org
[glue-web]: https://glue.tidyverse.org
[stringi-cran]: https://CRAN.R-project.org/package=stringi
[rex-github]: https://github.com/kevinushey/rex
[rcolorbrewer-cran]: https://CRAN.R-project.org/package=RColorBrewer
[dichromat-cran]: https://CRAN.R-project.org/package=dichromat

[rdryad-web]: https://docs.ropensci.org/rdryad/
[rdryad-cran]: https://CRAN.R-project.org/package=rdryad
[rdryad-github]: https://github.com/ropensci/rdryad

[roxygen2-cran]: https://CRAN.R-project.org/package=roxygen2
[roxygen2-vignette]: https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html

[shinythemes-web]: https://rstudio.github.io/shinythemes/
[shinythemes-cran]: https://CRAN.R-project.org/package=shinythemes

[shinyjs-web]: https://deanattali.com/shinyjs/
[shinyjs-cran]: https://CRAN.R-project.org/package=shinyjs
[shinyjs-github]: https://github.com/daattali/shinyjs

[leaflet-web]: https://rstudio.github.io/leaflet/
[leaflet-cran]: https://CRAN.R-project.org/package=leaflet
[leaflet-github]: https://github.com/rstudio/leaflet

[ggvis-web]: https://ggvis.rstudio.com
[ggvis-cran]: https://CRAN.R-project.org/package=ggvis
 
[usethis-web]: https://usethis.r-lib.org
[usethis-cran]: https://CRAN.R-project.org/package=usethis
[usethis-github]: https://github.com/r-lib/usethis

[pkgdown-web]: https://pkgdown.r-lib.org
[gh-github]: https://github.com/r-lib/gh

[httr-web]: https://httr.r-lib.org
[httr-cran]: https://CRAN.R-project.org/package=httr
[httr-github]: https://github.com/r-lib/httr

[gistr-web]: https://docs.ropensci.org/gistr
[gistr-cran]: https://CRAN.R-project.org/package=gistr
[gistr-github]: https://github.com/ropensci/gistr

[rvest-web]: https://rvest.tidyverse.org
[rvest-cran]: https://CRAN.R-project.org/package=rvest
[rvest-github]: https://github.com/tidyverse/rvest

[xml2-web]: https://xml2.r-lib.org
[xml2-cran]: https://CRAN.R-project.org/package=xml2
[xml2-github]: https://github.com/r-lib/xml2

[jsonlite-paper]: https://arxiv.org/abs/1403.2805
[jsonlite-cran]: https://CRAN.R-project.org/package=jsonlite
[jsonlite-github]: https://github.com/jeroen/jsonlite

[readxl-web]: https://readxl.tidyverse.org
[readxl-github]: https://github.com/tidyverse/readxl
[readxl-cran]: https://CRAN.R-project.org/package=readxl

[janitor-web]: http://sfirke.github.io/janitor/
[janitor-cran]: https://CRAN.R-project.org/package=janitor
[janitor-github]: https://github.com/sfirke/janitor

[purrr-web]: https://purrr.tidyverse.org
[curl-cran]: https://CRAN.R-project.org/package=curl

<!--Shiny links-->
[shinydashboard-web]: https://rstudio.github.io/shinydashboard/
[shinydashboard-cran]: https://CRAN.R-project.org/package=shinydashboard
[shinydashboard-github]: https://github.com/rstudio/shinydashboard


[shiny-official-web]: https://shiny.rstudio.com
[shiny-official-tutorial]: https://shiny.rstudio.com/tutorial/
[shiny-cheatsheet]: https://shiny.rstudio.com/images/shiny-cheatsheet.pdf
[shiny-articles]: https://shiny.rstudio.com/articles/
[shiny-bookdown]: https://bookdown.org/yihui/rmarkdown/shiny-documents.html
[shiny-google-groups]: https://groups.google.com/forum/#!forum/shiny-discuss
[shiny-stack-overflow]: https://stackoverflow.com/questions/tagged/shiny
[shinyapps-web]: https://www.shinyapps.io
[shiny-server-setup]: https://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/
[shiny-reactivity]: https://shiny.rstudio.com/articles/understanding-reactivity.html
[shiny-debugging]: https://shiny.rstudio.com/articles/debugging.html
[shiny-server]: https://www.rstudio.com/products/shiny/shiny-server/

<!--Publications--> 
[adv-r]: http://adv-r.had.co.nz
[adv-r-fxns]: http://adv-r.had.co.nz/Functions.html
[adv-r-dsl]: http://adv-r.had.co.nz/dsl.html
[adv-r-defensive-programming]: http://adv-r.had.co.nz/Exceptions-Debugging.html#defensive-programming
[adv-r-fxn-args]: http://adv-r.had.co.nz/Functions.html#function-arguments
[adv-r-return-values]: http://adv-r.had.co.nz/Functions.html#return-values
[adv-r-closures]: http://adv-r.had.co.nz/Functional-programming.html#closures

[r4ds]: https://r4ds.had.co.nz
[r4ds-transform]: https://r4ds.had.co.nz/transform.html
[r4ds-strings]: https://r4ds.had.co.nz/strings.html
[r4ds-readr-strings]: https://r4ds.had.co.nz/data-import.html#readr-strings
[r4ds-dates-times]: https://r4ds.had.co.nz/dates-and-times.html
[r4ds-data-import]: http://r4ds.had.co.nz/data-import.html
[r4ds-relational-data]: https://r4ds.had.co.nz/relational-data.html
[r4ds-pepper-shaker]: https://r4ds.had.co.nz/vectors.html#lists-of-condiments

[r-pkgs2]: https://r-pkgs.org/index.html
[r-pkgs2-whole-game]: https://r-pkgs.org/whole-game.html
[r-pkgs2-description]: https://r-pkgs.org/description.html
[r-pkgs2-man]: https://r-pkgs.org/man.htm
[r-pkgs2-tests]: https://r-pkgs.org/tests.html
[r-pkgs2-namespace]: https://r-pkgs.org/namespace.html
[r-pkgs2-vignettes]: https://r-pkgs.org/vignettes.html
[r-pkgs2-release]: https://r-pkgs.org/release.html
[r-pkgs2-r-code]: https://r-pkgs.org/r.html#r

[r-graphics-cookbook]: http://shop.oreilly.com/product/0636920023135.do

[cookbook-for-r]: http://www.cookbook-r.com 
[cookbook-for-r-graphs]: http://www.cookbook-r.com/Graphs/
[cookbook-for-r-multigraphs]: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/

[elegant-graphics-springer]: https://www.springer.com/gp/book/9780387981413

[testthat-article]: https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf
[worry-about-color]: https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=2ahUKEwi0xYqJ8JbjAhWNvp4KHViYDxsQFjABegQIABAC&url=https%3A%2F%2Fwww.researchgate.net%2Fprofile%2FAhmed_Elhattab2%2Fpost%2FPlease_suggest_some_good_3D_plot_tool_Software_for_surface_plot%2Fattachment%2F5c05ba35cfe4a7645506948e%2FAS%253A699894335557644%25401543879221725%2Fdownload%2FWhy%2BShould%2BEngineers%2Band%2BScientists%2BBe%2BWorried%2BAbout%2BColor_.pdf&usg=AOvVaw1qwjjGMd7h_z6TLUjzu7Nb
[escaping-rgbland-pdf]: https://eeecon.uibk.ac.at/~zeileis/papers/Zeileis+Hornik+Murrell-2009.pdf
[escaping-rgbland-doi]: https://doi.org/10.1016/j.csda.2008.11.033


<!--R Documentation-->
[rdocs-extremes]: https://rdrr.io/r/base/Extremes.html
[rdocs-range]: https://rdrr.io/r/base/range.html
[rdocs-quantile]: https://rdrr.io/r/stats/quantile.html
[rdocs-c]: https://rdrr.io/r/base/c.html
[rdocs-list]: https://rdrr.io/r/base/list.html
[rdocs-lm]: https://rdrr.io/r/stats/lm.html
[rdocs-coef]: https://rdrr.io/r/stats/coef.html
[rdocs-devices]: https://rdrr.io/r/grDevices/Devices.html
[rdocs-ggsave]: https://rdrr.io/cran/ggplot2/man/ggsave.html
[rdocs-dev]: https://rdrr.io/r/grDevices/dev.html


<!--Wikipedia Links-->
[wiki-snake-case]: https://en.wikipedia.org/wiki/Snake_case
[wiki-hello-world]: https://en.wikipedia.org/wiki/%22Hello,_world!%22_program
[wiki-janus]: https://en.wikipedia.org/wiki/Janus
[wiki-nesting-dolls]: https://en.wikipedia.org/wiki/Matryoshka_doll
[wiki-pure-fxns]: https://en.wikipedia.org/wiki/Pure_function
[wiki-camel-case]: https://en.wikipedia.org/wiki/Camel_case
[wiki-mojibake]: https://en.wikipedia.org/wiki/Mojibake
[wiki-row-col-major-order]: https://en.wikipedia.org/wiki/Row-_and_column-major_order
[wiki-boxplot]: https://en.wikipedia.org/wiki/Box_plot
[wiki-brewer]: https://en.wikipedia.org/wiki/Cynthia_Brewer
[wiki-vector-graphics]: https://en.wikipedia.org/wiki/Vector_graphics
[wiki-raster-graphics]: https://en.wikipedia.org/wiki/Raster_graphics
[wiki-dry]: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself
[wiki-web-scraping]: https://en.wikipedia.org/wiki/Web_scraping
[wiki-xpath]: https://en.wikipedia.org/wiki/XPath
[wiki-css-selector]: https://en.wikipedia.org/wiki/Cascading_Style_Sheets#Selector


<!--Misc. Links-->
[split-apply-combine]: https://www.jstatsoft.org/article/view/v040i01
[useR-2014-dropbox]: https://www.dropbox.com/sh/i8qnluwmuieicxc/AAAgt9tIKoIm7WZKIyK25lh6a
[gh-pages]: https://pages.github.com
[html-preview]: http://htmlpreview.github.io
[tj-mahr-slides]: https://github.com/tjmahr/MadR_Pipelines
[dataschool-dplyr]: https://www.dataschool.io/dplyr-tutorial-for-faster-data-manipulation-in-r/
[xckd-randall-munroe]: https://fivethirtyeight.com/features/xkcd-randall-munroe-qanda-what-if/
[athena-zeus-forehead]: https://tinyurl.com/athenaforehead
[tidydata-lotr]: https://github.com/jennybc/lotr-tidy#readme
[minimal-make]: https://kbroman.org/minimal_make/
[write-data-tweet]: https://twitter.com/vsbuffalo/statuses/358699162679787521
[belt-and-suspenders]: https://www.wisegeek.com/what-does-it-mean-to-wear-belt-and-suspenders.htm
[research-workflow]: https://www.carlboettiger.info/2012/05/06/research-workflow.html
[yak-shaving]: https://seths.blog/2005/03/dont_shave_that/
[yaml-with-csv]: https://blog.datacite.org/using-yaml-frontmatter-with-csv/
[reproducible-examples]: https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example
[blog-strings-as-factors]: https://notstatschat.tumblr.com/post/124987394001/stringsasfactors-sigh
[bio-strings-as-factors]: https://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography
[stackexchange-outage]: https://stackstatus.net/post/147710624694/outage-postmortem-july-20-2016
[email-regex]: https://emailregex.com
[fix-atom-bug]: https://davidvgalbraith.com/how-i-fixed-atom/
[icu-regex]: http://userguide.icu-project.org/strings/regexp
[regex101]: https://regex101.com
[regexr]: https://regexr.com
[utf8-debug]: http://www.i18nqa.com/debug/utf8-debug.html
[unicode-no-excuses]: https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/
[programmers-encoding]: http://kunststube.net/encoding/
[encoding-probs-ruby]: https://www.justinweiss.com/articles/3-steps-to-fix-encoding-problems-in-ruby/
[theyre-to-theyre]: https://www.justinweiss.com/articles/how-to-get-from-theyre-to-theyre/
[lubridate-ex1]: https://www.r-exercises.com/2016/08/15/dates-and-times-simple-and-easy-with-lubridate-part-1/
[lubridate-ex2]: https://www.r-exercises.com/2016/08/29/dates-and-times-simple-and-easy-with-lubridate-exercises-part-2/
[lubridate-ex3]: https://www.r-exercises.com/2016/10/04/dates-and-times-simple-and-easy-with-lubridate-exercises-part-3/
[google-sql-join]: https://www.google.com/search?q=sql+join&tbm=isch
[min-viable-product]: https://blog.fastmonkeys.com/?utm_content=bufferc2d6e&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer
[telescope-rule]: http://c2.com/cgi/wiki?TelescopeRule
[unix-philosophy]: http://www.faqs.org/docs/artu/ch01s06.html
[twitter-wrathematics]: https://twitter.com/wrathematics
[robbins-effective-graphs]: https://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123
[r-graph-catalog-github]: https://github.com/jennybc/r-graph-catalog
[google-pie-charts]: https://www.google.com/search?q=pie+charts+suck
[why-pie-charts-suck]: https://www.richardhollins.com/blog/why-pie-charts-suck/
[worst-figure]: https://robjhyndman.com/hyndsight/worst-figure/
[naomi-robbins]: http://www.nbr-graphs.com
[hadley-github-index]: https://hadley.github.io
[scipy-2015-matplotlib-colors]: https://www.youtube.com/watch?v=xAoljeRJ3lU&feature=youtu.be
[winston-chang-github]: https://github.com/wch
[favorite-rgb-color]: https://manyworldstheory.com/2013/01/15/my-favorite-rgb-color/
[stowers-color-chart]: https://web.archive.org/web/20121022044903/http://research.stowers-institute.org/efg/R/Color/Chart/
[stowers-using-color-in-R]: https://www.uv.es/conesa/CursoR/material/UsingColorInR.pdf
[zombie-project]: https://imgur.com/ewmBeQG
[tweet-project-resurfacing]: https://twitter.com/JohnDCook/status/522377493417033728
[rgraphics-looks-tips]: https://blog.revolutionanalytics.com/2009/01/10-tips-for-making-your-r-graphics-look-their-best.html
[rgraphics-svg-tips]: https://blog.revolutionanalytics.com/2011/07/r-svg-graphics.html
[zev-ross-cheatsheet]: http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/
[parker-writing-r-packages]: https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
[broman-r-packages]: https://kbroman.org/pkg_primer/
[broman-tools4rr]: https://kbroman.org/Tools4RR/
[leeks-r-packages]: https://github.com/jtleek/rpackages
[build-maintain-r-packages]: https://thepoliticalmethodologist.com/2014/08/14/building-and-maintaining-r-packages-with-devtools-and-roxygen2/
[murdoch-package-vignette-slides]: https://web.archive.org/web/20160824010213/http://www.stats.uwo.ca/faculty/murdoch/ism2013/5Vignettes.pdf
[how-r-searches]: http://blog.obeautifulcode.com/R/How-R-Searches-And-Finds-Stuff/
