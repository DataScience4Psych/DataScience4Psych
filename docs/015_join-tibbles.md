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

#cdflzxzako .gt_table {
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

#cdflzxzako .gt_heading {
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

#cdflzxzako .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#cdflzxzako .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#cdflzxzako .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cdflzxzako .gt_col_headings {
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

#cdflzxzako .gt_col_heading {
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

#cdflzxzako .gt_column_spanner_outer {
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

#cdflzxzako .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cdflzxzako .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cdflzxzako .gt_column_spanner {
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

#cdflzxzako .gt_group_heading {
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

#cdflzxzako .gt_empty_group_heading {
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

#cdflzxzako .gt_from_md > :first-child {
  margin-top: 0;
}

#cdflzxzako .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cdflzxzako .gt_row {
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

#cdflzxzako .gt_stub {
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

#cdflzxzako .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cdflzxzako .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#cdflzxzako .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cdflzxzako .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cdflzxzako .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cdflzxzako .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cdflzxzako .gt_footnotes {
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

#cdflzxzako .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#cdflzxzako .gt_sourcenotes {
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

#cdflzxzako .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#cdflzxzako .gt_left {
  text-align: left;
}

#cdflzxzako .gt_center {
  text-align: center;
}

#cdflzxzako .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cdflzxzako .gt_font_normal {
  font-weight: normal;
}

#cdflzxzako .gt_font_bold {
  font-weight: bold;
}

#cdflzxzako .gt_font_italic {
  font-style: italic;
}

#cdflzxzako .gt_super {
  font-size: 65%;
}

#cdflzxzako .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="cdflzxzako" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#bnxnqjxfva .gt_table {
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

#bnxnqjxfva .gt_heading {
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

#bnxnqjxfva .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#bnxnqjxfva .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#bnxnqjxfva .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bnxnqjxfva .gt_col_headings {
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

#bnxnqjxfva .gt_col_heading {
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

#bnxnqjxfva .gt_column_spanner_outer {
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

#bnxnqjxfva .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bnxnqjxfva .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bnxnqjxfva .gt_column_spanner {
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

#bnxnqjxfva .gt_group_heading {
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

#bnxnqjxfva .gt_empty_group_heading {
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

#bnxnqjxfva .gt_from_md > :first-child {
  margin-top: 0;
}

#bnxnqjxfva .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bnxnqjxfva .gt_row {
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

#bnxnqjxfva .gt_stub {
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

#bnxnqjxfva .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bnxnqjxfva .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#bnxnqjxfva .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bnxnqjxfva .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bnxnqjxfva .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bnxnqjxfva .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bnxnqjxfva .gt_footnotes {
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

#bnxnqjxfva .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#bnxnqjxfva .gt_sourcenotes {
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

#bnxnqjxfva .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#bnxnqjxfva .gt_left {
  text-align: left;
}

#bnxnqjxfva .gt_center {
  text-align: center;
}

#bnxnqjxfva .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bnxnqjxfva .gt_font_normal {
  font-weight: normal;
}

#bnxnqjxfva .gt_font_bold {
  font-weight: bold;
}

#bnxnqjxfva .gt_font_italic {
  font-style: italic;
}

#bnxnqjxfva .gt_super {
  font-size: 65%;
}

#bnxnqjxfva .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bnxnqjxfva" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#hzapdvwoku .gt_table {
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

#hzapdvwoku .gt_heading {
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

#hzapdvwoku .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#hzapdvwoku .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#hzapdvwoku .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hzapdvwoku .gt_col_headings {
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

#hzapdvwoku .gt_col_heading {
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

#hzapdvwoku .gt_column_spanner_outer {
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

#hzapdvwoku .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hzapdvwoku .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hzapdvwoku .gt_column_spanner {
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

#hzapdvwoku .gt_group_heading {
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

#hzapdvwoku .gt_empty_group_heading {
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

#hzapdvwoku .gt_from_md > :first-child {
  margin-top: 0;
}

#hzapdvwoku .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hzapdvwoku .gt_row {
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

#hzapdvwoku .gt_stub {
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

#hzapdvwoku .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hzapdvwoku .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#hzapdvwoku .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hzapdvwoku .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hzapdvwoku .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hzapdvwoku .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hzapdvwoku .gt_footnotes {
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

#hzapdvwoku .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#hzapdvwoku .gt_sourcenotes {
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

#hzapdvwoku .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#hzapdvwoku .gt_left {
  text-align: left;
}

#hzapdvwoku .gt_center {
  text-align: center;
}

#hzapdvwoku .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hzapdvwoku .gt_font_normal {
  font-weight: normal;
}

#hzapdvwoku .gt_font_bold {
  font-weight: bold;
}

#hzapdvwoku .gt_font_italic {
  font-style: italic;
}

#hzapdvwoku .gt_super {
  font-size: 65%;
}

#hzapdvwoku .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="hzapdvwoku" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#jdxctknzrw .gt_table {
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

#jdxctknzrw .gt_heading {
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

#jdxctknzrw .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#jdxctknzrw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#jdxctknzrw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jdxctknzrw .gt_col_headings {
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

#jdxctknzrw .gt_col_heading {
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

#jdxctknzrw .gt_column_spanner_outer {
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

#jdxctknzrw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jdxctknzrw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jdxctknzrw .gt_column_spanner {
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

#jdxctknzrw .gt_group_heading {
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

#jdxctknzrw .gt_empty_group_heading {
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

#jdxctknzrw .gt_from_md > :first-child {
  margin-top: 0;
}

#jdxctknzrw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jdxctknzrw .gt_row {
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

#jdxctknzrw .gt_stub {
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

#jdxctknzrw .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jdxctknzrw .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#jdxctknzrw .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jdxctknzrw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jdxctknzrw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jdxctknzrw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jdxctknzrw .gt_footnotes {
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

#jdxctknzrw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#jdxctknzrw .gt_sourcenotes {
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

#jdxctknzrw .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#jdxctknzrw .gt_left {
  text-align: left;
}

#jdxctknzrw .gt_center {
  text-align: center;
}

#jdxctknzrw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jdxctknzrw .gt_font_normal {
  font-weight: normal;
}

#jdxctknzrw .gt_font_bold {
  font-weight: bold;
}

#jdxctknzrw .gt_font_italic {
  font-style: italic;
}

#jdxctknzrw .gt_super {
  font-size: 65%;
}

#jdxctknzrw .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jdxctknzrw" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#kpagjblrga .gt_table {
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

#kpagjblrga .gt_heading {
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

#kpagjblrga .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#kpagjblrga .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#kpagjblrga .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kpagjblrga .gt_col_headings {
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

#kpagjblrga .gt_col_heading {
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

#kpagjblrga .gt_column_spanner_outer {
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

#kpagjblrga .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kpagjblrga .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kpagjblrga .gt_column_spanner {
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

#kpagjblrga .gt_group_heading {
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

#kpagjblrga .gt_empty_group_heading {
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

#kpagjblrga .gt_from_md > :first-child {
  margin-top: 0;
}

#kpagjblrga .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kpagjblrga .gt_row {
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

#kpagjblrga .gt_stub {
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

#kpagjblrga .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kpagjblrga .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#kpagjblrga .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kpagjblrga .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kpagjblrga .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kpagjblrga .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kpagjblrga .gt_footnotes {
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

#kpagjblrga .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#kpagjblrga .gt_sourcenotes {
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

#kpagjblrga .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#kpagjblrga .gt_left {
  text-align: left;
}

#kpagjblrga .gt_center {
  text-align: center;
}

#kpagjblrga .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kpagjblrga .gt_font_normal {
  font-weight: normal;
}

#kpagjblrga .gt_font_bold {
  font-weight: bold;
}

#kpagjblrga .gt_font_italic {
  font-style: italic;
}

#kpagjblrga .gt_super {
  font-size: 65%;
}

#kpagjblrga .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kpagjblrga" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#kevyqtprzp .gt_table {
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

#kevyqtprzp .gt_heading {
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

#kevyqtprzp .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kevyqtprzp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#kevyqtprzp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kevyqtprzp .gt_col_headings {
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

#kevyqtprzp .gt_col_heading {
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

#kevyqtprzp .gt_column_spanner_outer {
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

#kevyqtprzp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kevyqtprzp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kevyqtprzp .gt_column_spanner {
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

#kevyqtprzp .gt_group_heading {
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

#kevyqtprzp .gt_empty_group_heading {
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

#kevyqtprzp .gt_from_md > :first-child {
  margin-top: 0;
}

#kevyqtprzp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kevyqtprzp .gt_row {
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

#kevyqtprzp .gt_stub {
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

#kevyqtprzp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kevyqtprzp .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#kevyqtprzp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kevyqtprzp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kevyqtprzp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kevyqtprzp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kevyqtprzp .gt_footnotes {
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

#kevyqtprzp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#kevyqtprzp .gt_sourcenotes {
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

#kevyqtprzp .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#kevyqtprzp .gt_left {
  text-align: left;
}

#kevyqtprzp .gt_center {
  text-align: center;
}

#kevyqtprzp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kevyqtprzp .gt_font_normal {
  font-weight: normal;
}

#kevyqtprzp .gt_font_bold {
  font-weight: bold;
}

#kevyqtprzp .gt_font_italic {
  font-style: italic;
}

#kevyqtprzp .gt_super {
  font-size: 65%;
}

#kevyqtprzp .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kevyqtprzp" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#gqeugefbqf .gt_table {
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

#gqeugefbqf .gt_heading {
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

#gqeugefbqf .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#gqeugefbqf .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#gqeugefbqf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gqeugefbqf .gt_col_headings {
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

#gqeugefbqf .gt_col_heading {
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

#gqeugefbqf .gt_column_spanner_outer {
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

#gqeugefbqf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gqeugefbqf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gqeugefbqf .gt_column_spanner {
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

#gqeugefbqf .gt_group_heading {
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

#gqeugefbqf .gt_empty_group_heading {
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

#gqeugefbqf .gt_from_md > :first-child {
  margin-top: 0;
}

#gqeugefbqf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gqeugefbqf .gt_row {
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

#gqeugefbqf .gt_stub {
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

#gqeugefbqf .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gqeugefbqf .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#gqeugefbqf .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gqeugefbqf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gqeugefbqf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gqeugefbqf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gqeugefbqf .gt_footnotes {
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

#gqeugefbqf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#gqeugefbqf .gt_sourcenotes {
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

#gqeugefbqf .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#gqeugefbqf .gt_left {
  text-align: left;
}

#gqeugefbqf .gt_center {
  text-align: center;
}

#gqeugefbqf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gqeugefbqf .gt_font_normal {
  font-weight: normal;
}

#gqeugefbqf .gt_font_bold {
  font-weight: bold;
}

#gqeugefbqf .gt_font_italic {
  font-style: italic;
}

#gqeugefbqf .gt_super {
  font-size: 65%;
}

#gqeugefbqf .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="gqeugefbqf" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#alpakejbgz .gt_table {
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

#alpakejbgz .gt_heading {
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

#alpakejbgz .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#alpakejbgz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#alpakejbgz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#alpakejbgz .gt_col_headings {
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

#alpakejbgz .gt_col_heading {
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

#alpakejbgz .gt_column_spanner_outer {
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

#alpakejbgz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#alpakejbgz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#alpakejbgz .gt_column_spanner {
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

#alpakejbgz .gt_group_heading {
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

#alpakejbgz .gt_empty_group_heading {
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

#alpakejbgz .gt_from_md > :first-child {
  margin-top: 0;
}

#alpakejbgz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#alpakejbgz .gt_row {
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

#alpakejbgz .gt_stub {
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

#alpakejbgz .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#alpakejbgz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#alpakejbgz .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#alpakejbgz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#alpakejbgz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#alpakejbgz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#alpakejbgz .gt_footnotes {
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

#alpakejbgz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#alpakejbgz .gt_sourcenotes {
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

#alpakejbgz .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#alpakejbgz .gt_left {
  text-align: left;
}

#alpakejbgz .gt_center {
  text-align: center;
}

#alpakejbgz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#alpakejbgz .gt_font_normal {
  font-weight: normal;
}

#alpakejbgz .gt_font_bold {
  font-weight: bold;
}

#alpakejbgz .gt_font_italic {
  font-style: italic;
}

#alpakejbgz .gt_super {
  font-size: 65%;
}

#alpakejbgz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="alpakejbgz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#cuidcyelon .gt_table {
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

#cuidcyelon .gt_heading {
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

#cuidcyelon .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#cuidcyelon .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#cuidcyelon .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cuidcyelon .gt_col_headings {
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

#cuidcyelon .gt_col_heading {
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

#cuidcyelon .gt_column_spanner_outer {
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

#cuidcyelon .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cuidcyelon .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cuidcyelon .gt_column_spanner {
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

#cuidcyelon .gt_group_heading {
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

#cuidcyelon .gt_empty_group_heading {
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

#cuidcyelon .gt_from_md > :first-child {
  margin-top: 0;
}

#cuidcyelon .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cuidcyelon .gt_row {
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

#cuidcyelon .gt_stub {
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

#cuidcyelon .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cuidcyelon .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#cuidcyelon .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cuidcyelon .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cuidcyelon .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cuidcyelon .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cuidcyelon .gt_footnotes {
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

#cuidcyelon .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#cuidcyelon .gt_sourcenotes {
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

#cuidcyelon .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#cuidcyelon .gt_left {
  text-align: left;
}

#cuidcyelon .gt_center {
  text-align: center;
}

#cuidcyelon .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cuidcyelon .gt_font_normal {
  font-weight: normal;
}

#cuidcyelon .gt_font_bold {
  font-weight: bold;
}

#cuidcyelon .gt_font_italic {
  font-style: italic;
}

#cuidcyelon .gt_super {
  font-size: 65%;
}

#cuidcyelon .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="cuidcyelon" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#cyhggawwco .gt_table {
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

#cyhggawwco .gt_heading {
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

#cyhggawwco .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#cyhggawwco .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#cyhggawwco .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cyhggawwco .gt_col_headings {
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

#cyhggawwco .gt_col_heading {
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

#cyhggawwco .gt_column_spanner_outer {
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

#cyhggawwco .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cyhggawwco .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cyhggawwco .gt_column_spanner {
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

#cyhggawwco .gt_group_heading {
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

#cyhggawwco .gt_empty_group_heading {
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

#cyhggawwco .gt_from_md > :first-child {
  margin-top: 0;
}

#cyhggawwco .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cyhggawwco .gt_row {
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

#cyhggawwco .gt_stub {
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

#cyhggawwco .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cyhggawwco .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#cyhggawwco .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cyhggawwco .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cyhggawwco .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cyhggawwco .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cyhggawwco .gt_footnotes {
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

#cyhggawwco .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#cyhggawwco .gt_sourcenotes {
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

#cyhggawwco .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#cyhggawwco .gt_left {
  text-align: left;
}

#cyhggawwco .gt_center {
  text-align: center;
}

#cyhggawwco .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cyhggawwco .gt_font_normal {
  font-weight: normal;
}

#cyhggawwco .gt_font_bold {
  font-weight: bold;
}

#cyhggawwco .gt_font_italic {
  font-style: italic;
}

#cyhggawwco .gt_super {
  font-size: 65%;
}

#cyhggawwco .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="cyhggawwco" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ghxcjgzszs .gt_table {
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

#ghxcjgzszs .gt_heading {
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

#ghxcjgzszs .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ghxcjgzszs .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ghxcjgzszs .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ghxcjgzszs .gt_col_headings {
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

#ghxcjgzszs .gt_col_heading {
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

#ghxcjgzszs .gt_column_spanner_outer {
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

#ghxcjgzszs .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ghxcjgzszs .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ghxcjgzszs .gt_column_spanner {
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

#ghxcjgzszs .gt_group_heading {
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

#ghxcjgzszs .gt_empty_group_heading {
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

#ghxcjgzszs .gt_from_md > :first-child {
  margin-top: 0;
}

#ghxcjgzszs .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ghxcjgzszs .gt_row {
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

#ghxcjgzszs .gt_stub {
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

#ghxcjgzszs .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ghxcjgzszs .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ghxcjgzszs .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ghxcjgzszs .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ghxcjgzszs .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ghxcjgzszs .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ghxcjgzszs .gt_footnotes {
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

#ghxcjgzszs .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ghxcjgzszs .gt_sourcenotes {
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

#ghxcjgzszs .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ghxcjgzszs .gt_left {
  text-align: left;
}

#ghxcjgzszs .gt_center {
  text-align: center;
}

#ghxcjgzszs .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ghxcjgzszs .gt_font_normal {
  font-weight: normal;
}

#ghxcjgzszs .gt_font_bold {
  font-weight: bold;
}

#ghxcjgzszs .gt_font_italic {
  font-style: italic;
}

#ghxcjgzszs .gt_super {
  font-size: 65%;
}

#ghxcjgzszs .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ghxcjgzszs" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#xypjpnqfws .gt_table {
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

#xypjpnqfws .gt_heading {
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

#xypjpnqfws .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xypjpnqfws .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xypjpnqfws .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xypjpnqfws .gt_col_headings {
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

#xypjpnqfws .gt_col_heading {
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

#xypjpnqfws .gt_column_spanner_outer {
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

#xypjpnqfws .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xypjpnqfws .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xypjpnqfws .gt_column_spanner {
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

#xypjpnqfws .gt_group_heading {
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

#xypjpnqfws .gt_empty_group_heading {
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

#xypjpnqfws .gt_from_md > :first-child {
  margin-top: 0;
}

#xypjpnqfws .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xypjpnqfws .gt_row {
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

#xypjpnqfws .gt_stub {
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

#xypjpnqfws .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xypjpnqfws .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#xypjpnqfws .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xypjpnqfws .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xypjpnqfws .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xypjpnqfws .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xypjpnqfws .gt_footnotes {
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

#xypjpnqfws .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#xypjpnqfws .gt_sourcenotes {
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

#xypjpnqfws .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#xypjpnqfws .gt_left {
  text-align: left;
}

#xypjpnqfws .gt_center {
  text-align: center;
}

#xypjpnqfws .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xypjpnqfws .gt_font_normal {
  font-weight: normal;
}

#xypjpnqfws .gt_font_bold {
  font-weight: bold;
}

#xypjpnqfws .gt_font_italic {
  font-style: italic;
}

#xypjpnqfws .gt_super {
  font-size: 65%;
}

#xypjpnqfws .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="xypjpnqfws" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#auhsqmpfsj .gt_table {
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

#auhsqmpfsj .gt_heading {
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

#auhsqmpfsj .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#auhsqmpfsj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#auhsqmpfsj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#auhsqmpfsj .gt_col_headings {
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

#auhsqmpfsj .gt_col_heading {
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

#auhsqmpfsj .gt_column_spanner_outer {
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

#auhsqmpfsj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#auhsqmpfsj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#auhsqmpfsj .gt_column_spanner {
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

#auhsqmpfsj .gt_group_heading {
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

#auhsqmpfsj .gt_empty_group_heading {
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

#auhsqmpfsj .gt_from_md > :first-child {
  margin-top: 0;
}

#auhsqmpfsj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#auhsqmpfsj .gt_row {
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

#auhsqmpfsj .gt_stub {
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

#auhsqmpfsj .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#auhsqmpfsj .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#auhsqmpfsj .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#auhsqmpfsj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#auhsqmpfsj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#auhsqmpfsj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#auhsqmpfsj .gt_footnotes {
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

#auhsqmpfsj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#auhsqmpfsj .gt_sourcenotes {
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

#auhsqmpfsj .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#auhsqmpfsj .gt_left {
  text-align: left;
}

#auhsqmpfsj .gt_center {
  text-align: center;
}

#auhsqmpfsj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#auhsqmpfsj .gt_font_normal {
  font-weight: normal;
}

#auhsqmpfsj .gt_font_bold {
  font-weight: bold;
}

#auhsqmpfsj .gt_font_italic {
  font-style: italic;
}

#auhsqmpfsj .gt_super {
  font-size: 65%;
}

#auhsqmpfsj .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="auhsqmpfsj" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#dsqvpljufa .gt_table {
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

#dsqvpljufa .gt_heading {
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

#dsqvpljufa .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#dsqvpljufa .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#dsqvpljufa .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dsqvpljufa .gt_col_headings {
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

#dsqvpljufa .gt_col_heading {
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

#dsqvpljufa .gt_column_spanner_outer {
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

#dsqvpljufa .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dsqvpljufa .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dsqvpljufa .gt_column_spanner {
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

#dsqvpljufa .gt_group_heading {
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

#dsqvpljufa .gt_empty_group_heading {
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

#dsqvpljufa .gt_from_md > :first-child {
  margin-top: 0;
}

#dsqvpljufa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dsqvpljufa .gt_row {
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

#dsqvpljufa .gt_stub {
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

#dsqvpljufa .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dsqvpljufa .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dsqvpljufa .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dsqvpljufa .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dsqvpljufa .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dsqvpljufa .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dsqvpljufa .gt_footnotes {
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

#dsqvpljufa .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dsqvpljufa .gt_sourcenotes {
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

#dsqvpljufa .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dsqvpljufa .gt_left {
  text-align: left;
}

#dsqvpljufa .gt_center {
  text-align: center;
}

#dsqvpljufa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dsqvpljufa .gt_font_normal {
  font-weight: normal;
}

#dsqvpljufa .gt_font_bold {
  font-weight: bold;
}

#dsqvpljufa .gt_font_italic {
  font-style: italic;
}

#dsqvpljufa .gt_super {
  font-size: 65%;
}

#dsqvpljufa .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dsqvpljufa" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#olgvyjione .gt_table {
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

#olgvyjione .gt_heading {
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

#olgvyjione .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#olgvyjione .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#olgvyjione .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#olgvyjione .gt_col_headings {
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

#olgvyjione .gt_col_heading {
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

#olgvyjione .gt_column_spanner_outer {
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

#olgvyjione .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#olgvyjione .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#olgvyjione .gt_column_spanner {
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

#olgvyjione .gt_group_heading {
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

#olgvyjione .gt_empty_group_heading {
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

#olgvyjione .gt_from_md > :first-child {
  margin-top: 0;
}

#olgvyjione .gt_from_md > :last-child {
  margin-bottom: 0;
}

#olgvyjione .gt_row {
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

#olgvyjione .gt_stub {
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

#olgvyjione .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#olgvyjione .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#olgvyjione .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#olgvyjione .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#olgvyjione .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#olgvyjione .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#olgvyjione .gt_footnotes {
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

#olgvyjione .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#olgvyjione .gt_sourcenotes {
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

#olgvyjione .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#olgvyjione .gt_left {
  text-align: left;
}

#olgvyjione .gt_center {
  text-align: center;
}

#olgvyjione .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#olgvyjione .gt_font_normal {
  font-weight: normal;
}

#olgvyjione .gt_font_bold {
  font-weight: bold;
}

#olgvyjione .gt_font_italic {
  font-style: italic;
}

#olgvyjione .gt_super {
  font-size: 65%;
}

#olgvyjione .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="olgvyjione" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#puyhuscqzu .gt_table {
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

#puyhuscqzu .gt_heading {
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

#puyhuscqzu .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#puyhuscqzu .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#puyhuscqzu .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#puyhuscqzu .gt_col_headings {
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

#puyhuscqzu .gt_col_heading {
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

#puyhuscqzu .gt_column_spanner_outer {
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

#puyhuscqzu .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#puyhuscqzu .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#puyhuscqzu .gt_column_spanner {
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

#puyhuscqzu .gt_group_heading {
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

#puyhuscqzu .gt_empty_group_heading {
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

#puyhuscqzu .gt_from_md > :first-child {
  margin-top: 0;
}

#puyhuscqzu .gt_from_md > :last-child {
  margin-bottom: 0;
}

#puyhuscqzu .gt_row {
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

#puyhuscqzu .gt_stub {
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

#puyhuscqzu .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#puyhuscqzu .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#puyhuscqzu .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#puyhuscqzu .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#puyhuscqzu .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#puyhuscqzu .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#puyhuscqzu .gt_footnotes {
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

#puyhuscqzu .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#puyhuscqzu .gt_sourcenotes {
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

#puyhuscqzu .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#puyhuscqzu .gt_left {
  text-align: left;
}

#puyhuscqzu .gt_center {
  text-align: center;
}

#puyhuscqzu .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#puyhuscqzu .gt_font_normal {
  font-weight: normal;
}

#puyhuscqzu .gt_font_bold {
  font-weight: bold;
}

#puyhuscqzu .gt_font_italic {
  font-style: italic;
}

#puyhuscqzu .gt_super {
  font-size: 65%;
}

#puyhuscqzu .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="puyhuscqzu" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ltdaqssxvf .gt_table {
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

#ltdaqssxvf .gt_heading {
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

#ltdaqssxvf .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#ltdaqssxvf .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#ltdaqssxvf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ltdaqssxvf .gt_col_headings {
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

#ltdaqssxvf .gt_col_heading {
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

#ltdaqssxvf .gt_column_spanner_outer {
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

#ltdaqssxvf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ltdaqssxvf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ltdaqssxvf .gt_column_spanner {
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

#ltdaqssxvf .gt_group_heading {
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

#ltdaqssxvf .gt_empty_group_heading {
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

#ltdaqssxvf .gt_from_md > :first-child {
  margin-top: 0;
}

#ltdaqssxvf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ltdaqssxvf .gt_row {
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

#ltdaqssxvf .gt_stub {
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

#ltdaqssxvf .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ltdaqssxvf .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ltdaqssxvf .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ltdaqssxvf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ltdaqssxvf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ltdaqssxvf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ltdaqssxvf .gt_footnotes {
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

#ltdaqssxvf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ltdaqssxvf .gt_sourcenotes {
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

#ltdaqssxvf .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ltdaqssxvf .gt_left {
  text-align: left;
}

#ltdaqssxvf .gt_center {
  text-align: center;
}

#ltdaqssxvf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ltdaqssxvf .gt_font_normal {
  font-weight: normal;
}

#ltdaqssxvf .gt_font_bold {
  font-weight: bold;
}

#ltdaqssxvf .gt_font_italic {
  font-style: italic;
}

#ltdaqssxvf .gt_super {
  font-size: 65%;
}

#ltdaqssxvf .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ltdaqssxvf" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#czpymrgmwq .gt_table {
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

#czpymrgmwq .gt_heading {
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

#czpymrgmwq .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#czpymrgmwq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#czpymrgmwq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#czpymrgmwq .gt_col_headings {
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

#czpymrgmwq .gt_col_heading {
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

#czpymrgmwq .gt_column_spanner_outer {
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

#czpymrgmwq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#czpymrgmwq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#czpymrgmwq .gt_column_spanner {
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

#czpymrgmwq .gt_group_heading {
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

#czpymrgmwq .gt_empty_group_heading {
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

#czpymrgmwq .gt_from_md > :first-child {
  margin-top: 0;
}

#czpymrgmwq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#czpymrgmwq .gt_row {
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

#czpymrgmwq .gt_stub {
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

#czpymrgmwq .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#czpymrgmwq .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#czpymrgmwq .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#czpymrgmwq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#czpymrgmwq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#czpymrgmwq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#czpymrgmwq .gt_footnotes {
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

#czpymrgmwq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#czpymrgmwq .gt_sourcenotes {
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

#czpymrgmwq .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#czpymrgmwq .gt_left {
  text-align: left;
}

#czpymrgmwq .gt_center {
  text-align: center;
}

#czpymrgmwq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#czpymrgmwq .gt_font_normal {
  font-weight: normal;
}

#czpymrgmwq .gt_font_bold {
  font-weight: bold;
}

#czpymrgmwq .gt_font_italic {
  font-style: italic;
}

#czpymrgmwq .gt_super {
  font-size: 65%;
}

#czpymrgmwq .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="czpymrgmwq" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#xjmteejpul .gt_table {
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

#xjmteejpul .gt_heading {
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

#xjmteejpul .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#xjmteejpul .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#xjmteejpul .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xjmteejpul .gt_col_headings {
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

#xjmteejpul .gt_col_heading {
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

#xjmteejpul .gt_column_spanner_outer {
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

#xjmteejpul .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xjmteejpul .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xjmteejpul .gt_column_spanner {
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

#xjmteejpul .gt_group_heading {
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

#xjmteejpul .gt_empty_group_heading {
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

#xjmteejpul .gt_from_md > :first-child {
  margin-top: 0;
}

#xjmteejpul .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xjmteejpul .gt_row {
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

#xjmteejpul .gt_stub {
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

#xjmteejpul .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xjmteejpul .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#xjmteejpul .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xjmteejpul .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xjmteejpul .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xjmteejpul .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xjmteejpul .gt_footnotes {
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

#xjmteejpul .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#xjmteejpul .gt_sourcenotes {
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

#xjmteejpul .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#xjmteejpul .gt_left {
  text-align: left;
}

#xjmteejpul .gt_center {
  text-align: center;
}

#xjmteejpul .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xjmteejpul .gt_font_normal {
  font-weight: normal;
}

#xjmteejpul .gt_font_bold {
  font-weight: bold;
}

#xjmteejpul .gt_font_italic {
  font-style: italic;
}

#xjmteejpul .gt_super {
  font-size: 65%;
}

#xjmteejpul .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="xjmteejpul" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#lxmwpkwbkn .gt_table {
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

#lxmwpkwbkn .gt_heading {
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

#lxmwpkwbkn .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#lxmwpkwbkn .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#lxmwpkwbkn .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lxmwpkwbkn .gt_col_headings {
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

#lxmwpkwbkn .gt_col_heading {
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

#lxmwpkwbkn .gt_column_spanner_outer {
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

#lxmwpkwbkn .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#lxmwpkwbkn .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#lxmwpkwbkn .gt_column_spanner {
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

#lxmwpkwbkn .gt_group_heading {
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

#lxmwpkwbkn .gt_empty_group_heading {
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

#lxmwpkwbkn .gt_from_md > :first-child {
  margin-top: 0;
}

#lxmwpkwbkn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#lxmwpkwbkn .gt_row {
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

#lxmwpkwbkn .gt_stub {
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

#lxmwpkwbkn .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lxmwpkwbkn .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#lxmwpkwbkn .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lxmwpkwbkn .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#lxmwpkwbkn .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#lxmwpkwbkn .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lxmwpkwbkn .gt_footnotes {
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

#lxmwpkwbkn .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#lxmwpkwbkn .gt_sourcenotes {
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

#lxmwpkwbkn .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#lxmwpkwbkn .gt_left {
  text-align: left;
}

#lxmwpkwbkn .gt_center {
  text-align: center;
}

#lxmwpkwbkn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#lxmwpkwbkn .gt_font_normal {
  font-weight: normal;
}

#lxmwpkwbkn .gt_font_bold {
  font-weight: bold;
}

#lxmwpkwbkn .gt_font_italic {
  font-style: italic;
}

#lxmwpkwbkn .gt_super {
  font-size: 65%;
}

#lxmwpkwbkn .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="lxmwpkwbkn" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#dfzcyxpwxi .gt_table {
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

#dfzcyxpwxi .gt_heading {
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

#dfzcyxpwxi .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#dfzcyxpwxi .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#dfzcyxpwxi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dfzcyxpwxi .gt_col_headings {
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

#dfzcyxpwxi .gt_col_heading {
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

#dfzcyxpwxi .gt_column_spanner_outer {
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

#dfzcyxpwxi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dfzcyxpwxi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dfzcyxpwxi .gt_column_spanner {
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

#dfzcyxpwxi .gt_group_heading {
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

#dfzcyxpwxi .gt_empty_group_heading {
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

#dfzcyxpwxi .gt_from_md > :first-child {
  margin-top: 0;
}

#dfzcyxpwxi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dfzcyxpwxi .gt_row {
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

#dfzcyxpwxi .gt_stub {
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

#dfzcyxpwxi .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dfzcyxpwxi .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dfzcyxpwxi .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dfzcyxpwxi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dfzcyxpwxi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dfzcyxpwxi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dfzcyxpwxi .gt_footnotes {
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

#dfzcyxpwxi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dfzcyxpwxi .gt_sourcenotes {
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

#dfzcyxpwxi .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dfzcyxpwxi .gt_left {
  text-align: left;
}

#dfzcyxpwxi .gt_center {
  text-align: center;
}

#dfzcyxpwxi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dfzcyxpwxi .gt_font_normal {
  font-weight: normal;
}

#dfzcyxpwxi .gt_font_bold {
  font-weight: bold;
}

#dfzcyxpwxi .gt_font_italic {
  font-style: italic;
}

#dfzcyxpwxi .gt_super {
  font-size: 65%;
}

#dfzcyxpwxi .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dfzcyxpwxi" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#rmiuskfphc .gt_table {
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

#rmiuskfphc .gt_heading {
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

#rmiuskfphc .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#rmiuskfphc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#rmiuskfphc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmiuskfphc .gt_col_headings {
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

#rmiuskfphc .gt_col_heading {
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

#rmiuskfphc .gt_column_spanner_outer {
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

#rmiuskfphc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rmiuskfphc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rmiuskfphc .gt_column_spanner {
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

#rmiuskfphc .gt_group_heading {
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

#rmiuskfphc .gt_empty_group_heading {
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

#rmiuskfphc .gt_from_md > :first-child {
  margin-top: 0;
}

#rmiuskfphc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rmiuskfphc .gt_row {
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

#rmiuskfphc .gt_stub {
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

#rmiuskfphc .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmiuskfphc .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#rmiuskfphc .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmiuskfphc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rmiuskfphc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rmiuskfphc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmiuskfphc .gt_footnotes {
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

#rmiuskfphc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#rmiuskfphc .gt_sourcenotes {
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

#rmiuskfphc .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#rmiuskfphc .gt_left {
  text-align: left;
}

#rmiuskfphc .gt_center {
  text-align: center;
}

#rmiuskfphc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rmiuskfphc .gt_font_normal {
  font-weight: normal;
}

#rmiuskfphc .gt_font_bold {
  font-weight: bold;
}

#rmiuskfphc .gt_font_italic {
  font-style: italic;
}

#rmiuskfphc .gt_super {
  font-size: 65%;
}

#rmiuskfphc .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="rmiuskfphc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#bdrzslmfft .gt_table {
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

#bdrzslmfft .gt_heading {
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

#bdrzslmfft .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#bdrzslmfft .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#bdrzslmfft .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bdrzslmfft .gt_col_headings {
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

#bdrzslmfft .gt_col_heading {
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

#bdrzslmfft .gt_column_spanner_outer {
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

#bdrzslmfft .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bdrzslmfft .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bdrzslmfft .gt_column_spanner {
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

#bdrzslmfft .gt_group_heading {
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

#bdrzslmfft .gt_empty_group_heading {
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

#bdrzslmfft .gt_from_md > :first-child {
  margin-top: 0;
}

#bdrzslmfft .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bdrzslmfft .gt_row {
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

#bdrzslmfft .gt_stub {
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

#bdrzslmfft .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bdrzslmfft .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#bdrzslmfft .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bdrzslmfft .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bdrzslmfft .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bdrzslmfft .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bdrzslmfft .gt_footnotes {
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

#bdrzslmfft .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#bdrzslmfft .gt_sourcenotes {
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

#bdrzslmfft .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#bdrzslmfft .gt_left {
  text-align: left;
}

#bdrzslmfft .gt_center {
  text-align: center;
}

#bdrzslmfft .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bdrzslmfft .gt_font_normal {
  font-weight: normal;
}

#bdrzslmfft .gt_font_bold {
  font-weight: bold;
}

#bdrzslmfft .gt_font_italic {
  font-style: italic;
}

#bdrzslmfft .gt_super {
  font-size: 65%;
}

#bdrzslmfft .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bdrzslmfft" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#mbhxlhsrje .gt_table {
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

#mbhxlhsrje .gt_heading {
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

#mbhxlhsrje .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mbhxlhsrje .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mbhxlhsrje .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mbhxlhsrje .gt_col_headings {
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

#mbhxlhsrje .gt_col_heading {
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

#mbhxlhsrje .gt_column_spanner_outer {
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

#mbhxlhsrje .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mbhxlhsrje .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mbhxlhsrje .gt_column_spanner {
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

#mbhxlhsrje .gt_group_heading {
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

#mbhxlhsrje .gt_empty_group_heading {
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

#mbhxlhsrje .gt_from_md > :first-child {
  margin-top: 0;
}

#mbhxlhsrje .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mbhxlhsrje .gt_row {
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

#mbhxlhsrje .gt_stub {
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

#mbhxlhsrje .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mbhxlhsrje .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#mbhxlhsrje .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mbhxlhsrje .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mbhxlhsrje .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mbhxlhsrje .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mbhxlhsrje .gt_footnotes {
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

#mbhxlhsrje .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#mbhxlhsrje .gt_sourcenotes {
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

#mbhxlhsrje .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#mbhxlhsrje .gt_left {
  text-align: left;
}

#mbhxlhsrje .gt_center {
  text-align: center;
}

#mbhxlhsrje .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mbhxlhsrje .gt_font_normal {
  font-weight: normal;
}

#mbhxlhsrje .gt_font_bold {
  font-weight: bold;
}

#mbhxlhsrje .gt_font_italic {
  font-style: italic;
}

#mbhxlhsrje .gt_super {
  font-size: 65%;
}

#mbhxlhsrje .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mbhxlhsrje" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ltzgrqwkbh .gt_table {
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

#ltzgrqwkbh .gt_heading {
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

#ltzgrqwkbh .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#ltzgrqwkbh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#ltzgrqwkbh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ltzgrqwkbh .gt_col_headings {
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

#ltzgrqwkbh .gt_col_heading {
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

#ltzgrqwkbh .gt_column_spanner_outer {
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

#ltzgrqwkbh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ltzgrqwkbh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ltzgrqwkbh .gt_column_spanner {
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

#ltzgrqwkbh .gt_group_heading {
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

#ltzgrqwkbh .gt_empty_group_heading {
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

#ltzgrqwkbh .gt_from_md > :first-child {
  margin-top: 0;
}

#ltzgrqwkbh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ltzgrqwkbh .gt_row {
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

#ltzgrqwkbh .gt_stub {
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

#ltzgrqwkbh .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ltzgrqwkbh .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ltzgrqwkbh .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ltzgrqwkbh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ltzgrqwkbh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ltzgrqwkbh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ltzgrqwkbh .gt_footnotes {
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

#ltzgrqwkbh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ltzgrqwkbh .gt_sourcenotes {
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

#ltzgrqwkbh .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ltzgrqwkbh .gt_left {
  text-align: left;
}

#ltzgrqwkbh .gt_center {
  text-align: center;
}

#ltzgrqwkbh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ltzgrqwkbh .gt_font_normal {
  font-weight: normal;
}

#ltzgrqwkbh .gt_font_bold {
  font-weight: bold;
}

#ltzgrqwkbh .gt_font_italic {
  font-style: italic;
}

#ltzgrqwkbh .gt_super {
  font-size: 65%;
}

#ltzgrqwkbh .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ltzgrqwkbh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#zgrsozjwbq .gt_table {
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

#zgrsozjwbq .gt_heading {
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

#zgrsozjwbq .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#zgrsozjwbq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#zgrsozjwbq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zgrsozjwbq .gt_col_headings {
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

#zgrsozjwbq .gt_col_heading {
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

#zgrsozjwbq .gt_column_spanner_outer {
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

#zgrsozjwbq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zgrsozjwbq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zgrsozjwbq .gt_column_spanner {
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

#zgrsozjwbq .gt_group_heading {
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

#zgrsozjwbq .gt_empty_group_heading {
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

#zgrsozjwbq .gt_from_md > :first-child {
  margin-top: 0;
}

#zgrsozjwbq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zgrsozjwbq .gt_row {
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

#zgrsozjwbq .gt_stub {
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

#zgrsozjwbq .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zgrsozjwbq .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#zgrsozjwbq .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zgrsozjwbq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zgrsozjwbq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zgrsozjwbq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zgrsozjwbq .gt_footnotes {
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

#zgrsozjwbq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#zgrsozjwbq .gt_sourcenotes {
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

#zgrsozjwbq .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#zgrsozjwbq .gt_left {
  text-align: left;
}

#zgrsozjwbq .gt_center {
  text-align: center;
}

#zgrsozjwbq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zgrsozjwbq .gt_font_normal {
  font-weight: normal;
}

#zgrsozjwbq .gt_font_bold {
  font-weight: bold;
}

#zgrsozjwbq .gt_font_italic {
  font-style: italic;
}

#zgrsozjwbq .gt_super {
  font-size: 65%;
}

#zgrsozjwbq .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zgrsozjwbq" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#nibatylyho .gt_table {
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

#nibatylyho .gt_heading {
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

#nibatylyho .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#nibatylyho .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#nibatylyho .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nibatylyho .gt_col_headings {
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

#nibatylyho .gt_col_heading {
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

#nibatylyho .gt_column_spanner_outer {
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

#nibatylyho .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nibatylyho .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nibatylyho .gt_column_spanner {
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

#nibatylyho .gt_group_heading {
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

#nibatylyho .gt_empty_group_heading {
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

#nibatylyho .gt_from_md > :first-child {
  margin-top: 0;
}

#nibatylyho .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nibatylyho .gt_row {
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

#nibatylyho .gt_stub {
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

#nibatylyho .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nibatylyho .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#nibatylyho .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nibatylyho .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nibatylyho .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nibatylyho .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nibatylyho .gt_footnotes {
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

#nibatylyho .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#nibatylyho .gt_sourcenotes {
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

#nibatylyho .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#nibatylyho .gt_left {
  text-align: left;
}

#nibatylyho .gt_center {
  text-align: center;
}

#nibatylyho .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nibatylyho .gt_font_normal {
  font-weight: normal;
}

#nibatylyho .gt_font_bold {
  font-weight: bold;
}

#nibatylyho .gt_font_italic {
  font-style: italic;
}

#nibatylyho .gt_super {
  font-size: 65%;
}

#nibatylyho .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="nibatylyho" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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
