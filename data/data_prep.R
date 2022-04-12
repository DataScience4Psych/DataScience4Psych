# devtools::install_github("zsmith27/mmir")
library(mmir)

thesis.df <- read.csv(file.path("data", "zms_thesis.csv"),
                      stringsAsFactors = FALSE)

metrics.df <- thesis.df %>% 
  dplyr::select(-X) %>% 
  dplyr::group_nest(unique_id, lake, lat, long,
                    substrate_size_d50, conductivity) %>% 
  dplyr::mutate(richness = taxa_rich(.dataframe = .,
                                     .key_col = unique_id,
                                     # .counts_col = count,
                                     .group_col = final_id,
                                     .unnest = data),
                shannon = taxa_div(.dataframe = .,
                                   .key_col = unique_id,
                                   .counts_col = count,
                                   .group_col = final_id,
                                   .job = "shannon",
                                   .base = 2,
                                   .unnest = data),
                pct_ephemeroptera = taxa_pct(.dataframe = .,
                                             .key_col = unique_id,
                                             .counts_col = count,
                                             .filter = order %in% c("ephemeroptera"),
                                             .unnest = data),
                pct_amphipoda = taxa_pct(.dataframe = .,
                                         .key_col = unique_id,
                                         .counts_col = count,
                                         .filter = order %in% c("amphipoda"),
                                         .unnest = data),
                pct_diptera = taxa_pct(.dataframe = .,
                                       .key_col = unique_id,
                                       .counts_col = count,
                                       .filter = order %in% c("diptera"),
                                       .unnest = data),
                dom_1 = taxa_dom(.dataframe = .,
                                 .key_col = unique_id,
                                 .counts_col = count,
                                 .group_col = final_id,
                                 .dom_level = 1,
                                 .unnest = data)
  ) %>% 
  dplyr::select(-data)

write.csv(metrics.df,
          file.path("data", "zms_thesis_metrics.csv"),
          row.names = FALSE)
