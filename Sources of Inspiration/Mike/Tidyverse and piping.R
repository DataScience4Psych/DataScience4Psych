####################################################################
###### Tidyverse and piping
# 
# Tidyverse is a collection of packages, all of which "share an underlying design philosophy, grammar, and data structures."
# See- https://www.tidyverse.org/  and https://r4ds.had.co.nz/index.html
# Tidyverse has a lot to it, you might find it useful
#
# Piping is a way of writing a series of connected operations in a
# way that might be relatively efficient and intuitive
# part of a package witin the tidyverse package
###############################################################################

# install.packages("tidyverse")

library(tidyverse)

load("C:\\Users\\ytzhao\\Desktop\\Mike's Psychometrics\\In-class data\\panasmerged.Rdata")

#Example from earlier this semester (no piping)

by_sessex <- group_by(panasmerged, sexcat, sescat)                      # splits file by ses &  sex group, a plyr function
summarise(by_sessex, mean(pa, na.rm = TRUE))

# Piping logic:
# %>% indicates something like "send into"
# Eg, send an object into a function, the output then is sent 
# into another functoin, and so on 

panasmerged %>% 
  group_by(sexcat, sescat) %>% 
     summarise(mean(pa, na.rm = TRUE))  

# Note that piping eliminates the need to creates the "by_sessex" object
# This simplifies, reduces "clutter"

# Note: the use of separate lines is unnecessary, done here
# just to show the sequence more clearly
# I encourage you to use separate lines & spacing in a way that can help organize/clarify code.
# IF you use R, you'll develop your own "style" of conding

