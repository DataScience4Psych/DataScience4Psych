# (PART) R as a programming language {-} 

# R objects and indexing {#r-objects}



<!--Original content: https://stat545.com/block004_basic-r-objects.html-->

R objects (beyond data.frames) and indexing.

> "Rigor and clarity are not synonymous" -- Larry Wasserman

> "Never hesitate to sacrifice truth for clarity." -- Greg Wilson's dad

## Vectors are everywhere

Your garden variety R object is a vector. A single piece of info that you regard as a scalar is just a vector of length 1 and R will cheerfully let you add stuff to it. Square brackets are used for isolating elements of a vector for inspection, modification, etc. This is often called __indexing__. Go through the following code carefully, as it's really rather surprising. BTW, indexing begins at 1 in R, unlike many other languages that index from 0.


```r
x <- 3 * 4
x
#> [1] 12
is.vector(x)
#> [1] TRUE
length(x)
#> [1] 1
x[2] <- 100
x
#> [1]  12 100
x[5] <- 3
x
#> [1]  12 100  NA  NA   3
x[11]
#> [1] NA
x[0]
#> numeric(0)
```

R is built to work with vectors. Many operations are *vectorized*, i.e. by default they will happen component-wise when given a vector as input. Novices often don't internalize or exploit this and they write lots of unnecessary `for` loops.

```r
x <- 1:4
## which would you rather write and read?
## the vectorized version ...
(y <- x^2) 
#> [1]  1  4  9 16
## or the for loop version?
z <- vector(mode = mode(x), length = length(x))
for(i in seq_along(x)) {
  z[i] <- x[i]^2
}
identical(y, z)
#> [1] TRUE
```

When reading function documentation, keep your eyes peeled for arguments that can be vectors. You'll be surprised how common they are. For example, the mean and standard deviation of random normal variates can be provided as vectors.

```r
set.seed(1999)
rnorm(5, mean = 10^(1:5))
#> [1]     10.7    100.0   1001.2  10001.5 100000.1
round(rnorm(5, sd = 10^(0:4)), 2)
#> [1]     0.52    -5.49  -118.56 -1147.28 11607.42
```
This could be awesome in some settings, but dangerous in others, i.e. if you exploit this by mistake and get no warning. This is one of the reasons it's so important to keep close tabs on your R objects: are they what you expect in terms of their flavor and length or dimensions? Check early and check often.

Notice that R also recycles vectors, if they are not the necessary length. You will get a warning if R suspects recycling is unintended, i.e. when one length is not an integer multiple of another, but recycling is silent if it seems like you know what you're doing. Can be a beautiful thing when you're doing this deliberately, but devastating when you don't.

> Question: is there a way to turn recycling off? Not that I know of.


```r
(y <- 1:3)
#> [1] 1 2 3
(z <- 3:7)
#> [1] 3 4 5 6 7
y + z
#> Warning in y + z: longer object length is not a multiple of shorter object
#> length
#> [1] 4 6 8 7 9
(y <- 1:10)
#>  [1]  1  2  3  4  5  6  7  8  9 10
(z <- 3:7)
#> [1] 3 4 5 6 7
y + z
#>  [1]  4  6  8 10 12  9 11 13 15 17
```

The combine function `c()` is your go-to function for making vectors.


```r
str(c("hello", "world"))
#>  chr [1:2] "hello" "world"
str(c(1:3, 100, 150))
#>  num [1:5] 1 2 3 100 150
```

Plain vanilla R objects are called "atomic vectors" and an absolute requirement is that all the bits of info they hold are of the same flavor, i.e. all numeric or logical or character. If that's not already true upon creation, the elements will be coerced to the same flavor, using a "lowest common denominator" approach (usually character). This is another stellar opportunity for you to create an object of one flavor without meaning to do so and to remain ignorant of that for a long time. Check early, check often.


```r
(x <- c("cabbage", pi, TRUE, 4.3))
#> [1] "cabbage"          "3.14159265358979" "TRUE"             "4.3"
str(x)
#>  chr [1:4] "cabbage" "3.14159265358979" "TRUE" "4.3"
length(x)
#> [1] 4
mode(x)
#> [1] "character"
class(x)
#> [1] "character"
```

The most important atomic vector types are:

* __logical__: TRUE's AND FALSE's, easily coerced into 1's and 0's
* __numeric__: numbers and, yes, integers and double-precision floating point numbers are different but you can live happily for a long time without worrying about this
* __character__

Let's create some simple vectors for more demos below.


```r
n <- 8
set.seed(1)
(w <- round(rnorm(n), 2)) # numeric floating point
#> [1] -0.63  0.18 -0.84  1.60  0.33 -0.82  0.49  0.74
(x <- 1:n) # numeric integer
#> [1] 1 2 3 4 5 6 7 8
## another way to accomplish by hand is x <- c(1, 2, 3, 4, 5, 6, 7, 8)
(y <- LETTERS[1:n]) # character
#> [1] "A" "B" "C" "D" "E" "F" "G" "H"
(z <- runif(n) > 0.3) # logical
#> [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE
```

Use `str()` and any other functions you wish to inspect these objects, such as `length()`, `mode()`, `class()`, `is.numeric()`, `is.logical()`, etc. Like the `is.xxx()` family of functions, there are also `as.xxx()` functions you can experiment with.


```r
str(w)
#>  num [1:8] -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
length(x)
#> [1] 8
is.logical(y)
#> [1] FALSE
as.numeric(z)
#> [1] 1 1 1 1 1 0 1 0
```

## Indexing a vector

We've said, and even seen, that square brackets are used to index a vector. There is great flexibility in what one can put inside the square brackets and it's worth understanding the many options. They are all useful, just in different contexts.

Most common, useful ways to index a vector:

* __logical vector__: keep elements associated with TRUE's, ditch the FALSE's
* __vector of positive integers__: specifying the keepers
* __vector of negative integers__: specifying the losers
* __character vector__: naming the keepers


```r
w
#> [1] -0.63  0.18 -0.84  1.60  0.33 -0.82  0.49  0.74
names(w) <- letters[seq_along(w)]
w
#>     a     b     c     d     e     f     g     h 
#> -0.63  0.18 -0.84  1.60  0.33 -0.82  0.49  0.74
w < 0
#>     a     b     c     d     e     f     g     h 
#>  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE
which(w < 0)
#> a c f 
#> 1 3 6
w[w < 0]
#>     a     c     f 
#> -0.63 -0.84 -0.82
seq(from = 1, to = length(w), by = 2)
#> [1] 1 3 5 7
w[seq(from = 1, to = length(w), by = 2)]
#>     a     c     e     g 
#> -0.63 -0.84  0.33  0.49
w[-c(2, 5)]
#>     a     c     d     f     g     h 
#> -0.63 -0.84  1.60 -0.82  0.49  0.74
w[c('c', 'a', 'f')]
#>     c     a     f 
#> -0.84 -0.63 -0.82
```

## lists hold just about anything

Lists are basically über-vectors in R. It's like a vector, but with no requirement that the elements be of the same flavor. In data analysis, you won't make lists very often, at least not consciously, but you should still know about them. Why?

* data.frames are lists! They are a special case where each element is an atomic vector, all having the same length.
* many functions will return lists to you and you will want to extract goodies from them, such as the p-value for a hypothesis test or the estimated error variance in a regression model

Here we repeat an assignment from above, using `list()` instead of `c()` to combine things and you'll notice that the different flavors of the constituent parts are retained this time.

```r
## earlier: a <- c("cabbage", pi, TRUE, 4.3)
(a <- list("cabbage", pi, TRUE, 4.3))
#> [[1]]
#> [1] "cabbage"
#> 
#> [[2]]
#> [1] 3.14
#> 
#> [[3]]
#> [1] TRUE
#> 
#> [[4]]
#> [1] 4.3
str(a)
#> List of 4
#>  $ : chr "cabbage"
#>  $ : num 3.14
#>  $ : logi TRUE
#>  $ : num 4.3
length(a)
#> [1] 4
mode(a)
#> [1] "list"
class(a)
#> [1] "list"
```

List components can also have names. You can create or change names after a list already exists or this can be integrated into the initial assignment.

```r
names(a)
#> NULL
names(a) <- c("veg", "dessert", "myAim", "number")
a
#> $veg
#> [1] "cabbage"
#> 
#> $dessert
#> [1] 3.14
#> 
#> $myAim
#> [1] TRUE
#> 
#> $number
#> [1] 4.3
a <- list(veg = "cabbage", dessert = pi, myAim = TRUE, number = 4.3)
names(a)
#> [1] "veg"     "dessert" "myAim"   "number"
```

Indexing a list is similar to indexing a vector but it is necessarily more complex. The fundamental issue is this: if you request a single element from the list, do you want a list of length 1 containing only that element or do you want the element itself? For the former (desired return value is a list), we use single square brackets, `[` and `]`, just like indexing a vector. For the latter (desired return value is a single element), we use a dollar sign `$`, which you've already used to get one variable from a data.frame, or double square brackets, `[[` and `]]`.

The ["pepper shaker photos" in R for Data Science][r4ds-pepper-shaker] are a splendid visual explanation of the different ways to get stuff out of a list. Highly recommended.

> Warning: the rest of this section might make your eyes glaze over. Skip to the next section if you need to; come back later when some list is ruining your day.

A slightly more complicated list will make our demos more educational. Now we really see that the elements can differ in flavor and length.


```r
(a <- list(veg = c("cabbage", "eggplant"),
           tNum = c(pi, exp(1), sqrt(2)),
           myAim = TRUE,
           joeNum = 2:6))
#> $veg
#> [1] "cabbage"  "eggplant"
#> 
#> $tNum
#> [1] 3.14 2.72 1.41
#> 
#> $myAim
#> [1] TRUE
#> 
#> $joeNum
#> [1] 2 3 4 5 6
str(a)
#> List of 4
#>  $ veg   : chr [1:2] "cabbage" "eggplant"
#>  $ tNum  : num [1:3] 3.14 2.72 1.41
#>  $ myAim : logi TRUE
#>  $ joeNum: int [1:5] 2 3 4 5 6
length(a)
#> [1] 4
class(a)
#> [1] "list"
mode(a)
#> [1] "list"
```

Here's are ways to get a single list element:

```r
a[[2]] # index with a positive integer
#> [1] 3.14 2.72 1.41
a$myAim # use dollar sign and element name
#> [1] TRUE
str(a$myAim) # we get myAim itself, a length 1 logical vector
#>  logi TRUE
a[["tNum"]] # index with length 1 character vector 
#> [1] 3.14 2.72 1.41
str(a[["tNum"]]) # we get tNum itself, a length 3 numeric vector
#>  num [1:3] 3.14 2.72 1.41
iWantThis <- "joeNum" # indexing with length 1 character object
a[[iWantThis]] # we get joeNum itself, a length 5 integer vector
#> [1] 2 3 4 5 6
a[[c("joeNum", "veg")]] # does not work! can't get > 1 elements! see below
#> Error in a[[c("joeNum", "veg")]]: subscript out of bounds
```
A case when one must use the double bracket approach, as opposed to the dollar sign, is when the indexing object itself is an R object; we show that above.

What if you want more than one element? You must index vector-style with single square brackets. Note that the return value will always be a list, unlike the return value from double square brackets, even if you only request 1 element.


```r
names(a)
#> [1] "veg"    "tNum"   "myAim"  "joeNum"
a[c("tNum", "veg")] # indexing by length 2 character vector
#> $tNum
#> [1] 3.14 2.72 1.41
#> 
#> $veg
#> [1] "cabbage"  "eggplant"
str(a[c("tNum", "veg")]) # returns list of length 2
#> List of 2
#>  $ tNum: num [1:3] 3.14 2.72 1.41
#>  $ veg : chr [1:2] "cabbage" "eggplant"
a["veg"] # indexing by length 1 character vector
#> $veg
#> [1] "cabbage"  "eggplant"
str(a["veg"])# returns list of length 1
#> List of 1
#>  $ veg: chr [1:2] "cabbage" "eggplant"
length(a["veg"]) # really, it does!
#> [1] 1
length(a["veg"][[1]]) # contrast with length of the veg vector itself
#> [1] 2
```

## Creating a data.frame explicitly

In data analysis, we often import data into data.frame via `read.table()`. But one can also construct a data.frame directly using `data.frame()`.


```r
n <- 8
set.seed(1)
(jDat <- data.frame(w = round(rnorm(n), 2),
                    x = 1:n,
                    y = I(LETTERS[1:n]),
                    z = runif(n) > 0.3,
                    v = rep(LETTERS[9:12], each = 2)))
#>       w x y     z v
#> 1 -0.63 1 A  TRUE I
#> 2  0.18 2 B  TRUE I
#> 3 -0.84 3 C  TRUE J
#> 4  1.60 4 D  TRUE J
#> 5  0.33 5 E  TRUE K
#> 6 -0.82 6 F FALSE K
#> 7  0.49 7 G  TRUE L
#> 8  0.74 8 H FALSE L
str(jDat)
#> 'data.frame':	8 obs. of  5 variables:
#>  $ w: num  -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
#>  $ x: int  1 2 3 4 5 6 7 8
#>  $ y: 'AsIs' chr  "A" "B" "C" "D" ...
#>  $ z: logi  TRUE TRUE TRUE TRUE TRUE FALSE ...
#>  $ v: chr  "I" "I" "J" "J" ...
mode(jDat)
#> [1] "list"
class(jDat)
#> [1] "data.frame"
```

> Sidebar: What is `I()`, used when creating the variable $y$ in the above data.frame? Short version: it tells R to do something _quite literally_. Here we are protecting the letters from being coerced to factor. We are ensuring we get a character vector. Note we let character-to-factor conversion happen in creating the $v$ variable above. More about (foiling) R's determination to convert character data to factor can be found [here](#factors-boss).


data.frames really are lists! Double square brackets can be used to get individual variables. Single square brackets can be used to get one or more variables, returned as a data.frame (though `subset(..., select = ...))` is how I would more likely do in a data analysis).


```r
is.list(jDat) # data.frames are lists
#> [1] TRUE
jDat[[5]] # this works but I prefer ...
#> [1] "I" "I" "J" "J" "K" "K" "L" "L"
jDat$v # using dollar sign and name, when possible
#> [1] "I" "I" "J" "J" "K" "K" "L" "L"
jDat[c("x", "z")] # get multiple variables
#>   x     z
#> 1 1  TRUE
#> 2 2  TRUE
#> 3 3  TRUE
#> 4 4  TRUE
#> 5 5  TRUE
#> 6 6 FALSE
#> 7 7  TRUE
#> 8 8 FALSE
str(jDat[c("x", "z")]) # returns a data.frame
#> 'data.frame':	8 obs. of  2 variables:
#>  $ x: int  1 2 3 4 5 6 7 8
#>  $ z: logi  TRUE TRUE TRUE TRUE TRUE FALSE ...
identical(subset(jDat, select = c(x, z)), jDat[c("x", "z")])
#> [1] TRUE
```

> Question: How do I make a data.frame from a list? It is an absolute requirement that the constituent vectors have the same length, although they can be of different flavors. Assuming you meet that requirement, use `as.data.frame()` to convert.


```r
## note difference in the printing of a list vs. a data.frame
(qDat <- list(w = round(rnorm(n), 2),
              x = 1:(n-1), ## <-- LOOK HERE! I MADE THIS VECTOR SHORTER!
              y = I(LETTERS[1:n])))
#> $w
#> [1] -0.62 -2.21  1.12 -0.04 -0.02  0.94  0.82  0.59
#> 
#> $x
#> [1] 1 2 3 4 5 6 7
#> 
#> $y
#> [1] "A" "B" "C" "D" "E" "F" "G" "H"
as.data.frame(qDat) ## does not work! elements don't have same length!
#> Error in (function (..., row.names = NULL, check.rows = FALSE, check.names = TRUE, : arguments imply differing number of rows: 8, 7
qDat$x <- 1:n ## fix the short variable x
(qDat <- as.data.frame(qDat)) ## we're back in business
#>       w x y
#> 1 -0.62 1 A
#> 2 -2.21 2 B
#> 3  1.12 3 C
#> 4 -0.04 4 D
#> 5 -0.02 5 E
#> 6  0.94 6 F
#> 7  0.82 7 G
#> 8  0.59 8 H
```

You will encounter weirder situations in which you want to make a data.frame out of a list and there are many tricks. Ask me and we'll beef up this section.

## Indexing arrays, e.g. matrices

Though data.frames are recommended as the default receptacle for rectangular data, there are times when one will store rectangular data as a matrix instead. A matrix is a generalization of an atomic vector and the requirement that all the elements be of the same flavor still holds. General arrays are available in R, where a matrix is an important special case having dimension 2.

Let's make a simple matrix and give it decent row and column names, which we know is a good practice. You'll see familiar or self-explanatory functions below for getting to know a matrix.


```r
## don't worry if the construction of this matrix confuses you; just focus on
## the product
jMat <- outer(as.character(1:4), as.character(1:4),
              function(x, y) {
                paste0('x', x, y)
                })
jMat
#>      [,1]  [,2]  [,3]  [,4] 
#> [1,] "x11" "x12" "x13" "x14"
#> [2,] "x21" "x22" "x23" "x24"
#> [3,] "x31" "x32" "x33" "x34"
#> [4,] "x41" "x42" "x43" "x44"
str(jMat)
#>  chr [1:4, 1:4] "x11" "x21" "x31" "x41" ...
class(jMat)
#> [1] "matrix" "array"
mode(jMat)
#> [1] "character"
dim(jMat)
#> [1] 4 4
nrow(jMat)
#> [1] 4
ncol(jMat)
#> [1] 4
rownames(jMat)
#> NULL
rownames(jMat) <- paste0("row", seq_len(nrow(jMat)))
colnames(jMat) <- paste0("col", seq_len(ncol(jMat)))
dimnames(jMat) # also useful for assignment
#> [[1]]
#> [1] "row1" "row2" "row3" "row4"
#> 
#> [[2]]
#> [1] "col1" "col2" "col3" "col4"
jMat
#>      col1  col2  col3  col4 
#> row1 "x11" "x12" "x13" "x14"
#> row2 "x21" "x22" "x23" "x24"
#> row3 "x31" "x32" "x33" "x34"
#> row4 "x41" "x42" "x43" "x44"
```

Indexing a matrix is very similar to indexing a vector or a list: use square brackets and index with logical, integer numeric (positive or negative), or character vectors. Combine those approaches if you like! The main new wrinkle is the use of a comma `,` to distinguish rows and columns. The $i,j$-th element is the element at the intersection of row $i$ and column $j$ and is obtained with `jMat[i, j]`. Request an entire row or an entire column by simply leaving the associated index empty. The `drop =` argument controls whether the return value should be an atomic vector (`drop = TRUE`) or a matrix with a single row or column (`drop = FALSE`). Notice how row and column names persist and can help you stay oriented.


```r
jMat[2, 3]
#> [1] "x23"
jMat[2, ] # getting row 2
#>  col1  col2  col3  col4 
#> "x21" "x22" "x23" "x24"
is.vector(jMat[2, ]) # we get row 2 as an atomic vector
#> [1] TRUE
jMat[ , 3, drop = FALSE] # getting column 3
#>      col3 
#> row1 "x13"
#> row2 "x23"
#> row3 "x33"
#> row4 "x43"
dim(jMat[ , 3, drop = FALSE]) # we get column 3 as a 4 x 1 matrix
#> [1] 4 1
jMat[c("row1", "row4"), c("col2", "col3")]
#>      col2  col3 
#> row1 "x12" "x13"
#> row4 "x42" "x43"
jMat[-c(2, 3), c(TRUE, TRUE, FALSE, FALSE)] # wacky but possible
#>      col1  col2 
#> row1 "x11" "x12"
#> row4 "x41" "x42"
```

Under the hood, of course, matrices are just vectors with some extra facilities for indexing. R is a [column-major order][wiki-row-col-major-order] language, in contrast to C and Python which use row-major order. What this means is that in the underlying vector storage of a matrix, the columns are stacked up one after the other. Matrices can be indexed *exactly* like a vector, i.e. with no comma $i,j$ business, like so:

```r
jMat[7]
#> [1] "x32"
jMat
#>      col1  col2  col3  col4 
#> row1 "x11" "x12" "x13" "x14"
#> row2 "x21" "x22" "x23" "x24"
#> row3 "x31" "x32" "x33" "x34"
#> row4 "x41" "x42" "x43" "x44"
```
How to understand this: start counting in the upper left corner, move down the column, continue  from the top of column 2 and you'll land on the element "x32" when you get to 7.

If you have meaningful, systematic row or column names, there are many possibilities for indexing via regular expressions. Maybe we will talk about `grep` later....

```r
jMat[1, grepl("[24]", colnames(jMat))]
#>  col2  col4 
#> "x12" "x14"
```

Note also that one can put an indexed matrix on the receiving end of an assignment operation and, as long as your replacement values have valid shape or extent, you can change the matrix.

```r
jMat["row1", 2:3] <- c("HEY!", "THIS IS NUTS!")
jMat
#>      col1  col2   col3            col4 
#> row1 "x11" "HEY!" "THIS IS NUTS!" "x14"
#> row2 "x21" "x22"  "x23"           "x24"
#> row3 "x31" "x32"  "x33"           "x34"
#> row4 "x41" "x42"  "x43"           "x44"
```

Note that R can also work with vectors and matrices in the proper mathematical sense, i.e. perform matrix algebra. That is a separate topic. To get you started, read the help on `%*%` for matrix multiplication....

## Creating arrays, e.g. matrices

There are three main ways to create a matrix. It goes without saying that the inputs must comply with the requirement that all matrix elements are the same flavor. If that's not true, you risk an error or, worse, silent conversion to character.

* Filling a matrix with a vector
* Glueing vectors together as rows or columns
* Conversion of a data.frame

Let's demonstrate. Here we fill a matrix with a vector, explore filling by rows and giving row and columns at creation. Notice that recycling happens here too, so if the input vector is not large enough, R will recycle it.


```r
matrix(1:15, nrow = 5)
#>      [,1] [,2] [,3]
#> [1,]    1    6   11
#> [2,]    2    7   12
#> [3,]    3    8   13
#> [4,]    4    9   14
#> [5,]    5   10   15
matrix("yo!", nrow = 3, ncol = 6)
#>      [,1]  [,2]  [,3]  [,4]  [,5]  [,6] 
#> [1,] "yo!" "yo!" "yo!" "yo!" "yo!" "yo!"
#> [2,] "yo!" "yo!" "yo!" "yo!" "yo!" "yo!"
#> [3,] "yo!" "yo!" "yo!" "yo!" "yo!" "yo!"
matrix(c("yo!", "foo?"), nrow = 3, ncol = 6)
#>      [,1]   [,2]   [,3]   [,4]   [,5]   [,6]  
#> [1,] "yo!"  "foo?" "yo!"  "foo?" "yo!"  "foo?"
#> [2,] "foo?" "yo!"  "foo?" "yo!"  "foo?" "yo!" 
#> [3,] "yo!"  "foo?" "yo!"  "foo?" "yo!"  "foo?"
matrix(1:15, nrow = 5, byrow = TRUE)
#>      [,1] [,2] [,3]
#> [1,]    1    2    3
#> [2,]    4    5    6
#> [3,]    7    8    9
#> [4,]   10   11   12
#> [5,]   13   14   15
matrix(1:15, nrow = 5,
       dimnames = list(paste0("row", 1:5),
                       paste0("col", 1:3)))
#>      col1 col2 col3
#> row1    1    6   11
#> row2    2    7   12
#> row3    3    8   13
#> row4    4    9   14
#> row5    5   10   15
```

Here we create a matrix by glueing vectors together. Watch the vector names propagate as row or column names.


```r
vec1 <- 5:1
vec2 <- 2^(1:5)
cbind(vec1, vec2)
#>      vec1 vec2
#> [1,]    5    2
#> [2,]    4    4
#> [3,]    3    8
#> [4,]    2   16
#> [5,]    1   32
rbind(vec1, vec2)
#>      [,1] [,2] [,3] [,4] [,5]
#> vec1    5    4    3    2    1
#> vec2    2    4    8   16   32
```

Here we create a matrix from a data.frame.


```r
vecDat <- data.frame(vec1 = 5:1,
                     vec2 = 2^(1:5))
str(vecDat)
#> 'data.frame':	5 obs. of  2 variables:
#>  $ vec1: int  5 4 3 2 1
#>  $ vec2: num  2 4 8 16 32
vecMat <- as.matrix(vecDat)
str(vecMat)
#>  num [1:5, 1:2] 5 4 3 2 1 2 4 8 16 32
#>  - attr(*, "dimnames")=List of 2
#>   ..$ : NULL
#>   ..$ : chr [1:2] "vec1" "vec2"
```

Here we create a matrix from a data.frame, but experience the "silently convert everything to character" fail. As an added bonus, I'm also allowing the "convert character to factor" thing to happen when we create the data.frame initially. Let this be a reminder to take control of your objects!


```r
multiDat <- data.frame(vec1 = 5:1,
                       vec2 = paste0("hi", 1:5))
str(multiDat)
#> 'data.frame':	5 obs. of  2 variables:
#>  $ vec1: int  5 4 3 2 1
#>  $ vec2: chr  "hi1" "hi2" "hi3" "hi4" ...
(multiMat <- as.matrix(multiDat))
#>      vec1 vec2 
#> [1,] "5"  "hi1"
#> [2,] "4"  "hi2"
#> [3,] "3"  "hi3"
#> [4,] "2"  "hi4"
#> [5,] "1"  "hi5"
str(multiMat)
#>  chr [1:5, 1:2] "5" "4" "3" "2" ...
#>  - attr(*, "dimnames")=List of 2
#>   ..$ : NULL
#>   ..$ : chr [1:2] "vec1" "vec2"
```

## Putting it all together...implications for data.frames

This behind the scenes tour is still aimed at making you a better data analyst. Hopefully the slog through vectors, matrices, and lists will be redeemed by greater prowess at manipulating data.frames. Why should this be true?

* a data.frame is a *list*
* the list elements are the variables and they are *atomic vectors*
* data.frames are rectangular, like their matrix friends, so your intuition -- and even some syntax -- can be borrowed from the matrix world

A data.frame is a list that quacks like a matrix.

Reviewing list-style indexing of a data.frame:

```r
jDat
#>       w x y     z v
#> 1 -0.63 1 A  TRUE I
#> 2  0.18 2 B  TRUE I
#> 3 -0.84 3 C  TRUE J
#> 4  1.60 4 D  TRUE J
#> 5  0.33 5 E  TRUE K
#> 6 -0.82 6 F FALSE K
#> 7  0.49 7 G  TRUE L
#> 8  0.74 8 H FALSE L
jDat$z
#> [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE
iWantThis <- "z"
jDat[[iWantThis]]
#> [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE
str(jDat[[iWantThis]]) # we get an atomic vector
#>  logi [1:8] TRUE TRUE TRUE TRUE TRUE FALSE ...
```

Reviewing vector-style indexing of a data.frame:

```r
jDat["y"]
#>   y
#> 1 A
#> 2 B
#> 3 C
#> 4 D
#> 5 E
#> 6 F
#> 7 G
#> 8 H
str(jDat["y"]) # we get a data.frame with one variable, y
#> 'data.frame':	8 obs. of  1 variable:
#>  $ y: 'AsIs' chr  "A" "B" "C" "D" ...
iWantThis <- c("w", "v")
jDat[iWantThis] # index with a vector of variable names
#>       w v
#> 1 -0.63 I
#> 2  0.18 I
#> 3 -0.84 J
#> 4  1.60 J
#> 5  0.33 K
#> 6 -0.82 K
#> 7  0.49 L
#> 8  0.74 L
str(jDat[c("w", "v")])
#> 'data.frame':	8 obs. of  2 variables:
#>  $ w: num  -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
#>  $ v: chr  "I" "I" "J" "J" ...
str(subset(jDat, select = c(w, v))) # using subset() function
#> 'data.frame':	8 obs. of  2 variables:
#>  $ w: num  -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
#>  $ v: chr  "I" "I" "J" "J" ...
```

Demonstrating matrix-style indexing of a data.frame:

```r
jDat[ , "v"]
#> [1] "I" "I" "J" "J" "K" "K" "L" "L"
str(jDat[ , "v"])
#>  chr [1:8] "I" "I" "J" "J" ...
jDat[ , "v", drop = FALSE]
#>   v
#> 1 I
#> 2 I
#> 3 J
#> 4 J
#> 5 K
#> 6 K
#> 7 L
#> 8 L
str(jDat[ , "v", drop = FALSE])
#> 'data.frame':	8 obs. of  1 variable:
#>  $ v: chr  "I" "I" "J" "J" ...
jDat[c(2, 4, 7), c(1, 4)] # awful and arbitrary but syntax works
#>      w    z
#> 2 0.18 TRUE
#> 4 1.60 TRUE
#> 7 0.49 TRUE
jDat[jDat$z, ]
#>       w x y    z v
#> 1 -0.63 1 A TRUE I
#> 2  0.18 2 B TRUE I
#> 3 -0.84 3 C TRUE J
#> 4  1.60 4 D TRUE J
#> 5  0.33 5 E TRUE K
#> 7  0.49 7 G TRUE L
subset(jDat, subset = z)
#>       w x y    z v
#> 1 -0.63 1 A TRUE I
#> 2  0.18 2 B TRUE I
#> 3 -0.84 3 C TRUE J
#> 4  1.60 4 D TRUE J
#> 5  0.33 5 E TRUE K
#> 7  0.49 7 G TRUE L
```

## Table of atomic R object flavors

> This table will be hideous unless Pandoc is used to compile.

+-----------+---------------+-----------+-----------+
| "flavor"  | type reported | mode()    | class()   |
|           | by typeof()   |           |           |
+===========+===============+===========+===========+
| character | character     | character | character |
+-----------+---------------+-----------+-----------+
| logical   | logical       | logical   | logical   |
+-----------+---------------+-----------+-----------+
| numeric   | integer       | numeric   | integer   |
|           | or double     |           | or double |
+-----------+---------------+-----------+-----------+
| factor    | integer       | numeric   | factor    |
+-----------+---------------+-----------+-----------+

> This should be legible no matter what.

```
+-----------+---------------+-----------+-----------+
| "flavor"  | type reported | mode()    | class()   |
|           | by typeof()   |           |           |
+===========+===============+===========+===========+
| character | character     | character | character |
+-----------+---------------+-----------+-----------+
| logical   | logical       | logical   | logical   |
+-----------+---------------+-----------+-----------+
| numeric   | integer       | numeric   | integer   |
|           | or double     |           | or double |
+-----------+---------------+-----------+-----------+
| factor    | integer       | numeric   | factor    |
+-----------+---------------+-----------+-----------+
```

Thinking about objects according to the flavors above will work fairly well for most purposes most of the time, at least when you're first getting started. Notice that most rows in the table are quite homogeneous, i.e. a logical vector is a logical vector is a logical vector. But the row pertaining to factors is an exception, which highlights the special nature of factors. (for more, go [here](#factors-boss)).

<!--JB:
> JB note to self. Possible TO ADD but probably belongs in separate tutorial on changing and adding to data.frames: cbind and rbind with data.frames, transform(). do.call() tricks for data.frames. adding/removing variables to/from data.frames. Does this belong in earlier tutorial on the care and feeding of a data.frame? Fits in well with subset(), after all.
-->



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
