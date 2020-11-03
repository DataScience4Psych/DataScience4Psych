#ggplot is very well documented online, eg:
# https://r4ds.had.co.nz/data-visualisation.html
# https://ggplot2.tidyverse.org/index.html
# https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

# install.packages("ggplot")
library(ggplot2)

load("C:\\Users\\ytzhao\\Desktop\\Mike's Psychometrics\\In-class data\\panasmerged.Rdata")
pdat<- panasmerged

########## 
# Some basics on making a plot (eg histogtam)

# "Base" R plot function, for comparison
hist(pdat$pa)

#Using ggplot2
ggplot(data = pdat, aes(x=pa)) + 
  geom_histogram()               # produces a histogram of PA values

#if you want to create an object
h <- ggplot(data = pdat, aes(x=pa)) + 
     geom_histogram()               
h    

# the "aes" statement links variables with "aesthetics", things like
# what goes on the x-axis, y-axis, or whether you want a variable's levels
# to differ by color (e,g, in bar graph) or size (e,g. in scatterploot)

# you need to add "geom" layers, to specify the particular type of plot to create 
# and which plot elements to add. 
# A geom is the geometrical object that a plot uses to represent data (e.g., line, bar, points, etc)

# Once you get the basic layout, can start tinkering with colors, labels, axes, etc 
h <- ggplot(pdat, aes(x=pa)) + 
  geom_histogram(fill="gray", binwidth=.100, col="black") + 
  labs(x="Positive Affect", y="Count") + 
  xlim(c(1,5)) +
  ylim(c(0,100)) +
  geom_vline(aes(xintercept=mean(pa)), color="darkgrey", linetype="dashed", size=1) +
  ggtitle("Distribution of Positive Affect Scores") +
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  annotate("text", 
           x = 1, 
           y = c(100,90), 
           hjust=0, 
           label = c( paste("Std Dev of PA ", format(sd(pdat$pa), digits=2) ), 
                      paste("Mean of PA = ", format(mean(pdat$pa), digits=3) )  ) )
h

#Could build this piece by piece:
h <- ggplot(pdat, aes(pa)) +  geom_histogram(fill="gray", binwidth=.100, col="black")  
h
h <- h +  labs(x="Positive Affect", y="Count")  
h
h <- h + xlim(c(1,5)) + ylim(c(0,100)) 
h
#and so on


# So again, you can use different geoms 
# to reflect different things (bars for 1 vbl vs points/lines for 2 vars)
# or to potentially to reflect the same thing in different ways
ggplot(data = pdat) + 
  geom_point(mapping = aes(x = pa, y = na))

ggplot(data = pdat) + 
  geom_smooth(mapping = aes(x = pa, y = na))

# Can combine some geoms in one plot: 
ggplot(data = pdat) + 
  geom_point(mapping = aes(x = pa, y = na))+ 
  geom_smooth(mapping = aes(x = pa, y = na))
#OR
ggplot(data = pdat, aes(x = pa, y = na)) + 
  geom_point()+ 
  geom_smooth()

# example of "mapping the color aesthetic" onto the levels of a variable
ggplot(data = pdat, aes(x = pa, y = na, color=sexcat)) + 
  geom_point(position="jitter") 


#########################
# Faceting

#  One of the really cool things about ggplot is "faceting"
# this creates a plot for each level of one (or more) 
# categorical variables (eg sex) 

# eg, a PA-NA scatterplot, separate gor each level of sex
ggplot(data = pdat) + 
  geom_point(mapping = aes(x = pa, y = na)) + 
  facet_wrap(~ sexcat)
#or
ggplot(data = pdat) + 
  geom_point(mapping = aes(x = pa, y = na)) + 
  facet_wrap(~ sexcat, nrow = 2)
# or for combinations of 2 categorical vbls, use facet_grid
ggplot(data = pdat) + 
  geom_point(mapping = aes(x = pa, y = na)) + 
  facet_grid(sescat ~ sexcat)

# once you get the basic layout, can start tinkering with colors, background, etc

ggplot(data = pdat) + 
  geom_point(mapping = aes(x = pa, y = na), position="jitter") + 
  facet_grid(sescat ~ sexcat)+ 
  theme(panel.background = element_rect(fill = 'white', colour = 'black')) +
  labs(x="Positive Affect", y="Negative Affect")
# and so on...  

########
#  Using marginal plots (via ggExtra() )

# Another cool feature is being able to add marginal plots

# install.packages("ggExtra")
library(ggExtra)

g <- ggplot(data=pdat, aes(x=pa, y=na)) + 
  geom_point(position="jitter")
g
ggMarginal(g, type = "histogram", fill="transparent")
#ggMarginal(g, type = "boxplot", fill="transparent")  



########
# Bar graphs for frequencies

ggplot(data = pdat) + 
  geom_bar(mapping = aes(x = sescat))

# mapping "fill" to another variable
ggplot(data = pdat) + 
  geom_bar(mapping = aes(x = sescat, fill = sexcat))
# or again using facet_wrap
ggplot(data = pdat) + 
 geom_bar(mapping = aes(x = sescat)) + 
 facet_wrap(~ sexcat, nrow = 2)


###################################
#Bar graph of means 
ggplot(data=pdat, aes(x=sescat, y=pa)) +
  geom_bar(stat = "summary", fun = "mean", fill = "white")+
  geom_errorbar(stat = "summary", fun.data="mean_se")

ggplot(data=pdat, aes(x=sescat,y=pa))+
  stat_summary(fun="mean", geom = "bar", fill="white")+
  stat_summary(fun.data + mean_se, geom = "errorbar")

# Alternatively, compute stats first and then add to the plot.

#A fairly simple one#
mns <- aggregate(pa ~ sescat, pdat, FUN=mean )  # first, compute the means for each group
mns

ggplot(mns, aes(x = factor(sescat), y = pa)) + 
       geom_bar(stat = "identity")

##Note from ggplot: 
# The heights of the bars commonly represent one of two things: 
# either a count of cases in each group, or the values in a column 
# of the data frame. 
# By default, geom_bar uses stat="bin". This makes the height of each 
# bar equal to the number of cases in each group....
# If you want the heights of the bars to represent values in the data, 
# use stat="identity" and map a value to the y aesthetic.


# A more involved one, with 3 factors and error bars
#install.packages("Rmisc")
library(Rmisc)
mns2 <- summarySE(pdat, measurevar="pa", groupvars=c("sexcat", "sescat"), na.rm=TRUE)
mns2

ggplot(mns2, aes(x = factor(sescat), y = pa, fill=sexcat)) + 
  geom_bar(position=position_dodge(),stat = "identity", colour="black") +
  geom_errorbar(aes(ymin=pa-ci, ymax=pa+ci), width=.3, color="darkblue",  position=position_dodge(.9)) +
  scale_fill_hue(name="Sex") +
  scale_y_continuous( name="Positive Affect", limits=c(0,5)) +
  scale_x_discrete(name = "SES Group", limits=c("Poor","Low SES", "Mod SES", "High SES"))   #gets ses categories in desired (non alphbetic) order



