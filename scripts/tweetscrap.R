# adapted from: https://gist.github.com/mine-cetinkaya-rundel/03d7516dea1e5f2613a5d71c28edb08d
library(tidyverse)
library(rtweet)
library(glue)

tml <- get_timeline("CostcoRiceBag", n = 3200)

br <- tml %>%
  filter(is.na(in_reply_to_screen_name)) %>%
  slice(
    which(str_detect(text, "IS IT JUST ME")):
    max(which(str_detect(text, "[bB]lows")))
  ) %>%
  mutate(first_word = word(text, 1)) # updated to use stringr::word

glue_collapse(br$first_word, sep = " ")
