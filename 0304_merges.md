# Working with multiple data frames




```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/fgA7Ou2e9aA" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here][d10_dfs] if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d10_dfs/d10_dfs.html" width="672" height="400px" data-external="1"></iframe>

## Case Studies in Joining


```{=html}
<div class="vembedr" align="center">
<div>
<iframe src="https://www.youtube.com/embed/VHOwnMW8msg" width="533" height="300" frameborder="0" allowfullscreen="" data-external="1"></iframe>
</div>
</div>
```

You can follow along with the slides [here][d10_dfs] if they do not appear below.

<iframe src="https://datascience4psych.github.io/slides/d10_dfs/d10_dfs.html#26" width="672" height="400px" data-external="1"></iframe>

# ODD: Merges and Collaboration {#merges}



This optional deep dive is about merge conflicts. You are welcome to try it with your classmates.

## Learning goal

-   Collaborating on GitHub and resolving merge conflicts

## Merges and merge conflicts

We're going to make things a little more interesting and let all of you make changes and push those changes to your team repository. Sometimes things will go swimmingly, and sometimes you'll run into merge conflicts. So our first task today is to walk you through a merge conflict!

-   Pushing to a repo replaces the code on GitHub with the code you have on your computer.
-   If a collaborator has made a change to your repo on GitHub that you haven't incorporated into your local work, GitHub will stop you from pushing to the repo because this could overwrite your collaborator's work!
-   So you need to explicitly "merge" your collaborator's work before you can push.
-   If your and your collaborator's changes are in different files or in different parts of the same file, git merges the work for you automatically when you \*pull\*.
-   If you both changed the same part of a file, git will produce a \*\*merge conflict\*\* because it doesn't know how which change you want to keep and which change you want to overwrite.

Git will put conflict markers in your code that look like:

    <<<<<<< HEAD 

    See also: [dplyr documentation](https://dplyr.tidyverse.org/)   

    ======= 

    See also [ggplot2 documentation](https://ggplot2.tidyverse.org/)  

    >>>>>>> some1alpha2numeric3string4

The `===`s separate *your* changes (top) from *their* changes (bottom).

Note that on top you see the word `HEAD`, which indicates that these are your changes.

And at the bottom you see `some1alpha2numeric3string4` (well, it probably looks more like `28e7b2ceb39972085a0860892062810fb812a08f`).

This is the **hash** (a unique identifier) of the commit your collaborator made with the conflicting change.

Your job is to *reconcile* the changes: edit the file so that it incorporates the best of both versions and delete the `<<<`, `===`, and `>>>` lines. Then you can stage and commit the result.

## Merge conflict activity

### Setup

-   Clone the repo and open the .Rmd file.
-   Assign the numbers 1, 2, 3, and 4 to each of the team members. If your team has fewer than 4 people, some people will need to have multiple numbers. If your team has more than 4 people, some people will need to share some numbers.

### Let's cause a merge conflict!

Our goal is to see two different types of merges: first we'll see a type of merge that git can't figure out on its own how to do on its own (a **merge conflict**) and requires human intervention, then another type of where that git can figure out how to do without human intervention.

Doing this will require some tight choreography, so pay attention!

Take turns in completing the exercise, only one member at a time. **Others should just watch, not doing anything on their own projects (this includes not even pulling changes!)** until they are instructed to. If you feel like you won't be able to resist the urge to touch your computer when it's not your turn, we recommend putting your hands in your pockets or sitting on them!

**Before starting**: everyone should have the repo cloned and know which role number(s) they are.

**Role 1:**

-   Change the team name to your actual team name.
-   Knit, commit, push.

🛑 Make sure the previous role has finished before moving on to the next step.

**Role 2:**

-   Change the team name to some other word.
-   Knit, commit, push. You should get an error.
-   Pull. Take a look at the document with the merge conflict.
-   Clear the merge conflict by editing the document to choose the correct/preferred change.
-   Knit.
-   **Click the Stage checkbox** for all files in your Git tab. Make sure they all have check marks, not filled-in boxes.
-   Commit and push.

🛑 Make sure the previous role has finished before moving on to the next step.

**Role 3:**

-   Change the a label of the first code chunk
-   Knit, commit, push. You should get an error.
-   Pull. No merge conflicts should occur, but you should see a message about merging.
-   Now push.

🛑 Make sure the previous role has finished before moving on to the next step.

**Role 4:**

-   Change the label of the first code chunk to something other than previous role did.
-   Knit, commit, push. You should get an error.
-   Pull. Take a look at the document with the merge conflict. Clear the merge conflict by choosing the correct/preferred change. Commit, and push.

🛑 Make sure the previous role has finished before moving on to the next step.

**Everyone:** Pull, and observe the changes in your document.

## Tips for collaborating via GitHub

-   Always pull first before you start working.
-   Resolve a merge conflict (commit and push) *before* continuing your work. Never do new work while resolving a merge conflict.
-   Knit, commit, and push often to minimize merge conflicts and/or to make merge conflicts easier to resolve.
-   If you find yourself in a situation that is difficult to resolve, ask questions as soon as possible. Don't let it linger and get bigger.



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
