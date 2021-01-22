
library(gt)
library(tidyverse)


make_full = function(myurl,gituser="datascience4psych",myrepo="DataScience4Psych") {
  paste0('https://',gituser,'.github.io/',myrepo,'/',myurl)
}
make_hyperlink = function(myurl,mytext=myurl) {
  paste0('<a href="',myurl,'">',mytext,'</a>')
}

df_docs=list.files(path="docs/", '[.]html$', recursive=TRUE)

df <- data.frame(
  stringsAsFactors = FALSE,
              title = str_replace_all(str_remove(df_docs, "\\.html"),"[_-]"," "),
              link = make_full(df_docs)
)


df %>%
    mutate(
        link = glue::glue("[slides]({link})"),
        link = map(link, gt::md)) %>%
    gt()

