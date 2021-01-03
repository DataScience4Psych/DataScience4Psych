# Join two tables {#join-cheatsheet}



<!--Original content: https://stat545.com/bit001_dplyr-cheatsheet.html--> 

Join (a.k.a. merge) two tables: dplyr join cheatsheet with comic characters and publishers.




## Why the cheatsheet

Examples for those of us who don't speak SQL so good. There are lots of [Venn diagrams re: SQL joins on the internet][google-sql-join], but I wanted R examples. Those diagrams also utterly fail to show what's really going on vis-a-vis rows AND columns.


Other great places to read about joins:

* The dplyr vignette on [Two-table verbs][dplyr-vignette-two-table].
* The [Relational data chapter][r4ds-relational-data] in [R for Data Science][r4ds] [@wickham2016]. Excellent diagrams.
  
## The data

Working with two small data frames: `superheroes` and `publishers`.


```r
library(tidyverse) ## dplyr provides the join functions

superheroes <- tibble::tribble(
       ~name, ~alignment,  ~gender,          ~publisher,
   "Magneto",      "bad",   "male",            "Marvel",
     "Storm",     "good", "female",            "Marvel",
  "Mystique",      "bad", "female",            "Marvel",
    "Batman",     "good",   "male",                "DC",
     "Joker",      "bad",   "male",                "DC",
  "Catwoman",      "bad", "female",                "DC",
   "Hellboy",     "good",   "male", "Dark Horse Comics"
  )

publishers <- tibble::tribble(
  ~publisher, ~yr_founded,
        "DC",       1934L,
    "Marvel",       1939L,
     "Image",       1992L
  )
```

Sorry, cheat sheet does not illustrate "multiple match" situations terribly well.

Sub-plot: watch the row and variable order of the join results for a healthy reminder of why it's dangerous to rely on any of that in an analysis.



## `inner_join(superheroes, publishers)`

> `inner_join(x, y)`: Return all rows from `x` where there are matching values in `y`, and all columns from `x` and `y`. If there are multiple matches between `x` and `y`, all combination of the matches are returned. This is a mutating join.


```r
(ijsp <- inner_join(superheroes, publishers))
#> Joining, by = "publisher"
#> # A tibble: 6 x 5
#>   name     alignment gender publisher yr_founded
#>   <chr>    <chr>     <chr>  <chr>          <int>
#> 1 Magneto  bad       male   Marvel          1939
#> 2 Storm    good      female Marvel          1939
#> 3 Mystique bad       female Marvel          1939
#> 4 Batman   good      male   DC              1934
#> 5 Joker    bad       male   DC              1934
#> 6 Catwoman bad       female DC              1934
```

We lose Hellboy in the join because, although he appears in `x = superheroes`, his publisher Dark Horse Comics does not appear in `y = publishers`. The join result has all variables from `x = superheroes` plus `yr_founded`, from `y`.



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ejhzovbgbd .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#ejhzovbgbd .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ejhzovbgbd .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#ejhzovbgbd .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#ejhzovbgbd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejhzovbgbd .gt_col_headings {
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

#ejhzovbgbd .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#ejhzovbgbd .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ejhzovbgbd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ejhzovbgbd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ejhzovbgbd .gt_column_spanner {
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

#ejhzovbgbd .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#ejhzovbgbd .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#ejhzovbgbd .gt_from_md > :first-child {
  margin-top: 0;
}

#ejhzovbgbd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ejhzovbgbd .gt_row {
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

#ejhzovbgbd .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#ejhzovbgbd .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejhzovbgbd .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ejhzovbgbd .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejhzovbgbd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ejhzovbgbd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ejhzovbgbd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejhzovbgbd .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#ejhzovbgbd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ejhzovbgbd .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#ejhzovbgbd .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ejhzovbgbd .gt_left {
  text-align: left;
}

#ejhzovbgbd .gt_center {
  text-align: center;
}

#ejhzovbgbd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ejhzovbgbd .gt_font_normal {
  font-weight: normal;
}

#ejhzovbgbd .gt_font_bold {
  font-weight: bold;
}

#ejhzovbgbd .gt_font_italic {
  font-style: italic;
}

#ejhzovbgbd .gt_super {
  font-size: 65%;
}

#ejhzovbgbd .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ejhzovbgbd" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#azirkxyllh .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#azirkxyllh .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#azirkxyllh .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#azirkxyllh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#azirkxyllh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#azirkxyllh .gt_col_headings {
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

#azirkxyllh .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#azirkxyllh .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#azirkxyllh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#azirkxyllh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#azirkxyllh .gt_column_spanner {
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

#azirkxyllh .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#azirkxyllh .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#azirkxyllh .gt_from_md > :first-child {
  margin-top: 0;
}

#azirkxyllh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#azirkxyllh .gt_row {
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

#azirkxyllh .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#azirkxyllh .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#azirkxyllh .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#azirkxyllh .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#azirkxyllh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#azirkxyllh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#azirkxyllh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#azirkxyllh .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#azirkxyllh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#azirkxyllh .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#azirkxyllh .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#azirkxyllh .gt_left {
  text-align: left;
}

#azirkxyllh .gt_center {
  text-align: center;
}

#azirkxyllh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#azirkxyllh .gt_font_normal {
  font-weight: normal;
}

#azirkxyllh .gt_font_bold {
  font-weight: bold;
}

#azirkxyllh .gt_font_italic {
  font-style: italic;
}

#azirkxyllh .gt_super {
  font-size: 65%;
}

#azirkxyllh .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="azirkxyllh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ofltasvrhp .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#ofltasvrhp .gt_heading {
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

#ofltasvrhp .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ofltasvrhp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ofltasvrhp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ofltasvrhp .gt_col_headings {
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

#ofltasvrhp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#ofltasvrhp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ofltasvrhp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ofltasvrhp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ofltasvrhp .gt_column_spanner {
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

#ofltasvrhp .gt_group_heading {
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

#ofltasvrhp .gt_empty_group_heading {
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

#ofltasvrhp .gt_from_md > :first-child {
  margin-top: 0;
}

#ofltasvrhp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ofltasvrhp .gt_row {
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

#ofltasvrhp .gt_stub {
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

#ofltasvrhp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ofltasvrhp .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ofltasvrhp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ofltasvrhp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ofltasvrhp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ofltasvrhp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ofltasvrhp .gt_footnotes {
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

#ofltasvrhp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ofltasvrhp .gt_sourcenotes {
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

#ofltasvrhp .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ofltasvrhp .gt_left {
  text-align: left;
}

#ofltasvrhp .gt_center {
  text-align: center;
}

#ofltasvrhp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ofltasvrhp .gt_font_normal {
  font-weight: normal;
}

#ofltasvrhp .gt_font_bold {
  font-weight: bold;
}

#ofltasvrhp .gt_font_italic {
  font-style: italic;
}

#ofltasvrhp .gt_super {
  font-size: 65%;
}

#ofltasvrhp .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ofltasvrhp" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="5" class="gt_heading gt_title gt_font_normal" style>inner_join(x = superheroes, y = publishers)</th>
    </tr>
    <tr>
      <th colspan="5" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->



## `semi_join(superheroes, publishers)`

> `semi_join(x, y)`: Return all rows from `x` where there are matching values in `y`, keeping just columns from `x`. A semi join differs from an inner join because an inner join will return one row of `x` for each matching row of `y`, where a semi join will never duplicate rows of `x`. This is a filtering join.


```r
(sjsp <- semi_join(superheroes, publishers))
#> Joining, by = "publisher"
#> # A tibble: 6 x 4
#>   name     alignment gender publisher
#>   <chr>    <chr>     <chr>  <chr>    
#> 1 Magneto  bad       male   Marvel   
#> 2 Storm    good      female Marvel   
#> 3 Mystique bad       female Marvel   
#> 4 Batman   good      male   DC       
#> 5 Joker    bad       male   DC       
#> 6 Catwoman bad       female DC
```

We get a similar result as with `inner_join()` but the join result contains only the variables originally found in `x = superheroes`.



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#glujwaylcb .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#glujwaylcb .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#glujwaylcb .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#glujwaylcb .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#glujwaylcb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#glujwaylcb .gt_col_headings {
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

#glujwaylcb .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#glujwaylcb .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#glujwaylcb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#glujwaylcb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#glujwaylcb .gt_column_spanner {
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

#glujwaylcb .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#glujwaylcb .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#glujwaylcb .gt_from_md > :first-child {
  margin-top: 0;
}

#glujwaylcb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#glujwaylcb .gt_row {
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

#glujwaylcb .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#glujwaylcb .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#glujwaylcb .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#glujwaylcb .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#glujwaylcb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#glujwaylcb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#glujwaylcb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#glujwaylcb .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#glujwaylcb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#glujwaylcb .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#glujwaylcb .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#glujwaylcb .gt_left {
  text-align: left;
}

#glujwaylcb .gt_center {
  text-align: center;
}

#glujwaylcb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#glujwaylcb .gt_font_normal {
  font-weight: normal;
}

#glujwaylcb .gt_font_bold {
  font-weight: bold;
}

#glujwaylcb .gt_font_italic {
  font-style: italic;
}

#glujwaylcb .gt_super {
  font-size: 65%;
}

#glujwaylcb .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="glujwaylcb" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ajdxfbyysm .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#ajdxfbyysm .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ajdxfbyysm .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ajdxfbyysm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ajdxfbyysm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ajdxfbyysm .gt_col_headings {
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

#ajdxfbyysm .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#ajdxfbyysm .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ajdxfbyysm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ajdxfbyysm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ajdxfbyysm .gt_column_spanner {
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

#ajdxfbyysm .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#ajdxfbyysm .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#ajdxfbyysm .gt_from_md > :first-child {
  margin-top: 0;
}

#ajdxfbyysm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ajdxfbyysm .gt_row {
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

#ajdxfbyysm .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#ajdxfbyysm .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ajdxfbyysm .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ajdxfbyysm .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ajdxfbyysm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ajdxfbyysm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ajdxfbyysm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ajdxfbyysm .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#ajdxfbyysm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ajdxfbyysm .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#ajdxfbyysm .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ajdxfbyysm .gt_left {
  text-align: left;
}

#ajdxfbyysm .gt_center {
  text-align: center;
}

#ajdxfbyysm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ajdxfbyysm .gt_font_normal {
  font-weight: normal;
}

#ajdxfbyysm .gt_font_bold {
  font-weight: bold;
}

#ajdxfbyysm .gt_font_italic {
  font-style: italic;
}

#ajdxfbyysm .gt_super {
  font-size: 65%;
}

#ajdxfbyysm .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ajdxfbyysm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#xkzbcrieyy .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#xkzbcrieyy .gt_heading {
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

#xkzbcrieyy .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xkzbcrieyy .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xkzbcrieyy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xkzbcrieyy .gt_col_headings {
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

#xkzbcrieyy .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#xkzbcrieyy .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#xkzbcrieyy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xkzbcrieyy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xkzbcrieyy .gt_column_spanner {
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

#xkzbcrieyy .gt_group_heading {
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

#xkzbcrieyy .gt_empty_group_heading {
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

#xkzbcrieyy .gt_from_md > :first-child {
  margin-top: 0;
}

#xkzbcrieyy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xkzbcrieyy .gt_row {
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

#xkzbcrieyy .gt_stub {
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

#xkzbcrieyy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xkzbcrieyy .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#xkzbcrieyy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xkzbcrieyy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xkzbcrieyy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xkzbcrieyy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xkzbcrieyy .gt_footnotes {
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

#xkzbcrieyy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#xkzbcrieyy .gt_sourcenotes {
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

#xkzbcrieyy .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#xkzbcrieyy .gt_left {
  text-align: left;
}

#xkzbcrieyy .gt_center {
  text-align: center;
}

#xkzbcrieyy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xkzbcrieyy .gt_font_normal {
  font-weight: normal;
}

#xkzbcrieyy .gt_font_bold {
  font-weight: bold;
}

#xkzbcrieyy .gt_font_italic {
  font-style: italic;
}

#xkzbcrieyy .gt_super {
  font-size: 65%;
}

#xkzbcrieyy .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="xkzbcrieyy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>semi_join(x = superheroes, y = publishers)</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->


## `left_join(superheroes, publishers)`

> `left_join(x, y)`: Return all rows from `x`, and all columns from `x` and `y`. If there are multiple matches between `x` and `y`, all combination of the matches are returned. This is a mutating join.


```r
(ljsp <- left_join(superheroes, publishers))
#> Joining, by = "publisher"
#> # A tibble: 7 x 5
#>   name     alignment gender publisher         yr_founded
#>   <chr>    <chr>     <chr>  <chr>                  <int>
#> 1 Magneto  bad       male   Marvel                  1939
#> 2 Storm    good      female Marvel                  1939
#> 3 Mystique bad       female Marvel                  1939
#> 4 Batman   good      male   DC                      1934
#> 5 Joker    bad       male   DC                      1934
#> 6 Catwoman bad       female DC                      1934
#> 7 Hellboy  good      male   Dark Horse Comics         NA
```

We basically get `x = superheroes` back, but with the addition of variable `yr_founded`, which is unique to `y = publishers`. Hellboy, whose publisher does not appear in `y = publishers`, has an `NA` for `yr_founded`.



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#doelqmbhtq .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#doelqmbhtq .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#doelqmbhtq .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#doelqmbhtq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#doelqmbhtq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#doelqmbhtq .gt_col_headings {
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

#doelqmbhtq .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#doelqmbhtq .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#doelqmbhtq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#doelqmbhtq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#doelqmbhtq .gt_column_spanner {
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

#doelqmbhtq .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#doelqmbhtq .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#doelqmbhtq .gt_from_md > :first-child {
  margin-top: 0;
}

#doelqmbhtq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#doelqmbhtq .gt_row {
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

#doelqmbhtq .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#doelqmbhtq .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#doelqmbhtq .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#doelqmbhtq .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#doelqmbhtq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#doelqmbhtq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#doelqmbhtq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#doelqmbhtq .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#doelqmbhtq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#doelqmbhtq .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#doelqmbhtq .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#doelqmbhtq .gt_left {
  text-align: left;
}

#doelqmbhtq .gt_center {
  text-align: center;
}

#doelqmbhtq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#doelqmbhtq .gt_font_normal {
  font-weight: normal;
}

#doelqmbhtq .gt_font_bold {
  font-weight: bold;
}

#doelqmbhtq .gt_font_italic {
  font-style: italic;
}

#doelqmbhtq .gt_super {
  font-size: 65%;
}

#doelqmbhtq .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="doelqmbhtq" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jimdurlydi .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#jimdurlydi .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jimdurlydi .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#jimdurlydi .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#jimdurlydi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jimdurlydi .gt_col_headings {
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

#jimdurlydi .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#jimdurlydi .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#jimdurlydi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jimdurlydi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jimdurlydi .gt_column_spanner {
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

#jimdurlydi .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#jimdurlydi .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#jimdurlydi .gt_from_md > :first-child {
  margin-top: 0;
}

#jimdurlydi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jimdurlydi .gt_row {
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

#jimdurlydi .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#jimdurlydi .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jimdurlydi .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#jimdurlydi .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jimdurlydi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jimdurlydi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jimdurlydi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jimdurlydi .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#jimdurlydi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#jimdurlydi .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#jimdurlydi .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#jimdurlydi .gt_left {
  text-align: left;
}

#jimdurlydi .gt_center {
  text-align: center;
}

#jimdurlydi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jimdurlydi .gt_font_normal {
  font-weight: normal;
}

#jimdurlydi .gt_font_bold {
  font-weight: bold;
}

#jimdurlydi .gt_font_italic {
  font-style: italic;
}

#jimdurlydi .gt_super {
  font-size: 65%;
}

#jimdurlydi .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jimdurlydi" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#nkhywbeyon .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#nkhywbeyon .gt_heading {
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

#nkhywbeyon .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#nkhywbeyon .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#nkhywbeyon .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nkhywbeyon .gt_col_headings {
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

#nkhywbeyon .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#nkhywbeyon .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#nkhywbeyon .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nkhywbeyon .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nkhywbeyon .gt_column_spanner {
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

#nkhywbeyon .gt_group_heading {
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

#nkhywbeyon .gt_empty_group_heading {
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

#nkhywbeyon .gt_from_md > :first-child {
  margin-top: 0;
}

#nkhywbeyon .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nkhywbeyon .gt_row {
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

#nkhywbeyon .gt_stub {
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

#nkhywbeyon .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nkhywbeyon .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#nkhywbeyon .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nkhywbeyon .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nkhywbeyon .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nkhywbeyon .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nkhywbeyon .gt_footnotes {
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

#nkhywbeyon .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#nkhywbeyon .gt_sourcenotes {
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

#nkhywbeyon .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#nkhywbeyon .gt_left {
  text-align: left;
}

#nkhywbeyon .gt_center {
  text-align: center;
}

#nkhywbeyon .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nkhywbeyon .gt_font_normal {
  font-weight: normal;
}

#nkhywbeyon .gt_font_bold {
  font-weight: bold;
}

#nkhywbeyon .gt_font_italic {
  font-style: italic;
}

#nkhywbeyon .gt_super {
  font-size: 65%;
}

#nkhywbeyon .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="nkhywbeyon" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="5" class="gt_heading gt_title gt_font_normal" style>left_join(x = superheroes, y = publishers)</th>
    </tr>
    <tr>
      <th colspan="5" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
      <td class="gt_row gt_center">NA</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->


## `anti_join(superheroes, publishers)`

> `anti_join(x, y)`: Return all rows from `x` where there are not matching values in `y`, keeping just columns from `x`. This is a filtering join.


```r
(ajsp <- anti_join(superheroes, publishers))
#> Joining, by = "publisher"
#> # A tibble: 1 x 4
#>   name    alignment gender publisher        
#>   <chr>   <chr>     <chr>  <chr>            
#> 1 Hellboy good      male   Dark Horse Comics
```

We keep __only__ Hellboy now (and do not get `yr_founded`).



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pecsomzwss .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#pecsomzwss .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pecsomzwss .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#pecsomzwss .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#pecsomzwss .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pecsomzwss .gt_col_headings {
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

#pecsomzwss .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#pecsomzwss .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#pecsomzwss .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pecsomzwss .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pecsomzwss .gt_column_spanner {
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

#pecsomzwss .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#pecsomzwss .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#pecsomzwss .gt_from_md > :first-child {
  margin-top: 0;
}

#pecsomzwss .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pecsomzwss .gt_row {
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

#pecsomzwss .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#pecsomzwss .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pecsomzwss .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#pecsomzwss .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pecsomzwss .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pecsomzwss .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pecsomzwss .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pecsomzwss .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#pecsomzwss .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#pecsomzwss .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#pecsomzwss .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#pecsomzwss .gt_left {
  text-align: left;
}

#pecsomzwss .gt_center {
  text-align: center;
}

#pecsomzwss .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pecsomzwss .gt_font_normal {
  font-weight: normal;
}

#pecsomzwss .gt_font_bold {
  font-weight: bold;
}

#pecsomzwss .gt_font_italic {
  font-style: italic;
}

#pecsomzwss .gt_super {
  font-size: 65%;
}

#pecsomzwss .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="pecsomzwss" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#wrbcuckwwc .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#wrbcuckwwc .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#wrbcuckwwc .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#wrbcuckwwc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#wrbcuckwwc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wrbcuckwwc .gt_col_headings {
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

#wrbcuckwwc .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#wrbcuckwwc .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#wrbcuckwwc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#wrbcuckwwc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#wrbcuckwwc .gt_column_spanner {
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

#wrbcuckwwc .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#wrbcuckwwc .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#wrbcuckwwc .gt_from_md > :first-child {
  margin-top: 0;
}

#wrbcuckwwc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wrbcuckwwc .gt_row {
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

#wrbcuckwwc .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#wrbcuckwwc .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wrbcuckwwc .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#wrbcuckwwc .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wrbcuckwwc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#wrbcuckwwc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#wrbcuckwwc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wrbcuckwwc .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#wrbcuckwwc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#wrbcuckwwc .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#wrbcuckwwc .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#wrbcuckwwc .gt_left {
  text-align: left;
}

#wrbcuckwwc .gt_center {
  text-align: center;
}

#wrbcuckwwc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wrbcuckwwc .gt_font_normal {
  font-weight: normal;
}

#wrbcuckwwc .gt_font_bold {
  font-weight: bold;
}

#wrbcuckwwc .gt_font_italic {
  font-style: italic;
}

#wrbcuckwwc .gt_super {
  font-size: 65%;
}

#wrbcuckwwc .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="wrbcuckwwc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#dmcxkhtayw .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#dmcxkhtayw .gt_heading {
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

#dmcxkhtayw .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#dmcxkhtayw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#dmcxkhtayw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dmcxkhtayw .gt_col_headings {
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

#dmcxkhtayw .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#dmcxkhtayw .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#dmcxkhtayw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dmcxkhtayw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dmcxkhtayw .gt_column_spanner {
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

#dmcxkhtayw .gt_group_heading {
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

#dmcxkhtayw .gt_empty_group_heading {
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

#dmcxkhtayw .gt_from_md > :first-child {
  margin-top: 0;
}

#dmcxkhtayw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dmcxkhtayw .gt_row {
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

#dmcxkhtayw .gt_stub {
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

#dmcxkhtayw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dmcxkhtayw .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dmcxkhtayw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dmcxkhtayw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dmcxkhtayw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dmcxkhtayw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dmcxkhtayw .gt_footnotes {
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

#dmcxkhtayw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dmcxkhtayw .gt_sourcenotes {
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

#dmcxkhtayw .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dmcxkhtayw .gt_left {
  text-align: left;
}

#dmcxkhtayw .gt_center {
  text-align: center;
}

#dmcxkhtayw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dmcxkhtayw .gt_font_normal {
  font-weight: normal;
}

#dmcxkhtayw .gt_font_bold {
  font-weight: bold;
}

#dmcxkhtayw .gt_font_italic {
  font-style: italic;
}

#dmcxkhtayw .gt_super {
  font-size: 65%;
}

#dmcxkhtayw .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dmcxkhtayw" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>anti_join(x = superheroes, y = publishers)</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->


## `inner_join(publishers, superheroes)`

> `inner_join(x, y)`: Return all rows from `x` where there are matching values in `y`, and all columns from `x` and `y`. If there are multiple matches between `x` and `y`, all combination of the matches are returned. This is a mutating join.


```r
(ijps <- inner_join(publishers, superheroes))
#> Joining, by = "publisher"
#> # A tibble: 6 x 5
#>   publisher yr_founded name     alignment gender
#>   <chr>          <int> <chr>    <chr>     <chr> 
#> 1 DC              1934 Batman   good      male  
#> 2 DC              1934 Joker    bad       male  
#> 3 DC              1934 Catwoman bad       female
#> 4 Marvel          1939 Magneto  bad       male  
#> 5 Marvel          1939 Storm    good      female
#> 6 Marvel          1939 Mystique bad       female
```

In a way, this does illustrate multiple matches, if you think about it from the `x = publishers` direction. Every publisher that has a match in `y = superheroes` appears multiple times in the result, once for each match. In fact, we're getting the same result as with `inner_join(superheroes, publishers)`, up to variable order (which you should also never rely on in an analysis).



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#padrwpxloy .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#padrwpxloy .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#padrwpxloy .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#padrwpxloy .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#padrwpxloy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#padrwpxloy .gt_col_headings {
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

#padrwpxloy .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#padrwpxloy .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#padrwpxloy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#padrwpxloy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#padrwpxloy .gt_column_spanner {
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

#padrwpxloy .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#padrwpxloy .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#padrwpxloy .gt_from_md > :first-child {
  margin-top: 0;
}

#padrwpxloy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#padrwpxloy .gt_row {
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

#padrwpxloy .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#padrwpxloy .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#padrwpxloy .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#padrwpxloy .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#padrwpxloy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#padrwpxloy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#padrwpxloy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#padrwpxloy .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#padrwpxloy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#padrwpxloy .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#padrwpxloy .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#padrwpxloy .gt_left {
  text-align: left;
}

#padrwpxloy .gt_center {
  text-align: center;
}

#padrwpxloy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#padrwpxloy .gt_font_normal {
  font-weight: normal;
}

#padrwpxloy .gt_font_bold {
  font-weight: bold;
}

#padrwpxloy .gt_font_italic {
  font-style: italic;
}

#padrwpxloy .gt_super {
  font-size: 65%;
}

#padrwpxloy .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="padrwpxloy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#kxptjvyfep .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#kxptjvyfep .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#kxptjvyfep .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#kxptjvyfep .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#kxptjvyfep .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kxptjvyfep .gt_col_headings {
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

#kxptjvyfep .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#kxptjvyfep .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#kxptjvyfep .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kxptjvyfep .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kxptjvyfep .gt_column_spanner {
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

#kxptjvyfep .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#kxptjvyfep .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#kxptjvyfep .gt_from_md > :first-child {
  margin-top: 0;
}

#kxptjvyfep .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kxptjvyfep .gt_row {
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

#kxptjvyfep .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#kxptjvyfep .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kxptjvyfep .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#kxptjvyfep .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kxptjvyfep .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kxptjvyfep .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kxptjvyfep .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kxptjvyfep .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#kxptjvyfep .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#kxptjvyfep .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#kxptjvyfep .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#kxptjvyfep .gt_left {
  text-align: left;
}

#kxptjvyfep .gt_center {
  text-align: center;
}

#kxptjvyfep .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kxptjvyfep .gt_font_normal {
  font-weight: normal;
}

#kxptjvyfep .gt_font_bold {
  font-weight: bold;
}

#kxptjvyfep .gt_font_italic {
  font-style: italic;
}

#kxptjvyfep .gt_super {
  font-size: 65%;
}

#kxptjvyfep .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kxptjvyfep" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#unhmgorbqf .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#unhmgorbqf .gt_heading {
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

#unhmgorbqf .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#unhmgorbqf .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#unhmgorbqf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#unhmgorbqf .gt_col_headings {
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

#unhmgorbqf .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#unhmgorbqf .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#unhmgorbqf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#unhmgorbqf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#unhmgorbqf .gt_column_spanner {
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

#unhmgorbqf .gt_group_heading {
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

#unhmgorbqf .gt_empty_group_heading {
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

#unhmgorbqf .gt_from_md > :first-child {
  margin-top: 0;
}

#unhmgorbqf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#unhmgorbqf .gt_row {
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

#unhmgorbqf .gt_stub {
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

#unhmgorbqf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#unhmgorbqf .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#unhmgorbqf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#unhmgorbqf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#unhmgorbqf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#unhmgorbqf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#unhmgorbqf .gt_footnotes {
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

#unhmgorbqf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#unhmgorbqf .gt_sourcenotes {
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

#unhmgorbqf .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#unhmgorbqf .gt_left {
  text-align: left;
}

#unhmgorbqf .gt_center {
  text-align: center;
}

#unhmgorbqf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#unhmgorbqf .gt_font_normal {
  font-weight: normal;
}

#unhmgorbqf .gt_font_bold {
  font-weight: bold;
}

#unhmgorbqf .gt_font_italic {
  font-style: italic;
}

#unhmgorbqf .gt_super {
  font-size: 65%;
}

#unhmgorbqf .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="unhmgorbqf" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="5" class="gt_heading gt_title gt_font_normal" style>inner_join(x = publishers, y = superheroes)</th>
    </tr>
    <tr>
      <th colspan="5" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
      <td class="gt_row gt_left">Batman</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
      <td class="gt_row gt_left gt_striped">Joker</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">male</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
      <td class="gt_row gt_left">Catwoman</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
      <td class="gt_row gt_left gt_striped">Magneto</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">male</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
      <td class="gt_row gt_left">Storm</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">female</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
      <td class="gt_row gt_left gt_striped">Mystique</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->


## `semi_join(publishers, superheroes)`

> `semi_join(x, y)`: Return all rows from `x` where there are matching values in `y`, keeping just columns from `x`. A semi join differs from an inner join because an inner join will return one row of `x` for each matching row of `y`, where a semi join will never duplicate rows of `x`. This is a filtering join.


```r
(sjps <- semi_join(x = publishers, y = superheroes))
#> Joining, by = "publisher"
#> # A tibble: 2 x 2
#>   publisher yr_founded
#>   <chr>          <int>
#> 1 DC              1934
#> 2 Marvel          1939
```

Now the effects of switching the `x` and `y` roles is more clear. The result resembles `x = publishers`, but the publisher Image is lost, because there are no observations where `publisher == "Image"` in `y = superheroes`.



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#hsczzsuvfr .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#hsczzsuvfr .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#hsczzsuvfr .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#hsczzsuvfr .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#hsczzsuvfr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hsczzsuvfr .gt_col_headings {
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

#hsczzsuvfr .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#hsczzsuvfr .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#hsczzsuvfr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hsczzsuvfr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hsczzsuvfr .gt_column_spanner {
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

#hsczzsuvfr .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#hsczzsuvfr .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#hsczzsuvfr .gt_from_md > :first-child {
  margin-top: 0;
}

#hsczzsuvfr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hsczzsuvfr .gt_row {
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

#hsczzsuvfr .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#hsczzsuvfr .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hsczzsuvfr .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#hsczzsuvfr .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hsczzsuvfr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hsczzsuvfr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hsczzsuvfr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hsczzsuvfr .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#hsczzsuvfr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#hsczzsuvfr .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#hsczzsuvfr .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#hsczzsuvfr .gt_left {
  text-align: left;
}

#hsczzsuvfr .gt_center {
  text-align: center;
}

#hsczzsuvfr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hsczzsuvfr .gt_font_normal {
  font-weight: normal;
}

#hsczzsuvfr .gt_font_bold {
  font-weight: bold;
}

#hsczzsuvfr .gt_font_italic {
  font-style: italic;
}

#hsczzsuvfr .gt_super {
  font-size: 65%;
}

#hsczzsuvfr .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="hsczzsuvfr" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#llzblesjow .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#llzblesjow .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#llzblesjow .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#llzblesjow .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#llzblesjow .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#llzblesjow .gt_col_headings {
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

#llzblesjow .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#llzblesjow .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#llzblesjow .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#llzblesjow .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#llzblesjow .gt_column_spanner {
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

#llzblesjow .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#llzblesjow .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#llzblesjow .gt_from_md > :first-child {
  margin-top: 0;
}

#llzblesjow .gt_from_md > :last-child {
  margin-bottom: 0;
}

#llzblesjow .gt_row {
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

#llzblesjow .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#llzblesjow .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#llzblesjow .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#llzblesjow .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#llzblesjow .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#llzblesjow .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#llzblesjow .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#llzblesjow .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#llzblesjow .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#llzblesjow .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#llzblesjow .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#llzblesjow .gt_left {
  text-align: left;
}

#llzblesjow .gt_center {
  text-align: center;
}

#llzblesjow .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#llzblesjow .gt_font_normal {
  font-weight: normal;
}

#llzblesjow .gt_font_bold {
  font-weight: bold;
}

#llzblesjow .gt_font_italic {
  font-style: italic;
}

#llzblesjow .gt_super {
  font-size: 65%;
}

#llzblesjow .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="llzblesjow" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qttsbrgnho .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#qttsbrgnho .gt_heading {
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

#qttsbrgnho .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qttsbrgnho .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qttsbrgnho .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qttsbrgnho .gt_col_headings {
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

#qttsbrgnho .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#qttsbrgnho .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#qttsbrgnho .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qttsbrgnho .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qttsbrgnho .gt_column_spanner {
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

#qttsbrgnho .gt_group_heading {
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

#qttsbrgnho .gt_empty_group_heading {
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

#qttsbrgnho .gt_from_md > :first-child {
  margin-top: 0;
}

#qttsbrgnho .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qttsbrgnho .gt_row {
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

#qttsbrgnho .gt_stub {
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

#qttsbrgnho .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qttsbrgnho .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#qttsbrgnho .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qttsbrgnho .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qttsbrgnho .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qttsbrgnho .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qttsbrgnho .gt_footnotes {
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

#qttsbrgnho .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#qttsbrgnho .gt_sourcenotes {
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

#qttsbrgnho .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#qttsbrgnho .gt_left {
  text-align: left;
}

#qttsbrgnho .gt_center {
  text-align: center;
}

#qttsbrgnho .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qttsbrgnho .gt_font_normal {
  font-weight: normal;
}

#qttsbrgnho .gt_font_bold {
  font-weight: bold;
}

#qttsbrgnho .gt_font_italic {
  font-style: italic;
}

#qttsbrgnho .gt_super {
  font-size: 65%;
}

#qttsbrgnho .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qttsbrgnho" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>semi_join(x = publishers, y = superheroes)</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->


## `left_join(publishers, superheroes)`

> `left_join(x, y)`: Return all rows from `x`, and all columns from `x` and `y`. If there are multiple matches between `x` and `y`, all combination of the matches are returned. This is a mutating join.


```r
(ljps <- left_join(publishers, superheroes))
#> Joining, by = "publisher"
#> # A tibble: 7 x 5
#>   publisher yr_founded name     alignment gender
#>   <chr>          <int> <chr>    <chr>     <chr> 
#> 1 DC              1934 Batman   good      male  
#> 2 DC              1934 Joker    bad       male  
#> 3 DC              1934 Catwoman bad       female
#> 4 Marvel          1939 Magneto  bad       male  
#> 5 Marvel          1939 Storm    good      female
#> 6 Marvel          1939 Mystique bad       female
#> 7 Image           1992 <NA>     <NA>      <NA>
```

We get a similar result as with `inner_join()` but the publisher Image survives in the join, even though no superheroes from Image appear in `y = superheroes`. As a result, Image has `NA`s for `name`, `alignment`, and `gender`.



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qjuzupvalx .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#qjuzupvalx .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#qjuzupvalx .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#qjuzupvalx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#qjuzupvalx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qjuzupvalx .gt_col_headings {
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

#qjuzupvalx .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#qjuzupvalx .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#qjuzupvalx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qjuzupvalx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qjuzupvalx .gt_column_spanner {
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

#qjuzupvalx .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#qjuzupvalx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#qjuzupvalx .gt_from_md > :first-child {
  margin-top: 0;
}

#qjuzupvalx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qjuzupvalx .gt_row {
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

#qjuzupvalx .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#qjuzupvalx .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qjuzupvalx .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#qjuzupvalx .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qjuzupvalx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qjuzupvalx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qjuzupvalx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qjuzupvalx .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#qjuzupvalx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#qjuzupvalx .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#qjuzupvalx .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#qjuzupvalx .gt_left {
  text-align: left;
}

#qjuzupvalx .gt_center {
  text-align: center;
}

#qjuzupvalx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qjuzupvalx .gt_font_normal {
  font-weight: normal;
}

#qjuzupvalx .gt_font_bold {
  font-weight: bold;
}

#qjuzupvalx .gt_font_italic {
  font-style: italic;
}

#qjuzupvalx .gt_super {
  font-size: 65%;
}

#qjuzupvalx .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qjuzupvalx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#fsefpobgdp .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#fsefpobgdp .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#fsefpobgdp .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#fsefpobgdp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#fsefpobgdp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fsefpobgdp .gt_col_headings {
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

#fsefpobgdp .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#fsefpobgdp .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#fsefpobgdp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fsefpobgdp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fsefpobgdp .gt_column_spanner {
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

#fsefpobgdp .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#fsefpobgdp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#fsefpobgdp .gt_from_md > :first-child {
  margin-top: 0;
}

#fsefpobgdp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fsefpobgdp .gt_row {
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

#fsefpobgdp .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#fsefpobgdp .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fsefpobgdp .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#fsefpobgdp .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fsefpobgdp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fsefpobgdp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fsefpobgdp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fsefpobgdp .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#fsefpobgdp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#fsefpobgdp .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#fsefpobgdp .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#fsefpobgdp .gt_left {
  text-align: left;
}

#fsefpobgdp .gt_center {
  text-align: center;
}

#fsefpobgdp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fsefpobgdp .gt_font_normal {
  font-weight: normal;
}

#fsefpobgdp .gt_font_bold {
  font-weight: bold;
}

#fsefpobgdp .gt_font_italic {
  font-style: italic;
}

#fsefpobgdp .gt_super {
  font-size: 65%;
}

#fsefpobgdp .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="fsefpobgdp" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#gglvjnsufa .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#gglvjnsufa .gt_heading {
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

#gglvjnsufa .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gglvjnsufa .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gglvjnsufa .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gglvjnsufa .gt_col_headings {
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

#gglvjnsufa .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#gglvjnsufa .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#gglvjnsufa .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gglvjnsufa .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gglvjnsufa .gt_column_spanner {
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

#gglvjnsufa .gt_group_heading {
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

#gglvjnsufa .gt_empty_group_heading {
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

#gglvjnsufa .gt_from_md > :first-child {
  margin-top: 0;
}

#gglvjnsufa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gglvjnsufa .gt_row {
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

#gglvjnsufa .gt_stub {
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

#gglvjnsufa .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gglvjnsufa .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#gglvjnsufa .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gglvjnsufa .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gglvjnsufa .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gglvjnsufa .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gglvjnsufa .gt_footnotes {
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

#gglvjnsufa .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#gglvjnsufa .gt_sourcenotes {
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

#gglvjnsufa .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#gglvjnsufa .gt_left {
  text-align: left;
}

#gglvjnsufa .gt_center {
  text-align: center;
}

#gglvjnsufa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gglvjnsufa .gt_font_normal {
  font-weight: normal;
}

#gglvjnsufa .gt_font_bold {
  font-weight: bold;
}

#gglvjnsufa .gt_font_italic {
  font-style: italic;
}

#gglvjnsufa .gt_super {
  font-size: 65%;
}

#gglvjnsufa .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="gglvjnsufa" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="5" class="gt_heading gt_title gt_font_normal" style>left_join(x = publishers, y = superheroes)</th>
    </tr>
    <tr>
      <th colspan="5" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
      <td class="gt_row gt_left">Batman</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
      <td class="gt_row gt_left gt_striped">Joker</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">male</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
      <td class="gt_row gt_left">Catwoman</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
      <td class="gt_row gt_left gt_striped">Magneto</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">male</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
      <td class="gt_row gt_left">Storm</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">female</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
      <td class="gt_row gt_left gt_striped">Mystique</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
      <td class="gt_row gt_left">NA</td>
      <td class="gt_row gt_left">NA</td>
      <td class="gt_row gt_left">NA</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->

## `anti_join(publishers, superheroes)`

> `anti_join(x, y)`: Return all rows from `x` where there are not matching values in `y`, keeping just columns from `x`. This is a filtering join.


```r
(ajps <- anti_join(publishers, superheroes))
#> Joining, by = "publisher"
#> # A tibble: 1 x 2
#>   publisher yr_founded
#>   <chr>          <int>
#> 1 Image           1992
```

We keep __only__ publisher Image now (and the variables found in `x = publishers`).



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#dnhqdzfsrt .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#dnhqdzfsrt .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#dnhqdzfsrt .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#dnhqdzfsrt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#dnhqdzfsrt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dnhqdzfsrt .gt_col_headings {
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

#dnhqdzfsrt .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#dnhqdzfsrt .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#dnhqdzfsrt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dnhqdzfsrt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dnhqdzfsrt .gt_column_spanner {
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

#dnhqdzfsrt .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#dnhqdzfsrt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#dnhqdzfsrt .gt_from_md > :first-child {
  margin-top: 0;
}

#dnhqdzfsrt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dnhqdzfsrt .gt_row {
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

#dnhqdzfsrt .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#dnhqdzfsrt .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dnhqdzfsrt .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dnhqdzfsrt .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dnhqdzfsrt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dnhqdzfsrt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dnhqdzfsrt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dnhqdzfsrt .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#dnhqdzfsrt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dnhqdzfsrt .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#dnhqdzfsrt .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dnhqdzfsrt .gt_left {
  text-align: left;
}

#dnhqdzfsrt .gt_center {
  text-align: center;
}

#dnhqdzfsrt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dnhqdzfsrt .gt_font_normal {
  font-weight: normal;
}

#dnhqdzfsrt .gt_font_bold {
  font-weight: bold;
}

#dnhqdzfsrt .gt_font_italic {
  font-style: italic;
}

#dnhqdzfsrt .gt_super {
  font-size: 65%;
}

#dnhqdzfsrt .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dnhqdzfsrt" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#mttjxisptt .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#mttjxisptt .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#mttjxisptt .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#mttjxisptt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#mttjxisptt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mttjxisptt .gt_col_headings {
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

#mttjxisptt .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#mttjxisptt .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#mttjxisptt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mttjxisptt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mttjxisptt .gt_column_spanner {
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

#mttjxisptt .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#mttjxisptt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#mttjxisptt .gt_from_md > :first-child {
  margin-top: 0;
}

#mttjxisptt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mttjxisptt .gt_row {
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

#mttjxisptt .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#mttjxisptt .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mttjxisptt .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#mttjxisptt .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mttjxisptt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mttjxisptt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mttjxisptt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mttjxisptt .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#mttjxisptt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#mttjxisptt .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#mttjxisptt .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#mttjxisptt .gt_left {
  text-align: left;
}

#mttjxisptt .gt_center {
  text-align: center;
}

#mttjxisptt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mttjxisptt .gt_font_normal {
  font-weight: normal;
}

#mttjxisptt .gt_font_bold {
  font-weight: bold;
}

#mttjxisptt .gt_font_italic {
  font-style: italic;
}

#mttjxisptt .gt_super {
  font-size: 65%;
}

#mttjxisptt .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mttjxisptt" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#eyiexadypy .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#eyiexadypy .gt_heading {
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

#eyiexadypy .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#eyiexadypy .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#eyiexadypy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eyiexadypy .gt_col_headings {
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

#eyiexadypy .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#eyiexadypy .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#eyiexadypy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#eyiexadypy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#eyiexadypy .gt_column_spanner {
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

#eyiexadypy .gt_group_heading {
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

#eyiexadypy .gt_empty_group_heading {
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

#eyiexadypy .gt_from_md > :first-child {
  margin-top: 0;
}

#eyiexadypy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#eyiexadypy .gt_row {
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

#eyiexadypy .gt_stub {
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

#eyiexadypy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#eyiexadypy .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#eyiexadypy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#eyiexadypy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#eyiexadypy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#eyiexadypy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eyiexadypy .gt_footnotes {
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

#eyiexadypy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#eyiexadypy .gt_sourcenotes {
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

#eyiexadypy .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#eyiexadypy .gt_left {
  text-align: left;
}

#eyiexadypy .gt_center {
  text-align: center;
}

#eyiexadypy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#eyiexadypy .gt_font_normal {
  font-weight: normal;
}

#eyiexadypy .gt_font_bold {
  font-weight: bold;
}

#eyiexadypy .gt_font_italic {
  font-style: italic;
}

#eyiexadypy .gt_super {
  font-size: 65%;
}

#eyiexadypy .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="eyiexadypy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>anti_join(x = publishers, y = superheroes)</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->

## `full_join(superheroes, publishers)`

> `full_join(x, y)`: Return all rows and all columns from both `x` and `y`. Where there are not matching values, returns `NA` for the one missing. This is a mutating join.


```r
(fjsp <- full_join(superheroes, publishers))
#> Joining, by = "publisher"
#> # A tibble: 8 x 5
#>   name     alignment gender publisher         yr_founded
#>   <chr>    <chr>     <chr>  <chr>                  <int>
#> 1 Magneto  bad       male   Marvel                  1939
#> 2 Storm    good      female Marvel                  1939
#> 3 Mystique bad       female Marvel                  1939
#> 4 Batman   good      male   DC                      1934
#> 5 Joker    bad       male   DC                      1934
#> 6 Catwoman bad       female DC                      1934
#> 7 Hellboy  good      male   Dark Horse Comics         NA
#> 8 <NA>     <NA>      <NA>   Image                   1992
```

We get all rows of `x = superheroes` plus a new row from `y = publishers`, containing the publisher Image. We get all variables from `x = superheroes` AND all variables from `y = publishers`. Any row that derives solely from one table or the other carries `NA`s in the variables found only in the other table.



<!--html_preserve--><table style="width: 100%; border: 0px;">
<tr>
<td style="width: 38%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#aaswtbyolj .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #edc7fc;
  width: 100%;
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

#aaswtbyolj .gt_heading {
  background-color: #edc7fc;
  text-align: center;
  border-bottom-color: #edc7fc;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#aaswtbyolj .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#aaswtbyolj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#aaswtbyolj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#aaswtbyolj .gt_col_headings {
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

#aaswtbyolj .gt_col_heading {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
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

#aaswtbyolj .gt_column_spanner_outer {
  color: #333333;
  background-color: #edc7fc;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#aaswtbyolj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#aaswtbyolj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#aaswtbyolj .gt_column_spanner {
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

#aaswtbyolj .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #edc7fc;
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

#aaswtbyolj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #edc7fc;
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

#aaswtbyolj .gt_from_md > :first-child {
  margin-top: 0;
}

#aaswtbyolj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#aaswtbyolj .gt_row {
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

#aaswtbyolj .gt_stub {
  color: #333333;
  background-color: #edc7fc;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#aaswtbyolj .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#aaswtbyolj .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#aaswtbyolj .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#aaswtbyolj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#aaswtbyolj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#aaswtbyolj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#aaswtbyolj .gt_footnotes {
  color: #333333;
  background-color: #edc7fc;
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

#aaswtbyolj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#aaswtbyolj .gt_sourcenotes {
  color: #333333;
  background-color: #edc7fc;
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

#aaswtbyolj .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#aaswtbyolj .gt_left {
  text-align: left;
}

#aaswtbyolj .gt_center {
  text-align: center;
}

#aaswtbyolj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#aaswtbyolj .gt_font_normal {
  font-weight: normal;
}

#aaswtbyolj .gt_font_bold {
  font-weight: bold;
}

#aaswtbyolj .gt_font_italic {
  font-style: italic;
}

#aaswtbyolj .gt_super {
  font-size: 65%;
}

#aaswtbyolj .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="aaswtbyolj" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>superheroes</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 18%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ddvviokawl .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #cce6f6;
  width: 100%;
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

#ddvviokawl .gt_heading {
  background-color: #cce6f6;
  text-align: center;
  border-bottom-color: #cce6f6;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ddvviokawl .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ddvviokawl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ddvviokawl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ddvviokawl .gt_col_headings {
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

#ddvviokawl .gt_col_heading {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
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

#ddvviokawl .gt_column_spanner_outer {
  color: #333333;
  background-color: #cce6f6;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ddvviokawl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ddvviokawl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ddvviokawl .gt_column_spanner {
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

#ddvviokawl .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #cce6f6;
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

#ddvviokawl .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #cce6f6;
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

#ddvviokawl .gt_from_md > :first-child {
  margin-top: 0;
}

#ddvviokawl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ddvviokawl .gt_row {
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

#ddvviokawl .gt_stub {
  color: #333333;
  background-color: #cce6f6;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#ddvviokawl .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ddvviokawl .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ddvviokawl .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ddvviokawl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ddvviokawl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ddvviokawl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ddvviokawl .gt_footnotes {
  color: #333333;
  background-color: #cce6f6;
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

#ddvviokawl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ddvviokawl .gt_sourcenotes {
  color: #333333;
  background-color: #cce6f6;
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

#ddvviokawl .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ddvviokawl .gt_left {
  text-align: left;
}

#ddvviokawl .gt_center {
  text-align: center;
}

#ddvviokawl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ddvviokawl .gt_font_normal {
  font-weight: normal;
}

#ddvviokawl .gt_font_bold {
  font-weight: bold;
}

#ddvviokawl .gt_font_italic {
  font-style: italic;
}

#ddvviokawl .gt_super {
  font-size: 65%;
}

#ddvviokawl .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ddvviokawl" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="2" class="gt_heading gt_title gt_font_normal" style>publishers</th>
    </tr>
    <tr>
      <th colspan="2" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Image</td>
      <td class="gt_row gt_center">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
<td style="width: 44%; vertical-align: top;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#vzjkgjuajd .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: 0;
  margin-right: auto;
  color: #333333;
  font-size: 80%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
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

#vzjkgjuajd .gt_heading {
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

#vzjkgjuajd .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vzjkgjuajd .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vzjkgjuajd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vzjkgjuajd .gt_col_headings {
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

#vzjkgjuajd .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
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

#vzjkgjuajd .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 90%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#vzjkgjuajd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vzjkgjuajd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vzjkgjuajd .gt_column_spanner {
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

#vzjkgjuajd .gt_group_heading {
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

#vzjkgjuajd .gt_empty_group_heading {
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

#vzjkgjuajd .gt_from_md > :first-child {
  margin-top: 0;
}

#vzjkgjuajd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vzjkgjuajd .gt_row {
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

#vzjkgjuajd .gt_stub {
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

#vzjkgjuajd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vzjkgjuajd .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#vzjkgjuajd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vzjkgjuajd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vzjkgjuajd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vzjkgjuajd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vzjkgjuajd .gt_footnotes {
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

#vzjkgjuajd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#vzjkgjuajd .gt_sourcenotes {
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

#vzjkgjuajd .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#vzjkgjuajd .gt_left {
  text-align: left;
}

#vzjkgjuajd .gt_center {
  text-align: center;
}

#vzjkgjuajd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vzjkgjuajd .gt_font_normal {
  font-weight: normal;
}

#vzjkgjuajd .gt_font_bold {
  font-weight: bold;
}

#vzjkgjuajd .gt_font_italic {
  font-style: italic;
}

#vzjkgjuajd .gt_super {
  font-size: 65%;
}

#vzjkgjuajd .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="vzjkgjuajd" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="5" class="gt_heading gt_title gt_font_normal" style>full_join(x = superheroes, y = publishers)</th>
    </tr>
    <tr>
      <th colspan="5" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">alignment</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">publisher</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">yr_founded</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Magneto</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Storm</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">Marvel</td>
      <td class="gt_row gt_center gt_striped">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Mystique</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">female</td>
      <td class="gt_row gt_left">Marvel</td>
      <td class="gt_row gt_center">1939</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Batman</td>
      <td class="gt_row gt_left gt_striped">good</td>
      <td class="gt_row gt_left gt_striped">male</td>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Joker</td>
      <td class="gt_row gt_left">bad</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">DC</td>
      <td class="gt_row gt_center">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Catwoman</td>
      <td class="gt_row gt_left gt_striped">bad</td>
      <td class="gt_row gt_left gt_striped">female</td>
      <td class="gt_row gt_left gt_striped">DC</td>
      <td class="gt_row gt_center gt_striped">1934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Hellboy</td>
      <td class="gt_row gt_left">good</td>
      <td class="gt_row gt_left">male</td>
      <td class="gt_row gt_left">Dark Horse Comics</td>
      <td class="gt_row gt_center">NA</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">NA</td>
      <td class="gt_row gt_left gt_striped">NA</td>
      <td class="gt_row gt_left gt_striped">NA</td>
      <td class="gt_row gt_left gt_striped">Image</td>
      <td class="gt_row gt_center gt_striped">1992</td>
    </tr>
  </tbody>
  
  
</table></div>
</td>
</tr>
</table><!--/html_preserve-->


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
