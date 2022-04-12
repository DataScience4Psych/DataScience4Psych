nrsa.df <- read.csv("https://www.epa.gov/sites/production/files/2015-09/extbenthicrefcond.csv",
                    stringsAsFactors = FALSE)
metadata.df <- read.csv("https://www.epa.gov/sites/production/files/2015-09/extbenthicrefcond.txt",
                        stringsAsFactors = FALSE)


write.csv(nrsa.df,
          file.path("C:/Users/zmsmith.000/Desktop/r-markdown_crash-course",
                    "nrsa_metrics.csv"),
          row.names = FALSE)

write.csv(metadata.df,
          file.path("C:/Users/zmsmith.000/Desktop/r-markdown_crash-course",
                    "nrsa_metrics_metadata.csv"),
          row.names = FALSE)
