##################################################################################
# More basic data procedures
#
#    Import SPSS, Import Excel
#    Compute scale scores
#    Create new variables based on values of old variables
#    Crosstabs
#    Merging, sorting, subsetting (specific columns and/or specfic rows)
#    REnaming variables
#    Some desriptives by group
#    Saving and loading an R data frame
##################################################################################

setwd("C:/Users/ytzhao/Desktop/Mike's Psychometrics/In-class data")
library(foreign)
panas <- read.spss("panaswithID.sav",to.data.frame=TRUE, use.value.labels=FALSE)

#compute scale scores
panas$pa <- rowMeans(panas[, c("panas02", "panas05", "panas07", "panas08", "panas11", "panas12", "panas13","panas15", "panas17", "panas18")], 
                     na.rm=TRUE)
panas$na <- rowMeans(panas[, c("panas01", "panas03", "panas04", "panas06", "panas09", "panas10", "panas14", "panas16", "panas19", "panas20")], 
                     na.rm=TRUE)

table(panas$panas01) ################### freq table #################

# Import an excel file

####MF note 2019-12 - better to use readxl rather than xlsx
# install.packages("readxl")
library(readxl)

?read_xlsx
demo <- read_xlsx("C:/Users/ytzhao/Desktop/Mike's Psychometrics/In-class data/Demo for panas.xlsx", sheet="Data") # this may have stopped being maintained
# still useful, e.g., can grap one of the sheets in excel

names(demo)
head(demo)
tail(demo)

# The syntax above created a data frame with the demographic data itself. 
# The syntax below creates a data frame with the "value labels" (in SPSS parlance)
demovals <- read_xlsx("C:/Users/ytzhao/Desktop/Mike's Psychometrics/In-class data/Demo for panas.xlsx", sheet="Value labels")
demovals <- as.data.frame(demovals) # translate the object into a data.frame
names(demovals) #prints the names of the variables in the demo data set
View(demovals)

#############################################################################
## Creating new variables, based on values of existing variables

# There are many reasons you might want to do this
# For our immediate purposes, 2 reasons:
#  1. We'll create "Factor" variables, which  can be used in certain ways (later) that numerical variables can't
#  2. R doesn't do well with variable labels, so here we create variables that have the SPSS labels as data

# here, create a new "factor" variable where values are the labels for sex. 

# change reference level.
?relevel
demo$Sex <- as.factor(demo$Sex)
levels(demo$Sex)
demo$Sex <- relevel(demo$Sex, ref = "0")

demo$sexcat <- ifelse(demo$Sex == 0, "Male", "Female")  ######### ifelse
demo$sexcat <- as.factor(demo$sexcat)
#note, you could do this in one line of code:
#demo$sexcat <- as.factor(ifelse(demo$Sex == 0, "Male", "Female"))
head(demo)
str(demo) ######### structure

# Here, create factor variable baesd on 4-level numerical variable 
demo$sescat <- demo$SESgrp
demo$sescat <- as.factor(demo$sescat)
levels(demo$sescat) <- c("Poor","Low SES","Mod SES","High SES")

# demo$sescat[demo$SESgrp == 0] <- "Poor"
# demo$sescat[demo$SESgrp == 1] <- "Low SES"
# demo$sescat[demo$SESgrp == 2] <- "Mod SES"
# demo$sescat[demo$SESgrp == 3] <- "High SES"
# demo$sescat <- as.factor(demo$sescat)
head(demo)
str(demo)


###################################################################
## Crosstabs - freqs and proportions

#Simple crosstabs table
table(demo$sexcat, demo$sescat)

#################### To get marginal values (row col totals)
table1 <- table(demo$sexcat, demo$sescat) #############3 create an object as output for further use
margin.table(table1, 1)  #note, "1" here refers to rows (telling R to compute freq for each row, across cols)
margin.table(table1, 2)  #note, "2" here refers to cols (telling R to compute freq for each col, across rows)
# 1 is row, 2 is col


# to get proportions
prop.table(table1)    # cell proportions, in relation to overall total
prop.table(table1, 1) # cell proportions, in relation to row total
prop.table(table1, 2) # cell proportions, in relation to col total

#As with many things in R, there are many ways to do the same task
#A good alternative to table (on the base package) is the crosstab function in the descr package
# install.packages("descr")
library(descr)
crosstab(demo$sescat, demo$sexcat) # proportions, the picture is cool! ####
crosstab(demo$sescat, demo$sexcat, dnn=c("SES", "Sex"), chisq=TRUE, prop.r=TRUE, prop.c=TRUE, prop.t=TRUE) # give you percentages for chi-square test

##################################################################################
#  Other data manipulation procedures (e.g., merging, renaming variables, sorting, subsetting)

#merging data frames
panasmerged <- merge(demo, panas, by="id")
#error? ID in one dataset, id in the other
names(panas)
names(demo)

#note that ID is capitalized in one file, but not the other. Rename so they match
# the dplyr package has a lot of convenient functions, including a rename function
# install.packages("dplyr")
library(dplyr)
panas <- rename(panas,ID=id)  #newname=oldname #######################3
#Alternatively, to rename using the base r functions (without relying on dplyr)
colnames(panas)[1] <-"ID" # u=I used this one before.

#now try merging again
panasmerged <- merge(demo, panas, by="ID")   #works!
head(panasmerged)

######### merge by multiple cols ######
# panasmerged <- merge(demo, panas, by=c("ID","sample")
# by.x = , by.y = ?

########## sort cases based on values of a given variable
# here, sorts teh panas dframe by descending values of pa and ascending values of na
panasmerged <- panasmerged[order(-panasmerged$pa, panasmerged$na),]   
panasmerged
head(panasmerged)

# to *keep* specifc columns (say, keep ID, pa, and na)
############# subset
panasmerged3 <- subset(panasmerged, select = c(ID, sescat, sexcat, pa, na) )
head(panasmerged3)

# to *drop* specific columns (say, drop item 19 and 20)
panasmerged2 <- subset(panasmerged, select = -c(panas19, panas20) )
head(panasmerged2)

#subset data based on values of a variable
fdata <- subset(panasmerged, sexcat == "Female" & pa <=2, select =  c(ID, sescat, sexcat, pa, na) )
fdata

#############################################################


#Common tasks - means by group
#Several different ways

aggregate(pa ~ sescat, panasmerged, FUN=mean )     # one dv one group vbls
aggregate(pa ~ sescat + sexcat, panasmerged, FUN=mean )     # one dv multiple group vbls
aggregate(cbind(pa, na) ~ sescat, panasmerged, mean ) # multiple dvs

tapply(X = panasmerged$pa, INDEX = panasmerged$sescat, mean ) # a function in the plyr package
tapply( panasmerged$pa, list(panasmerged$sescat, panasmerged$sexcat), mean ) 

by_sessex <- group_by(panasmerged, sexcat, sescat)                      # splits file by ses &  sex group, a plyr function
summarise(by_sessex, mean(pa, na.rm = TRUE), mean(na, na.rm=TRUE))  # avg pa an na, by ses group

#corr by group
summarise(by_sessex, cor(pa, na))  # corr bw pa and na, by ses & sex group

# To save a data frame in R
save(panasmerged, file="C:\\Users\\ytzhao\\Desktop\\Mike's Psychometrics\\In-class data\\panasmerged.Rdata")

#LAter, to load this data frame (e.g., for another script file, another analysis):
load("C:\\Users\\ytzhao\\Desktop\\Mike's Psychometrics\\In-class data\\panasmerged.Rdata")


# apa tables
# export output
??apaTables

  