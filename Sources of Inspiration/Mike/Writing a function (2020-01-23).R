######################################################################################
## Creating your own functions
## 
## This may not ever be necessary, but it can be extermely useful (e.g., if your analysis or 
## data manipluation are tricky, or if you need to do somethine repetitively)
###########################################################################################

####################################### 
### The general structure of a function 

# A function includes syntax to perform specific operations (E.g., computing a mean)
# Elements include:
# 1 Function name
# 2 Arguments (required and optional, potentially with default values/settings)
# 3 Syntax to perform the operations, working with the relevant arguments
#   This can be simple or incredibly extensive/complex
# 4 Syntax that will "return" (ie report, print to screen) any output 

# To see the code/syntax "inside" an existing function, 
# you can often simply type the function name (with no arguments) 
# and run it
rowMeans
# This doesn't work well for all functions. 
# Sometimes you have to do a bit more, and even then the R syntax
# might simply refer to a related function written in the comp language C
# If you want to learn more about that, you can later run these lines of code:
# mean
# methods(mean)
# getAnywhere(mean)
# getAnywhere(mean.default) # note the "Internal(mean(X))" statement at end

############################################################ 
###   The general structure of syntax to create a function 

# functionname <- function(one or more arguments that are required or optional) {
#   * Syntax that tells function what to do (manipulations, calculations, etc).
#   * This should include the implementation of values supplied for any arguments
#     listed in the "function" statement above.
#   * Assuming that you want your function report some output, 
#     you need to have syntax that does so
# }


##################################
######  Examples 

# Simple - creating a function (called "add1") 
# that adds any two numbers and prints the result

add1 <- function(x, y)   {
  sum <- x + y  # uses values suppplied for the arguments to do the calculation
  sum           # prints the output to the screen
}

#This calls, uses the function to get a result:
add1(x=2, y=3)
add1(2,3)
add1(y=2, x=3) # note that the order doesn't matter for this function, but it can (e.g., a function for x-y)
add1(1000, 3*4)
add1(2)   # note the error message

# Somewhat fancier output, to show more of what can be done in retuning output
add2 <- function(x, y)   {
  sum <- x + y
  print(paste("Hey there, the sum of", x, "and", y, "is", sum, "!"))
}
add2(2,3)

# Setting a default value for an argument
add3 <- function(x, y=10)   {
  sum <- x + y
  print(paste("Hey there, the sum of", x, "and", y, "is", sum, "!"))
}
add3(3, 2) # what'll happen?  
add3(x=3)  # what'll happen?
add3(3)    # what'll happen?
add3()     # what'll happen?

#####################################################################

#More useful, Using a function on data in a data set
load("C:\\Users\\furrrm\\M Furr\\Classes\\R\\R lectures\\Basic functions\\panasmerged.Rdata")
pdat<- panasmerged

#use the frunction to create a new variable in the pdat data set
pdat$sum12 <- add1(pdat$panas01, pdat$panas02)
# To Verify that it worked correctly
head(pdat[,c("panas01", "panas02", "sum12")])

#######################################################################33

# Let's do something a bit more complicated, again to show some of the capability
# We'll use existing functions within a new function 

# Function to print the cases with the 10 highest and 10 Lowest scores on a variable of interest
# ****** note that this returns/prints multiple pieces of output *****

highlow <- function(x)  {
  library(dplyr)                   # the new function will use commands from dplyr package, so load it
  pdat2 <- select_(pdat, "ID", x)  # keeps only ID and the vbl of interest
  pdat2 <- arrange_(pdat2, x)      # sorts the data in order of scores on the vbl
  print(paste("10 Lowest scores on", x))        # prints info re subsequent output
  print(head(pdat2, 10))           # prints output - 10 highes scores on vbl
  print(paste("10 Highest scores on", x))       # prints info re subsequent output
  print(tail(pdat2, 10))           # prints output - 10 highes scores on vbl
}

highlow("na")
highlow("pa")

###################################################################################3

#BElow are other versions of this, probably not worth worrying about at this point:

highlow <- function(x)  {
  High <-  pdat[order(-x),]
  Low <- pdat[order(x),]
  print("10 Lowest scores")
  print(head(Low, 10))
  print("10 Highest scores")
  print(head(High, 10))
}
highlow(pdat$panas01)




#Does same thing, but keeps only ID and the vbl in question
highlow2 <- function(x)  {
  pdat2<- pdat[,c("ID", x)]
  Low <- pdat2[order(pdat2[2]),]
  High <- pdat2[order(-pdat2[2]),]
  print("10 Lowest scores")
  print(head(Low, 10))
  print("10 Highest scores")
  print(head(High, 10))
}
highlow2("panas01")

# To see the syntax "inside" an existing function, just type the function name, eg:
cor

