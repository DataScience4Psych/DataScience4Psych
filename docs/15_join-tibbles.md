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

#wxiqtetznn .gt_table {
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

#wxiqtetznn .gt_heading {
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

#wxiqtetznn .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#wxiqtetznn .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#wxiqtetznn .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wxiqtetznn .gt_col_headings {
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

#wxiqtetznn .gt_col_heading {
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

#wxiqtetznn .gt_column_spanner_outer {
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

#wxiqtetznn .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#wxiqtetznn .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#wxiqtetznn .gt_column_spanner {
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

#wxiqtetznn .gt_group_heading {
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

#wxiqtetznn .gt_empty_group_heading {
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

#wxiqtetznn .gt_from_md > :first-child {
  margin-top: 0;
}

#wxiqtetznn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wxiqtetznn .gt_row {
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

#wxiqtetznn .gt_stub {
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

#wxiqtetznn .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wxiqtetznn .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#wxiqtetznn .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wxiqtetznn .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#wxiqtetznn .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#wxiqtetznn .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wxiqtetznn .gt_footnotes {
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

#wxiqtetznn .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#wxiqtetznn .gt_sourcenotes {
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

#wxiqtetznn .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#wxiqtetznn .gt_left {
  text-align: left;
}

#wxiqtetznn .gt_center {
  text-align: center;
}

#wxiqtetznn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wxiqtetznn .gt_font_normal {
  font-weight: normal;
}

#wxiqtetznn .gt_font_bold {
  font-weight: bold;
}

#wxiqtetznn .gt_font_italic {
  font-style: italic;
}

#wxiqtetznn .gt_super {
  font-size: 65%;
}

#wxiqtetznn .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="wxiqtetznn" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#cumvbhftbz .gt_table {
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

#cumvbhftbz .gt_heading {
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

#cumvbhftbz .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#cumvbhftbz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#cumvbhftbz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cumvbhftbz .gt_col_headings {
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

#cumvbhftbz .gt_col_heading {
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

#cumvbhftbz .gt_column_spanner_outer {
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

#cumvbhftbz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cumvbhftbz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cumvbhftbz .gt_column_spanner {
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

#cumvbhftbz .gt_group_heading {
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

#cumvbhftbz .gt_empty_group_heading {
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

#cumvbhftbz .gt_from_md > :first-child {
  margin-top: 0;
}

#cumvbhftbz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cumvbhftbz .gt_row {
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

#cumvbhftbz .gt_stub {
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

#cumvbhftbz .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cumvbhftbz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#cumvbhftbz .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cumvbhftbz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cumvbhftbz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cumvbhftbz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cumvbhftbz .gt_footnotes {
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

#cumvbhftbz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#cumvbhftbz .gt_sourcenotes {
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

#cumvbhftbz .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#cumvbhftbz .gt_left {
  text-align: left;
}

#cumvbhftbz .gt_center {
  text-align: center;
}

#cumvbhftbz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cumvbhftbz .gt_font_normal {
  font-weight: normal;
}

#cumvbhftbz .gt_font_bold {
  font-weight: bold;
}

#cumvbhftbz .gt_font_italic {
  font-style: italic;
}

#cumvbhftbz .gt_super {
  font-size: 65%;
}

#cumvbhftbz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="cumvbhftbz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#vrxltvvwbl .gt_table {
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

#vrxltvvwbl .gt_heading {
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

#vrxltvvwbl .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vrxltvvwbl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vrxltvvwbl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vrxltvvwbl .gt_col_headings {
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

#vrxltvvwbl .gt_col_heading {
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

#vrxltvvwbl .gt_column_spanner_outer {
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

#vrxltvvwbl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vrxltvvwbl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vrxltvvwbl .gt_column_spanner {
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

#vrxltvvwbl .gt_group_heading {
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

#vrxltvvwbl .gt_empty_group_heading {
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

#vrxltvvwbl .gt_from_md > :first-child {
  margin-top: 0;
}

#vrxltvvwbl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vrxltvvwbl .gt_row {
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

#vrxltvvwbl .gt_stub {
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

#vrxltvvwbl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vrxltvvwbl .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#vrxltvvwbl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vrxltvvwbl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vrxltvvwbl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vrxltvvwbl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vrxltvvwbl .gt_footnotes {
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

#vrxltvvwbl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#vrxltvvwbl .gt_sourcenotes {
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

#vrxltvvwbl .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#vrxltvvwbl .gt_left {
  text-align: left;
}

#vrxltvvwbl .gt_center {
  text-align: center;
}

#vrxltvvwbl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vrxltvvwbl .gt_font_normal {
  font-weight: normal;
}

#vrxltvvwbl .gt_font_bold {
  font-weight: bold;
}

#vrxltvvwbl .gt_font_italic {
  font-style: italic;
}

#vrxltvvwbl .gt_super {
  font-size: 65%;
}

#vrxltvvwbl .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="vrxltvvwbl" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#bkdlhlhmvg .gt_table {
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

#bkdlhlhmvg .gt_heading {
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

#bkdlhlhmvg .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#bkdlhlhmvg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#bkdlhlhmvg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bkdlhlhmvg .gt_col_headings {
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

#bkdlhlhmvg .gt_col_heading {
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

#bkdlhlhmvg .gt_column_spanner_outer {
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

#bkdlhlhmvg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bkdlhlhmvg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bkdlhlhmvg .gt_column_spanner {
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

#bkdlhlhmvg .gt_group_heading {
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

#bkdlhlhmvg .gt_empty_group_heading {
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

#bkdlhlhmvg .gt_from_md > :first-child {
  margin-top: 0;
}

#bkdlhlhmvg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bkdlhlhmvg .gt_row {
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

#bkdlhlhmvg .gt_stub {
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

#bkdlhlhmvg .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkdlhlhmvg .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#bkdlhlhmvg .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkdlhlhmvg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bkdlhlhmvg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bkdlhlhmvg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bkdlhlhmvg .gt_footnotes {
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

#bkdlhlhmvg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#bkdlhlhmvg .gt_sourcenotes {
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

#bkdlhlhmvg .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#bkdlhlhmvg .gt_left {
  text-align: left;
}

#bkdlhlhmvg .gt_center {
  text-align: center;
}

#bkdlhlhmvg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bkdlhlhmvg .gt_font_normal {
  font-weight: normal;
}

#bkdlhlhmvg .gt_font_bold {
  font-weight: bold;
}

#bkdlhlhmvg .gt_font_italic {
  font-style: italic;
}

#bkdlhlhmvg .gt_super {
  font-size: 65%;
}

#bkdlhlhmvg .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bkdlhlhmvg" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ateyuuqgzb .gt_table {
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

#ateyuuqgzb .gt_heading {
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

#ateyuuqgzb .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ateyuuqgzb .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ateyuuqgzb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ateyuuqgzb .gt_col_headings {
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

#ateyuuqgzb .gt_col_heading {
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

#ateyuuqgzb .gt_column_spanner_outer {
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

#ateyuuqgzb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ateyuuqgzb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ateyuuqgzb .gt_column_spanner {
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

#ateyuuqgzb .gt_group_heading {
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

#ateyuuqgzb .gt_empty_group_heading {
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

#ateyuuqgzb .gt_from_md > :first-child {
  margin-top: 0;
}

#ateyuuqgzb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ateyuuqgzb .gt_row {
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

#ateyuuqgzb .gt_stub {
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

#ateyuuqgzb .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ateyuuqgzb .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ateyuuqgzb .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ateyuuqgzb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ateyuuqgzb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ateyuuqgzb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ateyuuqgzb .gt_footnotes {
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

#ateyuuqgzb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ateyuuqgzb .gt_sourcenotes {
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

#ateyuuqgzb .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ateyuuqgzb .gt_left {
  text-align: left;
}

#ateyuuqgzb .gt_center {
  text-align: center;
}

#ateyuuqgzb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ateyuuqgzb .gt_font_normal {
  font-weight: normal;
}

#ateyuuqgzb .gt_font_bold {
  font-weight: bold;
}

#ateyuuqgzb .gt_font_italic {
  font-style: italic;
}

#ateyuuqgzb .gt_super {
  font-size: 65%;
}

#ateyuuqgzb .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ateyuuqgzb" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ezgujqtcdq .gt_table {
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

#ezgujqtcdq .gt_heading {
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

#ezgujqtcdq .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ezgujqtcdq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ezgujqtcdq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ezgujqtcdq .gt_col_headings {
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

#ezgujqtcdq .gt_col_heading {
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

#ezgujqtcdq .gt_column_spanner_outer {
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

#ezgujqtcdq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ezgujqtcdq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ezgujqtcdq .gt_column_spanner {
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

#ezgujqtcdq .gt_group_heading {
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

#ezgujqtcdq .gt_empty_group_heading {
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

#ezgujqtcdq .gt_from_md > :first-child {
  margin-top: 0;
}

#ezgujqtcdq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ezgujqtcdq .gt_row {
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

#ezgujqtcdq .gt_stub {
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

#ezgujqtcdq .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ezgujqtcdq .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ezgujqtcdq .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ezgujqtcdq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ezgujqtcdq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ezgujqtcdq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ezgujqtcdq .gt_footnotes {
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

#ezgujqtcdq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ezgujqtcdq .gt_sourcenotes {
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

#ezgujqtcdq .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ezgujqtcdq .gt_left {
  text-align: left;
}

#ezgujqtcdq .gt_center {
  text-align: center;
}

#ezgujqtcdq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ezgujqtcdq .gt_font_normal {
  font-weight: normal;
}

#ezgujqtcdq .gt_font_bold {
  font-weight: bold;
}

#ezgujqtcdq .gt_font_italic {
  font-style: italic;
}

#ezgujqtcdq .gt_super {
  font-size: 65%;
}

#ezgujqtcdq .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ezgujqtcdq" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#cmwomlmlmh .gt_table {
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

#cmwomlmlmh .gt_heading {
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

#cmwomlmlmh .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#cmwomlmlmh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#cmwomlmlmh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cmwomlmlmh .gt_col_headings {
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

#cmwomlmlmh .gt_col_heading {
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

#cmwomlmlmh .gt_column_spanner_outer {
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

#cmwomlmlmh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cmwomlmlmh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cmwomlmlmh .gt_column_spanner {
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

#cmwomlmlmh .gt_group_heading {
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

#cmwomlmlmh .gt_empty_group_heading {
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

#cmwomlmlmh .gt_from_md > :first-child {
  margin-top: 0;
}

#cmwomlmlmh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cmwomlmlmh .gt_row {
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

#cmwomlmlmh .gt_stub {
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

#cmwomlmlmh .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cmwomlmlmh .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#cmwomlmlmh .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cmwomlmlmh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cmwomlmlmh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cmwomlmlmh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cmwomlmlmh .gt_footnotes {
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

#cmwomlmlmh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#cmwomlmlmh .gt_sourcenotes {
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

#cmwomlmlmh .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#cmwomlmlmh .gt_left {
  text-align: left;
}

#cmwomlmlmh .gt_center {
  text-align: center;
}

#cmwomlmlmh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cmwomlmlmh .gt_font_normal {
  font-weight: normal;
}

#cmwomlmlmh .gt_font_bold {
  font-weight: bold;
}

#cmwomlmlmh .gt_font_italic {
  font-style: italic;
}

#cmwomlmlmh .gt_super {
  font-size: 65%;
}

#cmwomlmlmh .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="cmwomlmlmh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#ertrhfyqko .gt_table {
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

#ertrhfyqko .gt_heading {
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

#ertrhfyqko .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#ertrhfyqko .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#ertrhfyqko .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ertrhfyqko .gt_col_headings {
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

#ertrhfyqko .gt_col_heading {
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

#ertrhfyqko .gt_column_spanner_outer {
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

#ertrhfyqko .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ertrhfyqko .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ertrhfyqko .gt_column_spanner {
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

#ertrhfyqko .gt_group_heading {
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

#ertrhfyqko .gt_empty_group_heading {
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

#ertrhfyqko .gt_from_md > :first-child {
  margin-top: 0;
}

#ertrhfyqko .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ertrhfyqko .gt_row {
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

#ertrhfyqko .gt_stub {
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

#ertrhfyqko .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ertrhfyqko .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ertrhfyqko .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ertrhfyqko .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ertrhfyqko .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ertrhfyqko .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ertrhfyqko .gt_footnotes {
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

#ertrhfyqko .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ertrhfyqko .gt_sourcenotes {
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

#ertrhfyqko .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ertrhfyqko .gt_left {
  text-align: left;
}

#ertrhfyqko .gt_center {
  text-align: center;
}

#ertrhfyqko .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ertrhfyqko .gt_font_normal {
  font-weight: normal;
}

#ertrhfyqko .gt_font_bold {
  font-weight: bold;
}

#ertrhfyqko .gt_font_italic {
  font-style: italic;
}

#ertrhfyqko .gt_super {
  font-size: 65%;
}

#ertrhfyqko .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ertrhfyqko" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#pwuzuegqhv .gt_table {
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

#pwuzuegqhv .gt_heading {
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

#pwuzuegqhv .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pwuzuegqhv .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pwuzuegqhv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwuzuegqhv .gt_col_headings {
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

#pwuzuegqhv .gt_col_heading {
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

#pwuzuegqhv .gt_column_spanner_outer {
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

#pwuzuegqhv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pwuzuegqhv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pwuzuegqhv .gt_column_spanner {
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

#pwuzuegqhv .gt_group_heading {
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

#pwuzuegqhv .gt_empty_group_heading {
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

#pwuzuegqhv .gt_from_md > :first-child {
  margin-top: 0;
}

#pwuzuegqhv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pwuzuegqhv .gt_row {
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

#pwuzuegqhv .gt_stub {
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

#pwuzuegqhv .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwuzuegqhv .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#pwuzuegqhv .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwuzuegqhv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pwuzuegqhv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pwuzuegqhv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwuzuegqhv .gt_footnotes {
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

#pwuzuegqhv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#pwuzuegqhv .gt_sourcenotes {
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

#pwuzuegqhv .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#pwuzuegqhv .gt_left {
  text-align: left;
}

#pwuzuegqhv .gt_center {
  text-align: center;
}

#pwuzuegqhv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pwuzuegqhv .gt_font_normal {
  font-weight: normal;
}

#pwuzuegqhv .gt_font_bold {
  font-weight: bold;
}

#pwuzuegqhv .gt_font_italic {
  font-style: italic;
}

#pwuzuegqhv .gt_super {
  font-size: 65%;
}

#pwuzuegqhv .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="pwuzuegqhv" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#bejxfuugko .gt_table {
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

#bejxfuugko .gt_heading {
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

#bejxfuugko .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#bejxfuugko .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#bejxfuugko .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bejxfuugko .gt_col_headings {
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

#bejxfuugko .gt_col_heading {
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

#bejxfuugko .gt_column_spanner_outer {
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

#bejxfuugko .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bejxfuugko .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bejxfuugko .gt_column_spanner {
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

#bejxfuugko .gt_group_heading {
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

#bejxfuugko .gt_empty_group_heading {
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

#bejxfuugko .gt_from_md > :first-child {
  margin-top: 0;
}

#bejxfuugko .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bejxfuugko .gt_row {
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

#bejxfuugko .gt_stub {
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

#bejxfuugko .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bejxfuugko .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#bejxfuugko .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bejxfuugko .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bejxfuugko .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bejxfuugko .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bejxfuugko .gt_footnotes {
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

#bejxfuugko .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#bejxfuugko .gt_sourcenotes {
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

#bejxfuugko .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#bejxfuugko .gt_left {
  text-align: left;
}

#bejxfuugko .gt_center {
  text-align: center;
}

#bejxfuugko .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bejxfuugko .gt_font_normal {
  font-weight: normal;
}

#bejxfuugko .gt_font_bold {
  font-weight: bold;
}

#bejxfuugko .gt_font_italic {
  font-style: italic;
}

#bejxfuugko .gt_super {
  font-size: 65%;
}

#bejxfuugko .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bejxfuugko" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#vwnuxlirkh .gt_table {
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

#vwnuxlirkh .gt_heading {
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

#vwnuxlirkh .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#vwnuxlirkh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#vwnuxlirkh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vwnuxlirkh .gt_col_headings {
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

#vwnuxlirkh .gt_col_heading {
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

#vwnuxlirkh .gt_column_spanner_outer {
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

#vwnuxlirkh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vwnuxlirkh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vwnuxlirkh .gt_column_spanner {
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

#vwnuxlirkh .gt_group_heading {
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

#vwnuxlirkh .gt_empty_group_heading {
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

#vwnuxlirkh .gt_from_md > :first-child {
  margin-top: 0;
}

#vwnuxlirkh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vwnuxlirkh .gt_row {
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

#vwnuxlirkh .gt_stub {
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

#vwnuxlirkh .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vwnuxlirkh .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#vwnuxlirkh .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vwnuxlirkh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vwnuxlirkh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vwnuxlirkh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vwnuxlirkh .gt_footnotes {
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

#vwnuxlirkh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#vwnuxlirkh .gt_sourcenotes {
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

#vwnuxlirkh .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#vwnuxlirkh .gt_left {
  text-align: left;
}

#vwnuxlirkh .gt_center {
  text-align: center;
}

#vwnuxlirkh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vwnuxlirkh .gt_font_normal {
  font-weight: normal;
}

#vwnuxlirkh .gt_font_bold {
  font-weight: bold;
}

#vwnuxlirkh .gt_font_italic {
  font-style: italic;
}

#vwnuxlirkh .gt_super {
  font-size: 65%;
}

#vwnuxlirkh .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="vwnuxlirkh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#mkmpfyqugx .gt_table {
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

#mkmpfyqugx .gt_heading {
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

#mkmpfyqugx .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mkmpfyqugx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mkmpfyqugx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mkmpfyqugx .gt_col_headings {
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

#mkmpfyqugx .gt_col_heading {
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

#mkmpfyqugx .gt_column_spanner_outer {
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

#mkmpfyqugx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mkmpfyqugx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mkmpfyqugx .gt_column_spanner {
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

#mkmpfyqugx .gt_group_heading {
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

#mkmpfyqugx .gt_empty_group_heading {
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

#mkmpfyqugx .gt_from_md > :first-child {
  margin-top: 0;
}

#mkmpfyqugx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mkmpfyqugx .gt_row {
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

#mkmpfyqugx .gt_stub {
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

#mkmpfyqugx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mkmpfyqugx .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#mkmpfyqugx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mkmpfyqugx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mkmpfyqugx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mkmpfyqugx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mkmpfyqugx .gt_footnotes {
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

#mkmpfyqugx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#mkmpfyqugx .gt_sourcenotes {
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

#mkmpfyqugx .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#mkmpfyqugx .gt_left {
  text-align: left;
}

#mkmpfyqugx .gt_center {
  text-align: center;
}

#mkmpfyqugx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mkmpfyqugx .gt_font_normal {
  font-weight: normal;
}

#mkmpfyqugx .gt_font_bold {
  font-weight: bold;
}

#mkmpfyqugx .gt_font_italic {
  font-style: italic;
}

#mkmpfyqugx .gt_super {
  font-size: 65%;
}

#mkmpfyqugx .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mkmpfyqugx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#msznyyxaxe .gt_table {
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

#msznyyxaxe .gt_heading {
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

#msznyyxaxe .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#msznyyxaxe .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#msznyyxaxe .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#msznyyxaxe .gt_col_headings {
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

#msznyyxaxe .gt_col_heading {
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

#msznyyxaxe .gt_column_spanner_outer {
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

#msznyyxaxe .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#msznyyxaxe .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#msznyyxaxe .gt_column_spanner {
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

#msznyyxaxe .gt_group_heading {
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

#msznyyxaxe .gt_empty_group_heading {
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

#msznyyxaxe .gt_from_md > :first-child {
  margin-top: 0;
}

#msznyyxaxe .gt_from_md > :last-child {
  margin-bottom: 0;
}

#msznyyxaxe .gt_row {
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

#msznyyxaxe .gt_stub {
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

#msznyyxaxe .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#msznyyxaxe .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#msznyyxaxe .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#msznyyxaxe .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#msznyyxaxe .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#msznyyxaxe .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#msznyyxaxe .gt_footnotes {
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

#msznyyxaxe .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#msznyyxaxe .gt_sourcenotes {
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

#msznyyxaxe .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#msznyyxaxe .gt_left {
  text-align: left;
}

#msznyyxaxe .gt_center {
  text-align: center;
}

#msznyyxaxe .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#msznyyxaxe .gt_font_normal {
  font-weight: normal;
}

#msznyyxaxe .gt_font_bold {
  font-weight: bold;
}

#msznyyxaxe .gt_font_italic {
  font-style: italic;
}

#msznyyxaxe .gt_super {
  font-size: 65%;
}

#msznyyxaxe .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="msznyyxaxe" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#dejdldetzn .gt_table {
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

#dejdldetzn .gt_heading {
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

#dejdldetzn .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#dejdldetzn .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#dejdldetzn .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dejdldetzn .gt_col_headings {
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

#dejdldetzn .gt_col_heading {
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

#dejdldetzn .gt_column_spanner_outer {
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

#dejdldetzn .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dejdldetzn .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dejdldetzn .gt_column_spanner {
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

#dejdldetzn .gt_group_heading {
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

#dejdldetzn .gt_empty_group_heading {
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

#dejdldetzn .gt_from_md > :first-child {
  margin-top: 0;
}

#dejdldetzn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dejdldetzn .gt_row {
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

#dejdldetzn .gt_stub {
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

#dejdldetzn .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dejdldetzn .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dejdldetzn .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dejdldetzn .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dejdldetzn .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dejdldetzn .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dejdldetzn .gt_footnotes {
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

#dejdldetzn .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dejdldetzn .gt_sourcenotes {
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

#dejdldetzn .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dejdldetzn .gt_left {
  text-align: left;
}

#dejdldetzn .gt_center {
  text-align: center;
}

#dejdldetzn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dejdldetzn .gt_font_normal {
  font-weight: normal;
}

#dejdldetzn .gt_font_bold {
  font-weight: bold;
}

#dejdldetzn .gt_font_italic {
  font-style: italic;
}

#dejdldetzn .gt_super {
  font-size: 65%;
}

#dejdldetzn .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dejdldetzn" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#raxejfbgax .gt_table {
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

#raxejfbgax .gt_heading {
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

#raxejfbgax .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#raxejfbgax .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#raxejfbgax .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#raxejfbgax .gt_col_headings {
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

#raxejfbgax .gt_col_heading {
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

#raxejfbgax .gt_column_spanner_outer {
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

#raxejfbgax .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#raxejfbgax .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#raxejfbgax .gt_column_spanner {
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

#raxejfbgax .gt_group_heading {
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

#raxejfbgax .gt_empty_group_heading {
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

#raxejfbgax .gt_from_md > :first-child {
  margin-top: 0;
}

#raxejfbgax .gt_from_md > :last-child {
  margin-bottom: 0;
}

#raxejfbgax .gt_row {
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

#raxejfbgax .gt_stub {
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

#raxejfbgax .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#raxejfbgax .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#raxejfbgax .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#raxejfbgax .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#raxejfbgax .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#raxejfbgax .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#raxejfbgax .gt_footnotes {
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

#raxejfbgax .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#raxejfbgax .gt_sourcenotes {
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

#raxejfbgax .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#raxejfbgax .gt_left {
  text-align: left;
}

#raxejfbgax .gt_center {
  text-align: center;
}

#raxejfbgax .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#raxejfbgax .gt_font_normal {
  font-weight: normal;
}

#raxejfbgax .gt_font_bold {
  font-weight: bold;
}

#raxejfbgax .gt_font_italic {
  font-style: italic;
}

#raxejfbgax .gt_super {
  font-size: 65%;
}

#raxejfbgax .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="raxejfbgax" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#tqynyctgyv .gt_table {
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

#tqynyctgyv .gt_heading {
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

#tqynyctgyv .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#tqynyctgyv .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#tqynyctgyv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tqynyctgyv .gt_col_headings {
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

#tqynyctgyv .gt_col_heading {
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

#tqynyctgyv .gt_column_spanner_outer {
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

#tqynyctgyv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tqynyctgyv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tqynyctgyv .gt_column_spanner {
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

#tqynyctgyv .gt_group_heading {
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

#tqynyctgyv .gt_empty_group_heading {
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

#tqynyctgyv .gt_from_md > :first-child {
  margin-top: 0;
}

#tqynyctgyv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tqynyctgyv .gt_row {
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

#tqynyctgyv .gt_stub {
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

#tqynyctgyv .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tqynyctgyv .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#tqynyctgyv .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tqynyctgyv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tqynyctgyv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tqynyctgyv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tqynyctgyv .gt_footnotes {
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

#tqynyctgyv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#tqynyctgyv .gt_sourcenotes {
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

#tqynyctgyv .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#tqynyctgyv .gt_left {
  text-align: left;
}

#tqynyctgyv .gt_center {
  text-align: center;
}

#tqynyctgyv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tqynyctgyv .gt_font_normal {
  font-weight: normal;
}

#tqynyctgyv .gt_font_bold {
  font-weight: bold;
}

#tqynyctgyv .gt_font_italic {
  font-style: italic;
}

#tqynyctgyv .gt_super {
  font-size: 65%;
}

#tqynyctgyv .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="tqynyctgyv" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#soqqbtsunl .gt_table {
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

#soqqbtsunl .gt_heading {
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

#soqqbtsunl .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#soqqbtsunl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#soqqbtsunl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#soqqbtsunl .gt_col_headings {
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

#soqqbtsunl .gt_col_heading {
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

#soqqbtsunl .gt_column_spanner_outer {
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

#soqqbtsunl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#soqqbtsunl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#soqqbtsunl .gt_column_spanner {
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

#soqqbtsunl .gt_group_heading {
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

#soqqbtsunl .gt_empty_group_heading {
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

#soqqbtsunl .gt_from_md > :first-child {
  margin-top: 0;
}

#soqqbtsunl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#soqqbtsunl .gt_row {
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

#soqqbtsunl .gt_stub {
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

#soqqbtsunl .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#soqqbtsunl .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#soqqbtsunl .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#soqqbtsunl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#soqqbtsunl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#soqqbtsunl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#soqqbtsunl .gt_footnotes {
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

#soqqbtsunl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#soqqbtsunl .gt_sourcenotes {
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

#soqqbtsunl .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#soqqbtsunl .gt_left {
  text-align: left;
}

#soqqbtsunl .gt_center {
  text-align: center;
}

#soqqbtsunl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#soqqbtsunl .gt_font_normal {
  font-weight: normal;
}

#soqqbtsunl .gt_font_bold {
  font-weight: bold;
}

#soqqbtsunl .gt_font_italic {
  font-style: italic;
}

#soqqbtsunl .gt_super {
  font-size: 65%;
}

#soqqbtsunl .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="soqqbtsunl" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#bphmciszqc .gt_table {
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

#bphmciszqc .gt_heading {
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

#bphmciszqc .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#bphmciszqc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#bphmciszqc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bphmciszqc .gt_col_headings {
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

#bphmciszqc .gt_col_heading {
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

#bphmciszqc .gt_column_spanner_outer {
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

#bphmciszqc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bphmciszqc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bphmciszqc .gt_column_spanner {
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

#bphmciszqc .gt_group_heading {
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

#bphmciszqc .gt_empty_group_heading {
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

#bphmciszqc .gt_from_md > :first-child {
  margin-top: 0;
}

#bphmciszqc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bphmciszqc .gt_row {
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

#bphmciszqc .gt_stub {
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

#bphmciszqc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bphmciszqc .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#bphmciszqc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bphmciszqc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bphmciszqc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bphmciszqc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bphmciszqc .gt_footnotes {
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

#bphmciszqc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#bphmciszqc .gt_sourcenotes {
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

#bphmciszqc .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#bphmciszqc .gt_left {
  text-align: left;
}

#bphmciszqc .gt_center {
  text-align: center;
}

#bphmciszqc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bphmciszqc .gt_font_normal {
  font-weight: normal;
}

#bphmciszqc .gt_font_bold {
  font-weight: bold;
}

#bphmciszqc .gt_font_italic {
  font-style: italic;
}

#bphmciszqc .gt_super {
  font-size: 65%;
}

#bphmciszqc .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bphmciszqc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#gbarlxkzio .gt_table {
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

#gbarlxkzio .gt_heading {
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

#gbarlxkzio .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#gbarlxkzio .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#gbarlxkzio .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gbarlxkzio .gt_col_headings {
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

#gbarlxkzio .gt_col_heading {
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

#gbarlxkzio .gt_column_spanner_outer {
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

#gbarlxkzio .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gbarlxkzio .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gbarlxkzio .gt_column_spanner {
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

#gbarlxkzio .gt_group_heading {
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

#gbarlxkzio .gt_empty_group_heading {
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

#gbarlxkzio .gt_from_md > :first-child {
  margin-top: 0;
}

#gbarlxkzio .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gbarlxkzio .gt_row {
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

#gbarlxkzio .gt_stub {
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

#gbarlxkzio .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gbarlxkzio .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#gbarlxkzio .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gbarlxkzio .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gbarlxkzio .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gbarlxkzio .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gbarlxkzio .gt_footnotes {
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

#gbarlxkzio .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#gbarlxkzio .gt_sourcenotes {
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

#gbarlxkzio .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#gbarlxkzio .gt_left {
  text-align: left;
}

#gbarlxkzio .gt_center {
  text-align: center;
}

#gbarlxkzio .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gbarlxkzio .gt_font_normal {
  font-weight: normal;
}

#gbarlxkzio .gt_font_bold {
  font-weight: bold;
}

#gbarlxkzio .gt_font_italic {
  font-style: italic;
}

#gbarlxkzio .gt_super {
  font-size: 65%;
}

#gbarlxkzio .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="gbarlxkzio" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#tiqpglpioq .gt_table {
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

#tiqpglpioq .gt_heading {
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

#tiqpglpioq .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#tiqpglpioq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#tiqpglpioq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tiqpglpioq .gt_col_headings {
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

#tiqpglpioq .gt_col_heading {
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

#tiqpglpioq .gt_column_spanner_outer {
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

#tiqpglpioq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tiqpglpioq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tiqpglpioq .gt_column_spanner {
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

#tiqpglpioq .gt_group_heading {
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

#tiqpglpioq .gt_empty_group_heading {
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

#tiqpglpioq .gt_from_md > :first-child {
  margin-top: 0;
}

#tiqpglpioq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tiqpglpioq .gt_row {
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

#tiqpglpioq .gt_stub {
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

#tiqpglpioq .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tiqpglpioq .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#tiqpglpioq .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tiqpglpioq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tiqpglpioq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tiqpglpioq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tiqpglpioq .gt_footnotes {
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

#tiqpglpioq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#tiqpglpioq .gt_sourcenotes {
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

#tiqpglpioq .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#tiqpglpioq .gt_left {
  text-align: left;
}

#tiqpglpioq .gt_center {
  text-align: center;
}

#tiqpglpioq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tiqpglpioq .gt_font_normal {
  font-weight: normal;
}

#tiqpglpioq .gt_font_bold {
  font-weight: bold;
}

#tiqpglpioq .gt_font_italic {
  font-style: italic;
}

#tiqpglpioq .gt_super {
  font-size: 65%;
}

#tiqpglpioq .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="tiqpglpioq" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#mslomuaicr .gt_table {
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

#mslomuaicr .gt_heading {
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

#mslomuaicr .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mslomuaicr .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mslomuaicr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mslomuaicr .gt_col_headings {
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

#mslomuaicr .gt_col_heading {
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

#mslomuaicr .gt_column_spanner_outer {
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

#mslomuaicr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mslomuaicr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mslomuaicr .gt_column_spanner {
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

#mslomuaicr .gt_group_heading {
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

#mslomuaicr .gt_empty_group_heading {
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

#mslomuaicr .gt_from_md > :first-child {
  margin-top: 0;
}

#mslomuaicr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mslomuaicr .gt_row {
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

#mslomuaicr .gt_stub {
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

#mslomuaicr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mslomuaicr .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#mslomuaicr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mslomuaicr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mslomuaicr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mslomuaicr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mslomuaicr .gt_footnotes {
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

#mslomuaicr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#mslomuaicr .gt_sourcenotes {
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

#mslomuaicr .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#mslomuaicr .gt_left {
  text-align: left;
}

#mslomuaicr .gt_center {
  text-align: center;
}

#mslomuaicr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mslomuaicr .gt_font_normal {
  font-weight: normal;
}

#mslomuaicr .gt_font_bold {
  font-weight: bold;
}

#mslomuaicr .gt_font_italic {
  font-style: italic;
}

#mslomuaicr .gt_super {
  font-size: 65%;
}

#mslomuaicr .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mslomuaicr" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#usgaullhrc .gt_table {
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

#usgaullhrc .gt_heading {
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

#usgaullhrc .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#usgaullhrc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#usgaullhrc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#usgaullhrc .gt_col_headings {
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

#usgaullhrc .gt_col_heading {
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

#usgaullhrc .gt_column_spanner_outer {
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

#usgaullhrc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#usgaullhrc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#usgaullhrc .gt_column_spanner {
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

#usgaullhrc .gt_group_heading {
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

#usgaullhrc .gt_empty_group_heading {
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

#usgaullhrc .gt_from_md > :first-child {
  margin-top: 0;
}

#usgaullhrc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#usgaullhrc .gt_row {
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

#usgaullhrc .gt_stub {
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

#usgaullhrc .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#usgaullhrc .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#usgaullhrc .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#usgaullhrc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#usgaullhrc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#usgaullhrc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#usgaullhrc .gt_footnotes {
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

#usgaullhrc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#usgaullhrc .gt_sourcenotes {
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

#usgaullhrc .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#usgaullhrc .gt_left {
  text-align: left;
}

#usgaullhrc .gt_center {
  text-align: center;
}

#usgaullhrc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#usgaullhrc .gt_font_normal {
  font-weight: normal;
}

#usgaullhrc .gt_font_bold {
  font-weight: bold;
}

#usgaullhrc .gt_font_italic {
  font-style: italic;
}

#usgaullhrc .gt_super {
  font-size: 65%;
}

#usgaullhrc .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="usgaullhrc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#crkxrsmonn .gt_table {
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

#crkxrsmonn .gt_heading {
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

#crkxrsmonn .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#crkxrsmonn .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#crkxrsmonn .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#crkxrsmonn .gt_col_headings {
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

#crkxrsmonn .gt_col_heading {
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

#crkxrsmonn .gt_column_spanner_outer {
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

#crkxrsmonn .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#crkxrsmonn .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#crkxrsmonn .gt_column_spanner {
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

#crkxrsmonn .gt_group_heading {
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

#crkxrsmonn .gt_empty_group_heading {
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

#crkxrsmonn .gt_from_md > :first-child {
  margin-top: 0;
}

#crkxrsmonn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#crkxrsmonn .gt_row {
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

#crkxrsmonn .gt_stub {
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

#crkxrsmonn .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#crkxrsmonn .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#crkxrsmonn .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#crkxrsmonn .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#crkxrsmonn .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#crkxrsmonn .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#crkxrsmonn .gt_footnotes {
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

#crkxrsmonn .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#crkxrsmonn .gt_sourcenotes {
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

#crkxrsmonn .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#crkxrsmonn .gt_left {
  text-align: left;
}

#crkxrsmonn .gt_center {
  text-align: center;
}

#crkxrsmonn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#crkxrsmonn .gt_font_normal {
  font-weight: normal;
}

#crkxrsmonn .gt_font_bold {
  font-weight: bold;
}

#crkxrsmonn .gt_font_italic {
  font-style: italic;
}

#crkxrsmonn .gt_super {
  font-size: 65%;
}

#crkxrsmonn .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="crkxrsmonn" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#zijsdenfrz .gt_table {
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

#zijsdenfrz .gt_heading {
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

#zijsdenfrz .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zijsdenfrz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zijsdenfrz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zijsdenfrz .gt_col_headings {
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

#zijsdenfrz .gt_col_heading {
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

#zijsdenfrz .gt_column_spanner_outer {
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

#zijsdenfrz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zijsdenfrz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zijsdenfrz .gt_column_spanner {
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

#zijsdenfrz .gt_group_heading {
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

#zijsdenfrz .gt_empty_group_heading {
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

#zijsdenfrz .gt_from_md > :first-child {
  margin-top: 0;
}

#zijsdenfrz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zijsdenfrz .gt_row {
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

#zijsdenfrz .gt_stub {
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

#zijsdenfrz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zijsdenfrz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#zijsdenfrz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zijsdenfrz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zijsdenfrz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zijsdenfrz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zijsdenfrz .gt_footnotes {
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

#zijsdenfrz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#zijsdenfrz .gt_sourcenotes {
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

#zijsdenfrz .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#zijsdenfrz .gt_left {
  text-align: left;
}

#zijsdenfrz .gt_center {
  text-align: center;
}

#zijsdenfrz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zijsdenfrz .gt_font_normal {
  font-weight: normal;
}

#zijsdenfrz .gt_font_bold {
  font-weight: bold;
}

#zijsdenfrz .gt_font_italic {
  font-style: italic;
}

#zijsdenfrz .gt_super {
  font-size: 65%;
}

#zijsdenfrz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zijsdenfrz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#zwlsiiyvly .gt_table {
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

#zwlsiiyvly .gt_heading {
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

#zwlsiiyvly .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #edc7fc;
  border-bottom-width: 0;
}

#zwlsiiyvly .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #edc7fc;
  border-top-width: 0;
}

#zwlsiiyvly .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zwlsiiyvly .gt_col_headings {
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

#zwlsiiyvly .gt_col_heading {
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

#zwlsiiyvly .gt_column_spanner_outer {
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

#zwlsiiyvly .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zwlsiiyvly .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zwlsiiyvly .gt_column_spanner {
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

#zwlsiiyvly .gt_group_heading {
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

#zwlsiiyvly .gt_empty_group_heading {
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

#zwlsiiyvly .gt_from_md > :first-child {
  margin-top: 0;
}

#zwlsiiyvly .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zwlsiiyvly .gt_row {
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

#zwlsiiyvly .gt_stub {
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

#zwlsiiyvly .gt_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zwlsiiyvly .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#zwlsiiyvly .gt_grand_summary_row {
  color: #333333;
  background-color: #edc7fc;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zwlsiiyvly .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zwlsiiyvly .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zwlsiiyvly .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zwlsiiyvly .gt_footnotes {
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

#zwlsiiyvly .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#zwlsiiyvly .gt_sourcenotes {
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

#zwlsiiyvly .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#zwlsiiyvly .gt_left {
  text-align: left;
}

#zwlsiiyvly .gt_center {
  text-align: center;
}

#zwlsiiyvly .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zwlsiiyvly .gt_font_normal {
  font-weight: normal;
}

#zwlsiiyvly .gt_font_bold {
  font-weight: bold;
}

#zwlsiiyvly .gt_font_italic {
  font-style: italic;
}

#zwlsiiyvly .gt_super {
  font-size: 65%;
}

#zwlsiiyvly .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zwlsiiyvly" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#usrcfoqlkd .gt_table {
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

#usrcfoqlkd .gt_heading {
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

#usrcfoqlkd .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #cce6f6;
  border-bottom-width: 0;
}

#usrcfoqlkd .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #cce6f6;
  border-top-width: 0;
}

#usrcfoqlkd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#usrcfoqlkd .gt_col_headings {
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

#usrcfoqlkd .gt_col_heading {
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

#usrcfoqlkd .gt_column_spanner_outer {
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

#usrcfoqlkd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#usrcfoqlkd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#usrcfoqlkd .gt_column_spanner {
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

#usrcfoqlkd .gt_group_heading {
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

#usrcfoqlkd .gt_empty_group_heading {
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

#usrcfoqlkd .gt_from_md > :first-child {
  margin-top: 0;
}

#usrcfoqlkd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#usrcfoqlkd .gt_row {
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

#usrcfoqlkd .gt_stub {
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

#usrcfoqlkd .gt_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#usrcfoqlkd .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#usrcfoqlkd .gt_grand_summary_row {
  color: #333333;
  background-color: #cce6f6;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#usrcfoqlkd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#usrcfoqlkd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#usrcfoqlkd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#usrcfoqlkd .gt_footnotes {
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

#usrcfoqlkd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#usrcfoqlkd .gt_sourcenotes {
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

#usrcfoqlkd .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#usrcfoqlkd .gt_left {
  text-align: left;
}

#usrcfoqlkd .gt_center {
  text-align: center;
}

#usrcfoqlkd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#usrcfoqlkd .gt_font_normal {
  font-weight: normal;
}

#usrcfoqlkd .gt_font_bold {
  font-weight: bold;
}

#usrcfoqlkd .gt_font_italic {
  font-style: italic;
}

#usrcfoqlkd .gt_super {
  font-size: 65%;
}

#usrcfoqlkd .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="usrcfoqlkd" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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

#yluduxofvz .gt_table {
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

#yluduxofvz .gt_heading {
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

#yluduxofvz .gt_title {
  color: #333333;
  font-size: 90%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#yluduxofvz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#yluduxofvz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yluduxofvz .gt_col_headings {
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

#yluduxofvz .gt_col_heading {
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

#yluduxofvz .gt_column_spanner_outer {
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

#yluduxofvz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yluduxofvz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yluduxofvz .gt_column_spanner {
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

#yluduxofvz .gt_group_heading {
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

#yluduxofvz .gt_empty_group_heading {
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

#yluduxofvz .gt_from_md > :first-child {
  margin-top: 0;
}

#yluduxofvz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yluduxofvz .gt_row {
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

#yluduxofvz .gt_stub {
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

#yluduxofvz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yluduxofvz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#yluduxofvz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yluduxofvz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yluduxofvz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yluduxofvz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yluduxofvz .gt_footnotes {
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

#yluduxofvz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#yluduxofvz .gt_sourcenotes {
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

#yluduxofvz .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#yluduxofvz .gt_left {
  text-align: left;
}

#yluduxofvz .gt_center {
  text-align: center;
}

#yluduxofvz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yluduxofvz .gt_font_normal {
  font-weight: normal;
}

#yluduxofvz .gt_font_bold {
  font-weight: bold;
}

#yluduxofvz .gt_font_italic {
  font-style: italic;
}

#yluduxofvz .gt_super {
  font-size: 65%;
}

#yluduxofvz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="yluduxofvz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
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
