library(car)
library(tidyverse)

df <- cars

df <- df %>% filter(speed > 11)

plotdemo <- ggplot(df, aes(
  x = speed,
  y = dist, color = dist
)) +
  geom_point()

plotdemo +
  geom_line() +
  geom_smooth()
