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

#dxwjoqgarv .gt_table {
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

#dxwjoqgarv .gt_heading {
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

#dxwjoqgarv .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#dxwjoqgarv .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#dxwjoqgarv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dxwjoqgarv .gt_col_headings {
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

#dxwjoqgarv .gt_col_heading {
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

#dxwjoqgarv .gt_column_spanner_outer {
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

#dxwjoqgarv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dxwjoqgarv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dxwjoqgarv .gt_column_spanner {
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

#dxwjoqgarv .gt_group_heading {
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

#dxwjoqgarv .gt_empty_group_heading {
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

#dxwjoqgarv .gt_from_md > :first-child {
  margin-top: 0;
}

#dxwjoqgarv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dxwjoqgarv .gt_row {
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

#dxwjoqgarv .gt_stub {
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

#dxwjoqgarv .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dxwjoqgarv .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dxwjoqgarv .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dxwjoqgarv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dxwjoqgarv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dxwjoqgarv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dxwjoqgarv .gt_footnotes {
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

#dxwjoqgarv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dxwjoqgarv .gt_sourcenotes {
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

#dxwjoqgarv .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dxwjoqgarv .gt_left {
  text-align: left;
}

#dxwjoqgarv .gt_center {
  text-align: center;
}

#dxwjoqgarv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dxwjoqgarv .gt_font_normal {
  font-weight: normal;
}

#dxwjoqgarv .gt_font_bold {
  font-weight: bold;
}

#dxwjoqgarv .gt_font_italic {
  font-style: italic;
}

#dxwjoqgarv .gt_super {
  font-size: 65%;
}

#dxwjoqgarv .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dxwjoqgarv" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#kylxerixju .gt_table {
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

#kylxerixju .gt_heading {
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

#kylxerixju .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#kylxerixju .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#kylxerixju .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kylxerixju .gt_col_headings {
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

#kylxerixju .gt_col_heading {
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

#kylxerixju .gt_column_spanner_outer {
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

#kylxerixju .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kylxerixju .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kylxerixju .gt_column_spanner {
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

#kylxerixju .gt_group_heading {
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

#kylxerixju .gt_empty_group_heading {
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

#kylxerixju .gt_from_md > :first-child {
  margin-top: 0;
}

#kylxerixju .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kylxerixju .gt_row {
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

#kylxerixju .gt_stub {
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

#kylxerixju .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kylxerixju .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#kylxerixju .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kylxerixju .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kylxerixju .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kylxerixju .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kylxerixju .gt_footnotes {
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

#kylxerixju .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#kylxerixju .gt_sourcenotes {
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

#kylxerixju .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#kylxerixju .gt_left {
  text-align: left;
}

#kylxerixju .gt_center {
  text-align: center;
}

#kylxerixju .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kylxerixju .gt_font_normal {
  font-weight: normal;
}

#kylxerixju .gt_font_bold {
  font-weight: bold;
}

#kylxerixju .gt_font_italic {
  font-style: italic;
}

#kylxerixju .gt_super {
  font-size: 65%;
}

#kylxerixju .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kylxerixju" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#zrfspvfdyi .gt_table {
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

#zrfspvfdyi .gt_heading {
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

#zrfspvfdyi .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zrfspvfdyi .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zrfspvfdyi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zrfspvfdyi .gt_col_headings {
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

#zrfspvfdyi .gt_col_heading {
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

#zrfspvfdyi .gt_column_spanner_outer {
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

#zrfspvfdyi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zrfspvfdyi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zrfspvfdyi .gt_column_spanner {
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

#zrfspvfdyi .gt_group_heading {
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

#zrfspvfdyi .gt_empty_group_heading {
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

#zrfspvfdyi .gt_from_md > :first-child {
  margin-top: 0;
}

#zrfspvfdyi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zrfspvfdyi .gt_row {
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

#zrfspvfdyi .gt_stub {
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

#zrfspvfdyi .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zrfspvfdyi .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#zrfspvfdyi .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zrfspvfdyi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zrfspvfdyi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zrfspvfdyi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zrfspvfdyi .gt_footnotes {
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

#zrfspvfdyi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#zrfspvfdyi .gt_sourcenotes {
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

#zrfspvfdyi .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#zrfspvfdyi .gt_left {
  text-align: left;
}

#zrfspvfdyi .gt_center {
  text-align: center;
}

#zrfspvfdyi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zrfspvfdyi .gt_font_normal {
  font-weight: normal;
}

#zrfspvfdyi .gt_font_bold {
  font-weight: bold;
}

#zrfspvfdyi .gt_font_italic {
  font-style: italic;
}

#zrfspvfdyi .gt_super {
  font-size: 65%;
}

#zrfspvfdyi .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zrfspvfdyi" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#bkkbxsfrjx .gt_table {
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

#bkkbxsfrjx .gt_heading {
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

#bkkbxsfrjx .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#bkkbxsfrjx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#bkkbxsfrjx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bkkbxsfrjx .gt_col_headings {
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

#bkkbxsfrjx .gt_col_heading {
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

#bkkbxsfrjx .gt_column_spanner_outer {
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

#bkkbxsfrjx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bkkbxsfrjx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bkkbxsfrjx .gt_column_spanner {
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

#bkkbxsfrjx .gt_group_heading {
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

#bkkbxsfrjx .gt_empty_group_heading {
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

#bkkbxsfrjx .gt_from_md > :first-child {
  margin-top: 0;
}

#bkkbxsfrjx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bkkbxsfrjx .gt_row {
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

#bkkbxsfrjx .gt_stub {
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

#bkkbxsfrjx .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkkbxsfrjx .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#bkkbxsfrjx .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkkbxsfrjx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bkkbxsfrjx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bkkbxsfrjx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bkkbxsfrjx .gt_footnotes {
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

#bkkbxsfrjx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#bkkbxsfrjx .gt_sourcenotes {
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

#bkkbxsfrjx .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#bkkbxsfrjx .gt_left {
  text-align: left;
}

#bkkbxsfrjx .gt_center {
  text-align: center;
}

#bkkbxsfrjx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bkkbxsfrjx .gt_font_normal {
  font-weight: normal;
}

#bkkbxsfrjx .gt_font_bold {
  font-weight: bold;
}

#bkkbxsfrjx .gt_font_italic {
  font-style: italic;
}

#bkkbxsfrjx .gt_super {
  font-size: 65%;
}

#bkkbxsfrjx .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bkkbxsfrjx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#hnpeyhxkzz .gt_table {
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

#hnpeyhxkzz .gt_heading {
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

#hnpeyhxkzz .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#hnpeyhxkzz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#hnpeyhxkzz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hnpeyhxkzz .gt_col_headings {
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

#hnpeyhxkzz .gt_col_heading {
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

#hnpeyhxkzz .gt_column_spanner_outer {
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

#hnpeyhxkzz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hnpeyhxkzz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hnpeyhxkzz .gt_column_spanner {
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

#hnpeyhxkzz .gt_group_heading {
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

#hnpeyhxkzz .gt_empty_group_heading {
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

#hnpeyhxkzz .gt_from_md > :first-child {
  margin-top: 0;
}

#hnpeyhxkzz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hnpeyhxkzz .gt_row {
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

#hnpeyhxkzz .gt_stub {
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

#hnpeyhxkzz .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hnpeyhxkzz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#hnpeyhxkzz .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hnpeyhxkzz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hnpeyhxkzz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hnpeyhxkzz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hnpeyhxkzz .gt_footnotes {
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

#hnpeyhxkzz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#hnpeyhxkzz .gt_sourcenotes {
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

#hnpeyhxkzz .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#hnpeyhxkzz .gt_left {
  text-align: left;
}

#hnpeyhxkzz .gt_center {
  text-align: center;
}

#hnpeyhxkzz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hnpeyhxkzz .gt_font_normal {
  font-weight: normal;
}

#hnpeyhxkzz .gt_font_bold {
  font-weight: bold;
}

#hnpeyhxkzz .gt_font_italic {
  font-style: italic;
}

#hnpeyhxkzz .gt_super {
  font-size: 65%;
}

#hnpeyhxkzz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="hnpeyhxkzz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#yjfzvbhbrt .gt_table {
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

#yjfzvbhbrt .gt_heading {
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

#yjfzvbhbrt .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#yjfzvbhbrt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#yjfzvbhbrt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yjfzvbhbrt .gt_col_headings {
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

#yjfzvbhbrt .gt_col_heading {
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

#yjfzvbhbrt .gt_column_spanner_outer {
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

#yjfzvbhbrt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yjfzvbhbrt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yjfzvbhbrt .gt_column_spanner {
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

#yjfzvbhbrt .gt_group_heading {
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

#yjfzvbhbrt .gt_empty_group_heading {
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

#yjfzvbhbrt .gt_from_md > :first-child {
  margin-top: 0;
}

#yjfzvbhbrt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yjfzvbhbrt .gt_row {
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

#yjfzvbhbrt .gt_stub {
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

#yjfzvbhbrt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yjfzvbhbrt .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#yjfzvbhbrt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yjfzvbhbrt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yjfzvbhbrt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yjfzvbhbrt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yjfzvbhbrt .gt_footnotes {
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

#yjfzvbhbrt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#yjfzvbhbrt .gt_sourcenotes {
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

#yjfzvbhbrt .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#yjfzvbhbrt .gt_left {
  text-align: left;
}

#yjfzvbhbrt .gt_center {
  text-align: center;
}

#yjfzvbhbrt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yjfzvbhbrt .gt_font_normal {
  font-weight: normal;
}

#yjfzvbhbrt .gt_font_bold {
  font-weight: bold;
}

#yjfzvbhbrt .gt_font_italic {
  font-style: italic;
}

#yjfzvbhbrt .gt_super {
  font-size: 65%;
}

#yjfzvbhbrt .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="yjfzvbhbrt" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#zqeyygvfyb .gt_table {
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

#zqeyygvfyb .gt_heading {
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

#zqeyygvfyb .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#zqeyygvfyb .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#zqeyygvfyb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqeyygvfyb .gt_col_headings {
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

#zqeyygvfyb .gt_col_heading {
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

#zqeyygvfyb .gt_column_spanner_outer {
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

#zqeyygvfyb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zqeyygvfyb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zqeyygvfyb .gt_column_spanner {
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

#zqeyygvfyb .gt_group_heading {
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

#zqeyygvfyb .gt_empty_group_heading {
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

#zqeyygvfyb .gt_from_md > :first-child {
  margin-top: 0;
}

#zqeyygvfyb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zqeyygvfyb .gt_row {
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

#zqeyygvfyb .gt_stub {
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

#zqeyygvfyb .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqeyygvfyb .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#zqeyygvfyb .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqeyygvfyb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zqeyygvfyb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zqeyygvfyb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqeyygvfyb .gt_footnotes {
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

#zqeyygvfyb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#zqeyygvfyb .gt_sourcenotes {
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

#zqeyygvfyb .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#zqeyygvfyb .gt_left {
  text-align: left;
}

#zqeyygvfyb .gt_center {
  text-align: center;
}

#zqeyygvfyb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zqeyygvfyb .gt_font_normal {
  font-weight: normal;
}

#zqeyygvfyb .gt_font_bold {
  font-weight: bold;
}

#zqeyygvfyb .gt_font_italic {
  font-style: italic;
}

#zqeyygvfyb .gt_super {
  font-size: 65%;
}

#zqeyygvfyb .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zqeyygvfyb" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ohhmfjrsih .gt_table {
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

#ohhmfjrsih .gt_heading {
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

#ohhmfjrsih .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ohhmfjrsih .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ohhmfjrsih .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ohhmfjrsih .gt_col_headings {
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

#ohhmfjrsih .gt_col_heading {
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

#ohhmfjrsih .gt_column_spanner_outer {
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

#ohhmfjrsih .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ohhmfjrsih .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ohhmfjrsih .gt_column_spanner {
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

#ohhmfjrsih .gt_group_heading {
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

#ohhmfjrsih .gt_empty_group_heading {
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

#ohhmfjrsih .gt_from_md > :first-child {
  margin-top: 0;
}

#ohhmfjrsih .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ohhmfjrsih .gt_row {
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

#ohhmfjrsih .gt_stub {
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

#ohhmfjrsih .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ohhmfjrsih .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ohhmfjrsih .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ohhmfjrsih .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ohhmfjrsih .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ohhmfjrsih .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ohhmfjrsih .gt_footnotes {
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

#ohhmfjrsih .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ohhmfjrsih .gt_sourcenotes {
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

#ohhmfjrsih .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ohhmfjrsih .gt_left {
  text-align: left;
}

#ohhmfjrsih .gt_center {
  text-align: center;
}

#ohhmfjrsih .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ohhmfjrsih .gt_font_normal {
  font-weight: normal;
}

#ohhmfjrsih .gt_font_bold {
  font-weight: bold;
}

#ohhmfjrsih .gt_font_italic {
  font-style: italic;
}

#ohhmfjrsih .gt_super {
  font-size: 65%;
}

#ohhmfjrsih .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ohhmfjrsih" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#mumaeqwfyp .gt_table {
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

#mumaeqwfyp .gt_heading {
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

#mumaeqwfyp .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mumaeqwfyp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mumaeqwfyp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mumaeqwfyp .gt_col_headings {
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

#mumaeqwfyp .gt_col_heading {
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

#mumaeqwfyp .gt_column_spanner_outer {
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

#mumaeqwfyp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mumaeqwfyp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mumaeqwfyp .gt_column_spanner {
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

#mumaeqwfyp .gt_group_heading {
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

#mumaeqwfyp .gt_empty_group_heading {
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

#mumaeqwfyp .gt_from_md > :first-child {
  margin-top: 0;
}

#mumaeqwfyp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mumaeqwfyp .gt_row {
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

#mumaeqwfyp .gt_stub {
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

#mumaeqwfyp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mumaeqwfyp .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#mumaeqwfyp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mumaeqwfyp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mumaeqwfyp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mumaeqwfyp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mumaeqwfyp .gt_footnotes {
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

#mumaeqwfyp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#mumaeqwfyp .gt_sourcenotes {
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

#mumaeqwfyp .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#mumaeqwfyp .gt_left {
  text-align: left;
}

#mumaeqwfyp .gt_center {
  text-align: center;
}

#mumaeqwfyp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mumaeqwfyp .gt_font_normal {
  font-weight: normal;
}

#mumaeqwfyp .gt_font_bold {
  font-weight: bold;
}

#mumaeqwfyp .gt_font_italic {
  font-style: italic;
}

#mumaeqwfyp .gt_super {
  font-size: 65%;
}

#mumaeqwfyp .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mumaeqwfyp" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#bgdfvcblvp .gt_table {
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

#bgdfvcblvp .gt_heading {
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

#bgdfvcblvp .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#bgdfvcblvp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#bgdfvcblvp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bgdfvcblvp .gt_col_headings {
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

#bgdfvcblvp .gt_col_heading {
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

#bgdfvcblvp .gt_column_spanner_outer {
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

#bgdfvcblvp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bgdfvcblvp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bgdfvcblvp .gt_column_spanner {
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

#bgdfvcblvp .gt_group_heading {
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

#bgdfvcblvp .gt_empty_group_heading {
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

#bgdfvcblvp .gt_from_md > :first-child {
  margin-top: 0;
}

#bgdfvcblvp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bgdfvcblvp .gt_row {
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

#bgdfvcblvp .gt_stub {
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

#bgdfvcblvp .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bgdfvcblvp .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#bgdfvcblvp .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bgdfvcblvp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bgdfvcblvp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bgdfvcblvp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bgdfvcblvp .gt_footnotes {
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

#bgdfvcblvp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#bgdfvcblvp .gt_sourcenotes {
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

#bgdfvcblvp .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#bgdfvcblvp .gt_left {
  text-align: left;
}

#bgdfvcblvp .gt_center {
  text-align: center;
}

#bgdfvcblvp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bgdfvcblvp .gt_font_normal {
  font-weight: normal;
}

#bgdfvcblvp .gt_font_bold {
  font-weight: bold;
}

#bgdfvcblvp .gt_font_italic {
  font-style: italic;
}

#bgdfvcblvp .gt_super {
  font-size: 65%;
}

#bgdfvcblvp .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bgdfvcblvp" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#qcytdewizz .gt_table {
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

#qcytdewizz .gt_heading {
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

#qcytdewizz .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#qcytdewizz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#qcytdewizz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qcytdewizz .gt_col_headings {
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

#qcytdewizz .gt_col_heading {
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

#qcytdewizz .gt_column_spanner_outer {
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

#qcytdewizz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qcytdewizz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qcytdewizz .gt_column_spanner {
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

#qcytdewizz .gt_group_heading {
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

#qcytdewizz .gt_empty_group_heading {
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

#qcytdewizz .gt_from_md > :first-child {
  margin-top: 0;
}

#qcytdewizz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qcytdewizz .gt_row {
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

#qcytdewizz .gt_stub {
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

#qcytdewizz .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qcytdewizz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#qcytdewizz .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qcytdewizz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qcytdewizz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qcytdewizz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qcytdewizz .gt_footnotes {
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

#qcytdewizz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#qcytdewizz .gt_sourcenotes {
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

#qcytdewizz .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#qcytdewizz .gt_left {
  text-align: left;
}

#qcytdewizz .gt_center {
  text-align: center;
}

#qcytdewizz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qcytdewizz .gt_font_normal {
  font-weight: normal;
}

#qcytdewizz .gt_font_bold {
  font-weight: bold;
}

#qcytdewizz .gt_font_italic {
  font-style: italic;
}

#qcytdewizz .gt_super {
  font-size: 65%;
}

#qcytdewizz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qcytdewizz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#jzfaxuaeih .gt_table {
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

#jzfaxuaeih .gt_heading {
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

#jzfaxuaeih .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jzfaxuaeih .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jzfaxuaeih .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jzfaxuaeih .gt_col_headings {
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

#jzfaxuaeih .gt_col_heading {
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

#jzfaxuaeih .gt_column_spanner_outer {
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

#jzfaxuaeih .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jzfaxuaeih .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jzfaxuaeih .gt_column_spanner {
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

#jzfaxuaeih .gt_group_heading {
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

#jzfaxuaeih .gt_empty_group_heading {
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

#jzfaxuaeih .gt_from_md > :first-child {
  margin-top: 0;
}

#jzfaxuaeih .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jzfaxuaeih .gt_row {
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

#jzfaxuaeih .gt_stub {
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

#jzfaxuaeih .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jzfaxuaeih .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#jzfaxuaeih .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jzfaxuaeih .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jzfaxuaeih .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jzfaxuaeih .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jzfaxuaeih .gt_footnotes {
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

#jzfaxuaeih .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#jzfaxuaeih .gt_sourcenotes {
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

#jzfaxuaeih .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#jzfaxuaeih .gt_left {
  text-align: left;
}

#jzfaxuaeih .gt_center {
  text-align: center;
}

#jzfaxuaeih .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jzfaxuaeih .gt_font_normal {
  font-weight: normal;
}

#jzfaxuaeih .gt_font_bold {
  font-weight: bold;
}

#jzfaxuaeih .gt_font_italic {
  font-style: italic;
}

#jzfaxuaeih .gt_super {
  font-size: 65%;
}

#jzfaxuaeih .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jzfaxuaeih" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#dskcyzwmhi .gt_table {
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

#dskcyzwmhi .gt_heading {
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

#dskcyzwmhi .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#dskcyzwmhi .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#dskcyzwmhi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dskcyzwmhi .gt_col_headings {
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

#dskcyzwmhi .gt_col_heading {
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

#dskcyzwmhi .gt_column_spanner_outer {
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

#dskcyzwmhi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dskcyzwmhi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dskcyzwmhi .gt_column_spanner {
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

#dskcyzwmhi .gt_group_heading {
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

#dskcyzwmhi .gt_empty_group_heading {
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

#dskcyzwmhi .gt_from_md > :first-child {
  margin-top: 0;
}

#dskcyzwmhi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dskcyzwmhi .gt_row {
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

#dskcyzwmhi .gt_stub {
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

#dskcyzwmhi .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dskcyzwmhi .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dskcyzwmhi .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dskcyzwmhi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dskcyzwmhi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dskcyzwmhi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dskcyzwmhi .gt_footnotes {
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

#dskcyzwmhi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dskcyzwmhi .gt_sourcenotes {
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

#dskcyzwmhi .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dskcyzwmhi .gt_left {
  text-align: left;
}

#dskcyzwmhi .gt_center {
  text-align: center;
}

#dskcyzwmhi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dskcyzwmhi .gt_font_normal {
  font-weight: normal;
}

#dskcyzwmhi .gt_font_bold {
  font-weight: bold;
}

#dskcyzwmhi .gt_font_italic {
  font-style: italic;
}

#dskcyzwmhi .gt_super {
  font-size: 65%;
}

#dskcyzwmhi .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dskcyzwmhi" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#pydzzzgxvt .gt_table {
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

#pydzzzgxvt .gt_heading {
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

#pydzzzgxvt .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#pydzzzgxvt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#pydzzzgxvt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pydzzzgxvt .gt_col_headings {
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

#pydzzzgxvt .gt_col_heading {
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

#pydzzzgxvt .gt_column_spanner_outer {
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

#pydzzzgxvt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pydzzzgxvt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pydzzzgxvt .gt_column_spanner {
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

#pydzzzgxvt .gt_group_heading {
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

#pydzzzgxvt .gt_empty_group_heading {
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

#pydzzzgxvt .gt_from_md > :first-child {
  margin-top: 0;
}

#pydzzzgxvt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pydzzzgxvt .gt_row {
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

#pydzzzgxvt .gt_stub {
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

#pydzzzgxvt .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pydzzzgxvt .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#pydzzzgxvt .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pydzzzgxvt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pydzzzgxvt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pydzzzgxvt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pydzzzgxvt .gt_footnotes {
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

#pydzzzgxvt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#pydzzzgxvt .gt_sourcenotes {
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

#pydzzzgxvt .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#pydzzzgxvt .gt_left {
  text-align: left;
}

#pydzzzgxvt .gt_center {
  text-align: center;
}

#pydzzzgxvt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pydzzzgxvt .gt_font_normal {
  font-weight: normal;
}

#pydzzzgxvt .gt_font_bold {
  font-weight: bold;
}

#pydzzzgxvt .gt_font_italic {
  font-style: italic;
}

#pydzzzgxvt .gt_super {
  font-size: 65%;
}

#pydzzzgxvt .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="pydzzzgxvt" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#trvdijemga .gt_table {
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

#trvdijemga .gt_heading {
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

#trvdijemga .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#trvdijemga .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#trvdijemga .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#trvdijemga .gt_col_headings {
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

#trvdijemga .gt_col_heading {
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

#trvdijemga .gt_column_spanner_outer {
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

#trvdijemga .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#trvdijemga .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#trvdijemga .gt_column_spanner {
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

#trvdijemga .gt_group_heading {
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

#trvdijemga .gt_empty_group_heading {
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

#trvdijemga .gt_from_md > :first-child {
  margin-top: 0;
}

#trvdijemga .gt_from_md > :last-child {
  margin-bottom: 0;
}

#trvdijemga .gt_row {
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

#trvdijemga .gt_stub {
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

#trvdijemga .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#trvdijemga .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#trvdijemga .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#trvdijemga .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#trvdijemga .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#trvdijemga .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#trvdijemga .gt_footnotes {
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

#trvdijemga .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#trvdijemga .gt_sourcenotes {
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

#trvdijemga .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#trvdijemga .gt_left {
  text-align: left;
}

#trvdijemga .gt_center {
  text-align: center;
}

#trvdijemga .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#trvdijemga .gt_font_normal {
  font-weight: normal;
}

#trvdijemga .gt_font_bold {
  font-weight: bold;
}

#trvdijemga .gt_font_italic {
  font-style: italic;
}

#trvdijemga .gt_super {
  font-size: 65%;
}

#trvdijemga .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="trvdijemga" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ksfnnyphpl .gt_table {
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

#ksfnnyphpl .gt_heading {
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

#ksfnnyphpl .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ksfnnyphpl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ksfnnyphpl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ksfnnyphpl .gt_col_headings {
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

#ksfnnyphpl .gt_col_heading {
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

#ksfnnyphpl .gt_column_spanner_outer {
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

#ksfnnyphpl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ksfnnyphpl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ksfnnyphpl .gt_column_spanner {
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

#ksfnnyphpl .gt_group_heading {
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

#ksfnnyphpl .gt_empty_group_heading {
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

#ksfnnyphpl .gt_from_md > :first-child {
  margin-top: 0;
}

#ksfnnyphpl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ksfnnyphpl .gt_row {
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

#ksfnnyphpl .gt_stub {
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

#ksfnnyphpl .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ksfnnyphpl .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ksfnnyphpl .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ksfnnyphpl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ksfnnyphpl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ksfnnyphpl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ksfnnyphpl .gt_footnotes {
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

#ksfnnyphpl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ksfnnyphpl .gt_sourcenotes {
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

#ksfnnyphpl .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ksfnnyphpl .gt_left {
  text-align: left;
}

#ksfnnyphpl .gt_center {
  text-align: center;
}

#ksfnnyphpl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ksfnnyphpl .gt_font_normal {
  font-weight: normal;
}

#ksfnnyphpl .gt_font_bold {
  font-weight: bold;
}

#ksfnnyphpl .gt_font_italic {
  font-style: italic;
}

#ksfnnyphpl .gt_super {
  font-size: 65%;
}

#ksfnnyphpl .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ksfnnyphpl" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#velvmkgqtg .gt_table {
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

#velvmkgqtg .gt_heading {
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

#velvmkgqtg .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#velvmkgqtg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#velvmkgqtg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#velvmkgqtg .gt_col_headings {
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

#velvmkgqtg .gt_col_heading {
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

#velvmkgqtg .gt_column_spanner_outer {
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

#velvmkgqtg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#velvmkgqtg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#velvmkgqtg .gt_column_spanner {
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

#velvmkgqtg .gt_group_heading {
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

#velvmkgqtg .gt_empty_group_heading {
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

#velvmkgqtg .gt_from_md > :first-child {
  margin-top: 0;
}

#velvmkgqtg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#velvmkgqtg .gt_row {
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

#velvmkgqtg .gt_stub {
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

#velvmkgqtg .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#velvmkgqtg .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#velvmkgqtg .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#velvmkgqtg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#velvmkgqtg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#velvmkgqtg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#velvmkgqtg .gt_footnotes {
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

#velvmkgqtg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#velvmkgqtg .gt_sourcenotes {
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

#velvmkgqtg .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#velvmkgqtg .gt_left {
  text-align: left;
}

#velvmkgqtg .gt_center {
  text-align: center;
}

#velvmkgqtg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#velvmkgqtg .gt_font_normal {
  font-weight: normal;
}

#velvmkgqtg .gt_font_bold {
  font-weight: bold;
}

#velvmkgqtg .gt_font_italic {
  font-style: italic;
}

#velvmkgqtg .gt_super {
  font-size: 65%;
}

#velvmkgqtg .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="velvmkgqtg" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#fhhfylfpgh .gt_table {
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

#fhhfylfpgh .gt_heading {
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

#fhhfylfpgh .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#fhhfylfpgh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#fhhfylfpgh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fhhfylfpgh .gt_col_headings {
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

#fhhfylfpgh .gt_col_heading {
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

#fhhfylfpgh .gt_column_spanner_outer {
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

#fhhfylfpgh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fhhfylfpgh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fhhfylfpgh .gt_column_spanner {
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

#fhhfylfpgh .gt_group_heading {
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

#fhhfylfpgh .gt_empty_group_heading {
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

#fhhfylfpgh .gt_from_md > :first-child {
  margin-top: 0;
}

#fhhfylfpgh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fhhfylfpgh .gt_row {
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

#fhhfylfpgh .gt_stub {
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

#fhhfylfpgh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fhhfylfpgh .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#fhhfylfpgh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fhhfylfpgh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fhhfylfpgh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fhhfylfpgh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fhhfylfpgh .gt_footnotes {
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

#fhhfylfpgh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#fhhfylfpgh .gt_sourcenotes {
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

#fhhfylfpgh .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#fhhfylfpgh .gt_left {
  text-align: left;
}

#fhhfylfpgh .gt_center {
  text-align: center;
}

#fhhfylfpgh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fhhfylfpgh .gt_font_normal {
  font-weight: normal;
}

#fhhfylfpgh .gt_font_bold {
  font-weight: bold;
}

#fhhfylfpgh .gt_font_italic {
  font-style: italic;
}

#fhhfylfpgh .gt_super {
  font-size: 65%;
}

#fhhfylfpgh .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="fhhfylfpgh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#idqkhqgnjm .gt_table {
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

#idqkhqgnjm .gt_heading {
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

#idqkhqgnjm .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#idqkhqgnjm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#idqkhqgnjm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#idqkhqgnjm .gt_col_headings {
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

#idqkhqgnjm .gt_col_heading {
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

#idqkhqgnjm .gt_column_spanner_outer {
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

#idqkhqgnjm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#idqkhqgnjm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#idqkhqgnjm .gt_column_spanner {
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

#idqkhqgnjm .gt_group_heading {
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

#idqkhqgnjm .gt_empty_group_heading {
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

#idqkhqgnjm .gt_from_md > :first-child {
  margin-top: 0;
}

#idqkhqgnjm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#idqkhqgnjm .gt_row {
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

#idqkhqgnjm .gt_stub {
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

#idqkhqgnjm .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#idqkhqgnjm .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#idqkhqgnjm .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#idqkhqgnjm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#idqkhqgnjm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#idqkhqgnjm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#idqkhqgnjm .gt_footnotes {
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

#idqkhqgnjm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#idqkhqgnjm .gt_sourcenotes {
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

#idqkhqgnjm .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#idqkhqgnjm .gt_left {
  text-align: left;
}

#idqkhqgnjm .gt_center {
  text-align: center;
}

#idqkhqgnjm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#idqkhqgnjm .gt_font_normal {
  font-weight: normal;
}

#idqkhqgnjm .gt_font_bold {
  font-weight: bold;
}

#idqkhqgnjm .gt_font_italic {
  font-style: italic;
}

#idqkhqgnjm .gt_super {
  font-size: 65%;
}

#idqkhqgnjm .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="idqkhqgnjm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#oirkgtmcyx .gt_table {
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

#oirkgtmcyx .gt_heading {
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

#oirkgtmcyx .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#oirkgtmcyx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#oirkgtmcyx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#oirkgtmcyx .gt_col_headings {
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

#oirkgtmcyx .gt_col_heading {
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

#oirkgtmcyx .gt_column_spanner_outer {
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

#oirkgtmcyx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#oirkgtmcyx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#oirkgtmcyx .gt_column_spanner {
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

#oirkgtmcyx .gt_group_heading {
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

#oirkgtmcyx .gt_empty_group_heading {
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

#oirkgtmcyx .gt_from_md > :first-child {
  margin-top: 0;
}

#oirkgtmcyx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#oirkgtmcyx .gt_row {
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

#oirkgtmcyx .gt_stub {
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

#oirkgtmcyx .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#oirkgtmcyx .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#oirkgtmcyx .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#oirkgtmcyx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#oirkgtmcyx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#oirkgtmcyx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#oirkgtmcyx .gt_footnotes {
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

#oirkgtmcyx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#oirkgtmcyx .gt_sourcenotes {
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

#oirkgtmcyx .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#oirkgtmcyx .gt_left {
  text-align: left;
}

#oirkgtmcyx .gt_center {
  text-align: center;
}

#oirkgtmcyx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#oirkgtmcyx .gt_font_normal {
  font-weight: normal;
}

#oirkgtmcyx .gt_font_bold {
  font-weight: bold;
}

#oirkgtmcyx .gt_font_italic {
  font-style: italic;
}

#oirkgtmcyx .gt_super {
  font-size: 65%;
}

#oirkgtmcyx .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="oirkgtmcyx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#wsgrdgpqin .gt_table {
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

#wsgrdgpqin .gt_heading {
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

#wsgrdgpqin .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#wsgrdgpqin .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#wsgrdgpqin .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wsgrdgpqin .gt_col_headings {
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

#wsgrdgpqin .gt_col_heading {
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

#wsgrdgpqin .gt_column_spanner_outer {
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

#wsgrdgpqin .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#wsgrdgpqin .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#wsgrdgpqin .gt_column_spanner {
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

#wsgrdgpqin .gt_group_heading {
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

#wsgrdgpqin .gt_empty_group_heading {
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

#wsgrdgpqin .gt_from_md > :first-child {
  margin-top: 0;
}

#wsgrdgpqin .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wsgrdgpqin .gt_row {
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

#wsgrdgpqin .gt_stub {
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

#wsgrdgpqin .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wsgrdgpqin .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#wsgrdgpqin .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wsgrdgpqin .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#wsgrdgpqin .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#wsgrdgpqin .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wsgrdgpqin .gt_footnotes {
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

#wsgrdgpqin .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#wsgrdgpqin .gt_sourcenotes {
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

#wsgrdgpqin .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#wsgrdgpqin .gt_left {
  text-align: left;
}

#wsgrdgpqin .gt_center {
  text-align: center;
}

#wsgrdgpqin .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wsgrdgpqin .gt_font_normal {
  font-weight: normal;
}

#wsgrdgpqin .gt_font_bold {
  font-weight: bold;
}

#wsgrdgpqin .gt_font_italic {
  font-style: italic;
}

#wsgrdgpqin .gt_super {
  font-size: 65%;
}

#wsgrdgpqin .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="wsgrdgpqin" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#peithhmbjw .gt_table {
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

#peithhmbjw .gt_heading {
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

#peithhmbjw .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#peithhmbjw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#peithhmbjw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#peithhmbjw .gt_col_headings {
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

#peithhmbjw .gt_col_heading {
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

#peithhmbjw .gt_column_spanner_outer {
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

#peithhmbjw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#peithhmbjw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#peithhmbjw .gt_column_spanner {
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

#peithhmbjw .gt_group_heading {
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

#peithhmbjw .gt_empty_group_heading {
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

#peithhmbjw .gt_from_md > :first-child {
  margin-top: 0;
}

#peithhmbjw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#peithhmbjw .gt_row {
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

#peithhmbjw .gt_stub {
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

#peithhmbjw .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#peithhmbjw .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#peithhmbjw .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#peithhmbjw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#peithhmbjw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#peithhmbjw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#peithhmbjw .gt_footnotes {
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

#peithhmbjw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#peithhmbjw .gt_sourcenotes {
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

#peithhmbjw .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#peithhmbjw .gt_left {
  text-align: left;
}

#peithhmbjw .gt_center {
  text-align: center;
}

#peithhmbjw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#peithhmbjw .gt_font_normal {
  font-weight: normal;
}

#peithhmbjw .gt_font_bold {
  font-weight: bold;
}

#peithhmbjw .gt_font_italic {
  font-style: italic;
}

#peithhmbjw .gt_super {
  font-size: 65%;
}

#peithhmbjw .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="peithhmbjw" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#cnfbqthfdj .gt_table {
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

#cnfbqthfdj .gt_heading {
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

#cnfbqthfdj .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#cnfbqthfdj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#cnfbqthfdj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cnfbqthfdj .gt_col_headings {
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

#cnfbqthfdj .gt_col_heading {
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

#cnfbqthfdj .gt_column_spanner_outer {
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

#cnfbqthfdj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cnfbqthfdj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cnfbqthfdj .gt_column_spanner {
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

#cnfbqthfdj .gt_group_heading {
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

#cnfbqthfdj .gt_empty_group_heading {
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

#cnfbqthfdj .gt_from_md > :first-child {
  margin-top: 0;
}

#cnfbqthfdj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cnfbqthfdj .gt_row {
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

#cnfbqthfdj .gt_stub {
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

#cnfbqthfdj .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cnfbqthfdj .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#cnfbqthfdj .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cnfbqthfdj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cnfbqthfdj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cnfbqthfdj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cnfbqthfdj .gt_footnotes {
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

#cnfbqthfdj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#cnfbqthfdj .gt_sourcenotes {
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

#cnfbqthfdj .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#cnfbqthfdj .gt_left {
  text-align: left;
}

#cnfbqthfdj .gt_center {
  text-align: center;
}

#cnfbqthfdj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cnfbqthfdj .gt_font_normal {
  font-weight: normal;
}

#cnfbqthfdj .gt_font_bold {
  font-weight: bold;
}

#cnfbqthfdj .gt_font_italic {
  font-style: italic;
}

#cnfbqthfdj .gt_super {
  font-size: 65%;
}

#cnfbqthfdj .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="cnfbqthfdj" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#dvhjyolhmm .gt_table {
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

#dvhjyolhmm .gt_heading {
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

#dvhjyolhmm .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#dvhjyolhmm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#dvhjyolhmm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dvhjyolhmm .gt_col_headings {
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

#dvhjyolhmm .gt_col_heading {
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

#dvhjyolhmm .gt_column_spanner_outer {
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

#dvhjyolhmm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dvhjyolhmm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dvhjyolhmm .gt_column_spanner {
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

#dvhjyolhmm .gt_group_heading {
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

#dvhjyolhmm .gt_empty_group_heading {
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

#dvhjyolhmm .gt_from_md > :first-child {
  margin-top: 0;
}

#dvhjyolhmm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dvhjyolhmm .gt_row {
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

#dvhjyolhmm .gt_stub {
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

#dvhjyolhmm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dvhjyolhmm .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dvhjyolhmm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dvhjyolhmm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dvhjyolhmm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dvhjyolhmm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dvhjyolhmm .gt_footnotes {
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

#dvhjyolhmm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dvhjyolhmm .gt_sourcenotes {
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

#dvhjyolhmm .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dvhjyolhmm .gt_left {
  text-align: left;
}

#dvhjyolhmm .gt_center {
  text-align: center;
}

#dvhjyolhmm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dvhjyolhmm .gt_font_normal {
  font-weight: normal;
}

#dvhjyolhmm .gt_font_bold {
  font-weight: bold;
}

#dvhjyolhmm .gt_font_italic {
  font-style: italic;
}

#dvhjyolhmm .gt_super {
  font-size: 65%;
}

#dvhjyolhmm .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dvhjyolhmm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#tbqdwyupzr .gt_table {
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

#tbqdwyupzr .gt_heading {
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

#tbqdwyupzr .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#tbqdwyupzr .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#tbqdwyupzr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tbqdwyupzr .gt_col_headings {
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

#tbqdwyupzr .gt_col_heading {
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

#tbqdwyupzr .gt_column_spanner_outer {
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

#tbqdwyupzr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tbqdwyupzr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tbqdwyupzr .gt_column_spanner {
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

#tbqdwyupzr .gt_group_heading {
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

#tbqdwyupzr .gt_empty_group_heading {
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

#tbqdwyupzr .gt_from_md > :first-child {
  margin-top: 0;
}

#tbqdwyupzr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tbqdwyupzr .gt_row {
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

#tbqdwyupzr .gt_stub {
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

#tbqdwyupzr .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tbqdwyupzr .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#tbqdwyupzr .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tbqdwyupzr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tbqdwyupzr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tbqdwyupzr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tbqdwyupzr .gt_footnotes {
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

#tbqdwyupzr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#tbqdwyupzr .gt_sourcenotes {
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

#tbqdwyupzr .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#tbqdwyupzr .gt_left {
  text-align: left;
}

#tbqdwyupzr .gt_center {
  text-align: center;
}

#tbqdwyupzr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tbqdwyupzr .gt_font_normal {
  font-weight: normal;
}

#tbqdwyupzr .gt_font_bold {
  font-weight: bold;
}

#tbqdwyupzr .gt_font_italic {
  font-style: italic;
}

#tbqdwyupzr .gt_super {
  font-size: 65%;
}

#tbqdwyupzr .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="tbqdwyupzr" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ylfmracgpa .gt_table {
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

#ylfmracgpa .gt_heading {
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

#ylfmracgpa .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ylfmracgpa .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ylfmracgpa .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ylfmracgpa .gt_col_headings {
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

#ylfmracgpa .gt_col_heading {
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

#ylfmracgpa .gt_column_spanner_outer {
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

#ylfmracgpa .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ylfmracgpa .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ylfmracgpa .gt_column_spanner {
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

#ylfmracgpa .gt_group_heading {
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

#ylfmracgpa .gt_empty_group_heading {
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

#ylfmracgpa .gt_from_md > :first-child {
  margin-top: 0;
}

#ylfmracgpa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ylfmracgpa .gt_row {
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

#ylfmracgpa .gt_stub {
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

#ylfmracgpa .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ylfmracgpa .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ylfmracgpa .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ylfmracgpa .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ylfmracgpa .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ylfmracgpa .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ylfmracgpa .gt_footnotes {
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

#ylfmracgpa .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ylfmracgpa .gt_sourcenotes {
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

#ylfmracgpa .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ylfmracgpa .gt_left {
  text-align: left;
}

#ylfmracgpa .gt_center {
  text-align: center;
}

#ylfmracgpa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ylfmracgpa .gt_font_normal {
  font-weight: normal;
}

#ylfmracgpa .gt_font_bold {
  font-weight: bold;
}

#ylfmracgpa .gt_font_italic {
  font-style: italic;
}

#ylfmracgpa .gt_super {
  font-size: 65%;
}

#ylfmracgpa .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ylfmracgpa" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#qqsrxfwmit .gt_table {
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

#qqsrxfwmit .gt_heading {
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

#qqsrxfwmit .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qqsrxfwmit .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qqsrxfwmit .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qqsrxfwmit .gt_col_headings {
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

#qqsrxfwmit .gt_col_heading {
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

#qqsrxfwmit .gt_column_spanner_outer {
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

#qqsrxfwmit .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qqsrxfwmit .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qqsrxfwmit .gt_column_spanner {
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

#qqsrxfwmit .gt_group_heading {
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

#qqsrxfwmit .gt_empty_group_heading {
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

#qqsrxfwmit .gt_from_md > :first-child {
  margin-top: 0;
}

#qqsrxfwmit .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qqsrxfwmit .gt_row {
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

#qqsrxfwmit .gt_stub {
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

#qqsrxfwmit .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qqsrxfwmit .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#qqsrxfwmit .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qqsrxfwmit .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qqsrxfwmit .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qqsrxfwmit .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qqsrxfwmit .gt_footnotes {
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

#qqsrxfwmit .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#qqsrxfwmit .gt_sourcenotes {
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

#qqsrxfwmit .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#qqsrxfwmit .gt_left {
  text-align: left;
}

#qqsrxfwmit .gt_center {
  text-align: center;
}

#qqsrxfwmit .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qqsrxfwmit .gt_font_normal {
  font-weight: normal;
}

#qqsrxfwmit .gt_font_bold {
  font-weight: bold;
}

#qqsrxfwmit .gt_font_italic {
  font-style: italic;
}

#qqsrxfwmit .gt_super {
  font-size: 65%;
}

#qqsrxfwmit .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qqsrxfwmit" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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
