

lapply(c("Cazenovia", "Otisco", "Onondaga"), function(lake.i) {
  rmarkdown::render("parameterized/param_template.Rmd",
                    params = list(lake = lake.i),
                    output_file = paste0(lake.i, ".HTML"))
})

