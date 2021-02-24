# Libraries
library(gt)
library(tidyverse)

# Functions
make_full = function(myurl,gituser="datascience4psych",myrepo="DataScience4Psych") {
  paste0('https://',gituser,'.github.io/',myrepo,'/',myurl)
}
make_hyperlink = function(myurl,mytext=myurl) {
  paste0('<a href="',myurl,'">',mytext,'</a>')
}

df_web=list.files(path="docs/", '[.]html$', recursive=TRUE)

df_slides=list.files(path="E:\\Dropbox\\Lab\\Teaching\\DS4P\\ds4p-materials\\slides", '[.]html$', recursive=TRUE)

df_docs=c(df_web,df_slides)

domain=c(rep("DataScience4Psych",length(df_web)),rep("slides",length(df_slides)))

df <- data.frame(
  stringsAsFactors = FALSE,
              title = str_replace(
                      str_remove_all(df_docs, "(u\\d_d\\d+|\\.html|[-])"),"/.*",""),
              link = make_full(df_docs,myrepo=domain)
)

df$title[df$link=="https://datascience4psych.github.io/slides/d13_goodviz/d13b_moreggplot.html"]<-"d13b_moreggplot"

write_csv(df,"data/ds4p_urls.csv")



